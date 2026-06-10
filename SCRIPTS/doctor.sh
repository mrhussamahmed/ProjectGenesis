#!/usr/bin/env bash
# doctor.sh: one fast (<2s), read-only orientation/status command. Prints
# repo facts and actionable warnings, then ALWAYS exits 0 — warnings are
# text, not failures. Gating belongs to SCRIPTS/validate-bootstrap.sh and
# the hooks, never to this script.
#
# Reports: branch + dirty count; hook installation; session profile /
# validator level / TTL; AI_HANDOFF.md baseline freshness; intake queue
# depth (00_intake/raw files missing from SOURCE_REGISTRY.md); active
# backlog items.
#
# Bash 3.2 compatible (macOS /bin/bash and Linux). No writes.

set -u

repo_root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$repo_root" 2>/dev/null || exit 0

warn_count=0
note() { printf '%s\n' "$1"; }
warn() { printf 'WARN: %s\n' "$1"; warn_count=$((warn_count + 1)); }

note "ProjectGenesis doctor (read-only; never blocks)"
note "------------------------------------------------"

# 1. Branch + dirty count.
branch="$(git branch --show-current 2>/dev/null)"
if [[ -z "$branch" ]]; then
  branch="(detached or no git repo)"
fi
dirty_count="$(git status --porcelain 2>/dev/null | grep -c . || true)"
note "branch: $branch (dirty files: ${dirty_count:-0})"

# 2. Hooks installed?
hooks_path="$(git config core.hooksPath 2>/dev/null || true)"
if [[ "$hooks_path" == ".githooks" ]]; then
  note "hooks: installed (core.hooksPath=.githooks)"
else
  warn "hooks not installed; fix: git config core.hooksPath .githooks"
fi

# 3. Session profile / validator level / TTL.
if [[ -f SCRIPTS/operation-profile.sh ]]; then
  profile="$(bash SCRIPTS/operation-profile.sh 2>/dev/null || echo unknown)"
  level="$(bash SCRIPTS/operation-profile.sh --validator-level 2>/dev/null || echo strict)"
  note "session: profile=$profile validator-level=$level"
  if [[ -f .ai/SESSION.md ]]; then
    epoch="$(awk -F: '$1 == "updated_at_epoch" { v = $2; gsub(/[ \t]/, "", v); print v; exit }' .ai/SESSION.md 2>/dev/null)"
    ttl="${BOOTSTRAP_SESSION_TTL_SECONDS:-43200}"
    if [[ "$epoch" =~ ^[0-9]+$ ]] && [[ "$ttl" =~ ^[0-9]+$ ]]; then
      now="$(date +%s)"
      left=$(( epoch + ttl - now ))
      if (( left <= 0 )); then
        warn "session expired $(( (0 - left) / 60 )) min ago; refresh: bash SCRIPTS/session.sh touch"
      elif [[ "$profile" == "unknown" ]]; then
        warn "session file present but ineffective (branch mismatch or invalid profile); rewrite: bash SCRIPTS/session.sh start <profile>"
      else
        note "session: TTL $(( left / 60 )) min remaining"
      fi
    else
      warn "session has no numeric updated_at_epoch; rewrite: bash SCRIPTS/session.sh start <profile>"
    fi
  else
    note "session: none (.ai/SESSION.md absent; start one: bash SCRIPTS/session.sh start <profile>)"
  fi
else
  note "session: SCRIPTS/operation-profile.sh not found; validation routes strict"
fi

# 4. AI_HANDOFF.md baseline freshness vs last commit date.
if [[ -f AI_HANDOFF.md ]]; then
  handoff_date="$(awk '/^## Current Date$/ { while ((getline line) > 0) { if (line ~ /[^ \t]/) { print line; exit } } }' AI_HANDOFF.md 2>/dev/null)"
  if [[ ! "$handoff_date" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
    handoff_date="$(awk -F': *' '$1 == "updated" { print $2; exit }' AI_HANDOFF.md 2>/dev/null)"
  fi
  last_commit_date="$(git log -1 --format=%cs 2>/dev/null)"
  if [[ "$handoff_date" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ && "$last_commit_date" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
    if [[ "$handoff_date" < "$last_commit_date" ]]; then
      warn "AI_HANDOFF.md baseline date ($handoff_date) is older than the last commit ($last_commit_date); refresh it if durable truth changed"
    else
      note "handoff: AI_HANDOFF.md baseline date $handoff_date (last commit $last_commit_date)"
    fi
  else
    note "handoff: could not compare AI_HANDOFF.md date ('${handoff_date:-none}') with git log"
  fi
else
  warn "AI_HANDOFF.md not found"
fi

# 5. Intake queue: raw files not yet registered in the source registry.
intake_total=0
intake_unregistered=0
if [[ -d 00_intake/raw ]]; then
  for raw_file in 00_intake/raw/*; do
    [[ -f "$raw_file" ]] || continue
    intake_total=$((intake_total + 1))
    raw_base="$(basename "$raw_file")"
    if ! grep -Fq "$raw_base" 00_intake/SOURCE_REGISTRY.md 2>/dev/null; then
      intake_unregistered=$((intake_unregistered + 1))
    fi
  done
fi
if (( intake_unregistered > 0 )); then
  warn "intake queue: $intake_unregistered of $intake_total file(s) in 00_intake/raw/ missing from 00_intake/SOURCE_REGISTRY.md"
else
  note "intake queue: $intake_total raw file(s), all registered"
fi

# 6. Active backlog items (status in-progress or in-review).
if [[ -f BACKLOG/BACKLOG_INDEX.md ]]; then
  active_items="$(awk -F'|' '
    /^\|/ {
      status = $5
      gsub(/^[ \t]+|[ \t]+$/, "", status)
      if (status == "in-progress" || status == "in-review") {
        id = $2
        gsub(/^[ \t]+|[ \t]+$/, "", id)
        print "  - " id " (" status ")"
      }
    }
  ' BACKLOG/BACKLOG_INDEX.md 2>/dev/null)"
  if [[ -n "$active_items" ]]; then
    note "active backlog items:"
    printf '%s\n' "$active_items"
  else
    note "active backlog items: none (no in-progress/in-review rows in BACKLOG/BACKLOG_INDEX.md)"
  fi
else
  note "active backlog items: BACKLOG/BACKLOG_INDEX.md not found"
fi

note "------------------------------------------------"
note "doctor done: $warn_count warning(s); exit 0 always"
exit 0
