#!/usr/bin/env bash
# operation-profile.sh: read a local `.ai/SESSION.md` operation profile hint,
# falling back to AI_HANDOFF.md's legacy "Pre-Change Classification" section,
# and emit the Operation profile value to stdout.
#
# Output is one of:
#   - docs-trivial
#   - docs-non-authoritative
#   - state-sync
#   - planning-governance
#   - docs-public-claim
#   - strict-protected
#   - process-light-exception
#   - unknown (if no valid local or legacy profile is present)
#
# Side-channel: maps profiles to validator levels via stdout when the
# caller passes the `--validator-level` flag instead of the raw profile.
# Validator levels:
#   - shape-only: required files + YAML metadata only (fast path)
#   - state-sync: shape-only + AI_HANDOFF sections + registry registration
#   - strict: everything (default)
#
# Strict gates remain strict: this script reports a profile hint only. The
# decision to actually use a non-strict validator level is made by the hook
# layer, which also checks that the staged file set does not include any
# strict-gate path.

set -euo pipefail

repo_root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$repo_root"

mode="profile"
if [[ "${1:-}" == "--validator-level" ]]; then
  mode="validator-level"
fi

is_known_profile() {
  case "$1" in
    docs-trivial|docs-non-authoritative|state-sync|planning-governance|docs-public-claim|strict-protected|process-light-exception)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

extract_local_session_value() {
  local key="$1"
  local file=".ai/SESSION.md"
  awk -F: -v wanted="$key" '
    $1 ~ "^[[:space:]]*" wanted "[[:space:]]*$" {
      value = $2
      gsub(/`/, "", value)
      gsub(/^[ \t]+|[ \t]+$/, "", value)
      sub(/[[:space:]].*$/, "", value)
      print value
      found = 1
      exit
    }
    END { if (!found) print "" }
  ' "$file"
}

extract_profile_from_local_session() {
  local file=".ai/SESSION.md"
  if [[ ! -f "$file" ]]; then
    echo "unknown"
    return
  fi

  local profile branch updated_at_epoch current_branch now_epoch session_ttl_seconds
  profile="$(extract_local_session_value "operation_profile")"
  branch="$(extract_local_session_value "branch")"
  updated_at_epoch="$(extract_local_session_value "updated_at_epoch")"

  if [[ -z "$profile" || -z "$branch" || -z "$updated_at_epoch" ]]; then
    echo "unknown"
    return
  fi

  if ! is_known_profile "$profile"; then
    echo "unknown"
    return
  fi

  current_branch="$(git branch --show-current 2>/dev/null || true)"
  if [[ -z "$current_branch" || "$branch" != "$current_branch" ]]; then
    echo "unknown"
    return
  fi

  if [[ ! "$updated_at_epoch" =~ ^[0-9]+$ ]]; then
    echo "unknown"
    return
  fi

  now_epoch="$(date +%s)"
  session_ttl_seconds="${BOOTSTRAP_SESSION_TTL_SECONDS:-43200}"
  if [[ ! "$session_ttl_seconds" =~ ^[0-9]+$ ]]; then
    echo "unknown"
    return
  fi

  if (( now_epoch - updated_at_epoch > session_ttl_seconds )); then
    echo "unknown"
    return
  fi

  echo "$profile"
}

extract_profile_from_legacy_handoff() {
  local file="AI_HANDOFF.md"
  if [[ ! -f "$file" ]]; then
    echo "unknown"
    return
  fi

  # Scan from the end of the file backwards for the most recent
  # "Pre-Change Classification" header, then look for "Operation profile:"
  # inside that section up to the next "## " header.
  awk '
    BEGIN { in_section = 0; profile = "unknown" }
    /^## .*Pre-Change Classification/ {
      in_section = 1
      next
    }
    /^## / {
      in_section = 0
      next
    }
    in_section && /Operation profile:/ {
      # Extract value, accept either `Operation profile: \`<X>\`` or
      # `Operation profile: <X>` forms.
      line = $0
      sub(/^.*Operation profile:[[:space:]]*/, "", line)
      gsub(/`/, "", line)
      sub(/[[:space:]].*$/, "", line)
      sub(/\..*$/, "", line)
      if (line != "") profile = line
    }
    END { print profile }
  ' "$file"
}

extract_profile() {
  local profile
  profile="$(extract_profile_from_local_session)"
  if [[ "$profile" != "unknown" ]]; then
    echo "$profile"
    return
  fi

  profile="$(extract_profile_from_legacy_handoff)"
  if is_known_profile "$profile"; then
    echo "$profile"
  else
    echo "unknown"
  fi
}

profile_to_validator_level() {
  local p="$1"
  # In slice 4 the validator supports two levels: strict (default) and
  # shape-only (fast path). Future slices may add an intermediate
  # state-sync level. Until then, only the two lightest profiles route to
  # shape-only; everything else stays strict.
  case "$p" in
    docs-trivial|process-light-exception)
      echo "shape-only"
      ;;
    *)
      echo "strict"
      ;;
  esac
}

profile="$(extract_profile)"

if [[ "$mode" == "validator-level" ]]; then
  profile_to_validator_level "$profile"
else
  echo "$profile"
fi
