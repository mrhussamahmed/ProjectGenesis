#!/usr/bin/env bash
set -euo pipefail

# metric-traceability-completeness.sh — Report traceability completeness.
#
# Reads `TRACEABILITY_MATRIX.md` `## Bootstrap Requirements` table and
# reports two metrics:
#
#   - req_with_changed_files: fraction of REQ-* rows that name at least one
#     non-empty, non-"none" path in the "Changed Files" column.
#   - req_with_test_evidence: fraction of REQ-* rows that name at least one
#     non-empty, non-"none" entry in the "Tests" column.
#
# This is a first empirical measurement of bootstrap traceability coverage.
# It does not validate that the named files exist or that the named tests
# pass; the bootstrap validator covers required-file existence separately.
#
# Output is line-oriented `key: numerator/denominator (percent%)`.

repo_root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$repo_root"

emit_metric() {
  local label="$1"
  local numerator="$2"
  local denominator="$3"
  local percent
  if [[ "$denominator" -eq 0 ]]; then
    percent="n/a"
  else
    percent="$(awk -v n="$numerator" -v d="$denominator" 'BEGIN { printf "%.0f%%", (n / d) * 100 }')"
  fi
  printf '%s: %d/%d (%s)\n' "$label" "$numerator" "$denominator" "$percent"
}

trace_file="TRACEABILITY_MATRIX.md"
if [[ ! -f "$trace_file" ]]; then
  echo "ERROR: missing traceability matrix: $trace_file" >&2
  exit 1
fi

total=0
with_changed=0
with_tests=0
while IFS='|' read -r kind id; do
  case "$kind" in
    total) total=$((total + 1)) ;;
    with_changed) with_changed=$((with_changed + 1)) ;;
    with_tests) with_tests=$((with_tests + 1)) ;;
  esac
done < <(awk -F'|' '
  function trim(value) {
    gsub(/^[ \t]+|[ \t]+$/, "", value)
    return value
  }
  /^## / {
    in_rows = ($0 ~ /^## Rows/)
    next
  }
  in_rows && /^\| TRACE-/ {
    req = trim($2)
    changed_files = trim($7)
    tests = trim($8)
    print "total|" req
    if (changed_files != "" && tolower(changed_files) != "none") {
      print "with_changed|" req
    }
    if (tests != "" && tolower(tests) != "none") {
      print "with_tests|" req
    }
  }
' "$trace_file")

emit_metric "req_with_changed_files" "$with_changed" "$total"
emit_metric "req_with_test_evidence" "$with_tests" "$total"
