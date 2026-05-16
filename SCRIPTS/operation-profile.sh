#!/usr/bin/env bash
# operation-profile.sh: read AI_HANDOFF.md's most recent "Pre-Change
# Classification" section and emit the Operation profile value to stdout.
#
# Output is one of:
#   - docs-trivial
#   - docs-non-authoritative
#   - state-sync
#   - planning-governance
#   - docs-public-claim
#   - strict-protected
#   - process-light-exception
#   - unknown (if no profile or AI_HANDOFF.md missing)
#
# Side-channel: maps profiles to validator levels via stdout when the
# caller passes the `--validator-level` flag instead of the raw profile.
# Validator levels:
#   - shape-only: required files + YAML metadata only (fast path)
#   - state-sync: shape-only + AI_HANDOFF sections + registry registration
#   - strict: everything (default)
#
# Strict gates remain strict: this script reports profile-as-recorded.
# The decision to actually use a non-strict validator level is made by the
# hook layer, which also checks that the staged file set does not include
# any strict-gate path.

set -euo pipefail

repo_root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$repo_root"

mode="profile"
if [[ "${1:-}" == "--validator-level" ]]; then
  mode="validator-level"
fi

extract_profile() {
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
