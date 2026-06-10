#!/usr/bin/env bash
# session.sh: manage the gitignored local fast-path session file
# `.ai/SESSION.md` that SCRIPTS/operation-profile.sh reads (fail-closed:
# branch must match, epoch must be fresh within the TTL, profile must be on
# the allowlist; otherwise validation routes strict).
#
# Subcommands:
#   start <profile> [task-note...]  Write .ai/SESSION.md with the machine
#                                   keys (operation_profile, branch,
#                                   updated_at_epoch, task).
#   touch                           Refresh updated_at_epoch on the session.
#   status                          Print recorded profile, effective
#                                   profile, validator level, TTL remaining.
#   clear                           Delete .ai/SESSION.md (routes strict).
#
# Free-form notes below the marker line are preserved across start/touch.
# Format starter: TEMPLATE_STARTERS/SESSION.md. The session file is a local
# resume aid only — never source of truth.
#
# Bash 3.2 compatible (macOS /bin/bash and Linux).

set -euo pipefail

repo_root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$repo_root"

session_file=".ai/SESSION.md"
notes_marker="--- free notes below; session.sh preserves this section ---"

usage() {
  echo "usage: session.sh start <profile> [task-note...] | touch | status | clear" >&2
  echo "allowed profiles (from SCRIPTS/operation-profile.sh):" >&2
  allowed_profiles | sed 's/^/  - /' >&2
}

allowed_profiles() {
  # Single source of truth: the is_known_profile() allowlist inside
  # SCRIPTS/operation-profile.sh. Fall back to the documented list when
  # parsing fails so this helper never accepts an unroutable profile.
  local parsed=""
  if [[ -f SCRIPTS/operation-profile.sh ]]; then
    parsed="$(awk '/^is_known_profile\(\)/,/^\}/' SCRIPTS/operation-profile.sh \
      | grep -E '^[[:space:]]*[a-z][a-z-]*(\|[a-z][a-z-]*)+\)[[:space:]]*$' \
      | head -n 1 | tr -d ' )' || true)"
  fi
  if [[ -z "$parsed" ]]; then
    parsed='docs-trivial|docs-non-authoritative|state-sync|planning-governance|docs-public-claim|strict-protected|process-light-exception'
  fi
  printf '%s\n' "$parsed" | tr '|' '\n'
}

is_allowed_profile() {
  allowed_profiles | grep -qxF "$1"
}

read_session_value() {
  # Print the value of a `key: value` line from the session file ("" if
  # absent). Keeps the full remainder of the line, unlike the stricter
  # single-token extraction in operation-profile.sh.
  local key="$1"
  if [[ ! -f "$session_file" ]]; then
    echo ""
    return
  fi
  awk -F: -v wanted="$key" '
    $1 ~ "^[[:space:]]*" wanted "[[:space:]]*$" {
      value = $0
      sub(/^[^:]*:[[:space:]]*/, "", value)
      gsub(/[ \t]+$/, "", value)
      print value
      found = 1
      exit
    }
    END { if (!found) print "" }
  ' "$session_file"
}

preserved_notes() {
  if [[ ! -f "$session_file" ]]; then
    return 0
  fi
  awk -v marker="$notes_marker" '
    found { print }
    $0 == marker { found = 1 }
  ' "$session_file"
}

write_session() {
  local profile="$1"
  local task="$2"
  local branch epoch notes
  branch="$(git branch --show-current 2>/dev/null || true)"
  if [[ -z "$branch" ]]; then
    echo "session.sh: cannot determine the current branch (detached HEAD or no git repo); a session would never match and is not written." >&2
    exit 1
  fi
  epoch="$(date +%s)"
  notes="$(preserved_notes)"
  mkdir -p .ai
  {
    printf '%s\n' "# Local Session (gitignored; local resume aid only, never source of truth)"
    printf '\n'
    printf 'operation_profile: %s\n' "$profile"
    printf 'branch: %s\n' "$branch"
    printf 'updated_at_epoch: %s\n' "$epoch"
    printf 'task: %s\n' "$task"
    printf '\n'
    printf '%s\n' "$notes_marker"
    if [[ -n "$notes" ]]; then
      printf '%s\n' "$notes"
    fi
  } > "$session_file"
}

print_status() {
  local recorded effective level epoch ttl now left
  recorded="$(read_session_value operation_profile)"
  if [[ -f "$session_file" ]]; then
    echo "session file      : $session_file (present)"
    echo "recorded profile  : ${recorded:-none}"
    echo "recorded task     : $(read_session_value task)"
  else
    echo "session file      : $session_file (absent; validation routes strict)"
  fi
  effective="unknown"
  level="strict"
  if [[ -f SCRIPTS/operation-profile.sh ]]; then
    effective="$(bash SCRIPTS/operation-profile.sh 2>/dev/null || echo unknown)"
    level="$(bash SCRIPTS/operation-profile.sh --validator-level 2>/dev/null || echo strict)"
  fi
  echo "effective profile : $effective (via operation-profile.sh; fail-closed)"
  echo "validator level   : $level"
  epoch="$(read_session_value updated_at_epoch)"
  ttl="${BOOTSTRAP_SESSION_TTL_SECONDS:-43200}"
  if [[ "$epoch" =~ ^[0-9]+$ ]] && [[ "$ttl" =~ ^[0-9]+$ ]]; then
    now="$(date +%s)"
    left=$(( epoch + ttl - now ))
    if (( left > 0 )); then
      echo "session TTL       : $(( left / 60 )) min remaining (of $(( ttl / 60 )) min)"
    else
      echo "session TTL       : expired $(( (0 - left) / 60 )) min ago; profile routes strict (run: session.sh touch)"
    fi
  elif [[ -f "$session_file" ]]; then
    echo "session TTL       : no numeric updated_at_epoch recorded; profile routes strict"
  fi
}

cmd="${1:-}"
case "$cmd" in
  start)
    shift
    profile="${1:-}"
    if [[ -z "$profile" ]]; then
      usage
      exit 2
    fi
    shift
    task="${*:-none}"
    if ! is_allowed_profile "$profile"; then
      echo "session.sh: unknown operation profile '$profile'." >&2
      usage
      exit 1
    fi
    write_session "$profile" "$task"
    echo "session.sh: wrote $session_file"
    print_status
    ;;
  touch)
    if [[ ! -f "$session_file" ]]; then
      echo "session.sh: no $session_file to refresh; run 'session.sh start <profile>' first." >&2
      exit 1
    fi
    profile="$(read_session_value operation_profile)"
    if [[ -z "$profile" ]] || ! is_allowed_profile "$profile"; then
      echo "session.sh: existing session has no valid operation_profile; run 'session.sh start <profile>'." >&2
      exit 1
    fi
    task="$(read_session_value task)"
    write_session "$profile" "${task:-none}"
    echo "session.sh: refreshed updated_at_epoch in $session_file"
    print_status
    ;;
  status)
    print_status
    ;;
  clear)
    rm -f "$session_file"
    echo "session.sh: removed $session_file (validation now routes strict)."
    ;;
  *)
    usage
    exit 2
    ;;
esac
