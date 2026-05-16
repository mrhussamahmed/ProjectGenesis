#!/usr/bin/env bash
set -euo pipefail

# metric-acceptance-coverage.sh — Report acceptance-criteria coverage.
#
# Reads `TESTS/ACCEPTANCE_CRITERIA_MAP.md` and reports the fraction of
# criterion rows that name at least one test artifact (review record,
# validator script, red-check script, manual checklist, CI workflow, or
# similar) in the `Test File Or Checklist` column.
#
# This is a first empirical measurement of acceptance-criteria coverage on
# the current scaffold. It does not validate that the named tests pass; the
# bootstrap validator and red-check fixtures cover those mechanics.
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

map_file="TESTS/ACCEPTANCE_CRITERIA_MAP.md"
if [[ ! -f "$map_file" ]]; then
  echo "ERROR: missing acceptance criteria map: $map_file" >&2
  exit 1
fi

total=0
with_test=0
passed=0
while IFS='|' read -r kind id; do
  case "$kind" in
    total) total=$((total + 1)) ;;
    with_test) with_test=$((with_test + 1)) ;;
    passed) passed=$((passed + 1)) ;;
  esac
done < <(awk -F'|' '
  function trim(value) {
    gsub(/^[ \t]+|[ \t]+$/, "", value)
    return value
  }
  /^\| / && $2 !~ /Spec/ && $2 !~ /----/ && NF >= 7 {
    spec = trim($2)
    ac = trim($3)
    test_file = trim($5)
    status = tolower(trim($6))
    if (spec == "" || ac == "" || spec == "none") {
      next
    }
    print "total|" ac
    if (test_file != "" && tolower(test_file) != "none") {
      print "with_test|" ac
    }
    if (status == "passed") {
      print "passed|" ac
    }
  }
' "$map_file")

emit_metric "ac_with_test_artifact" "$with_test" "$total"
emit_metric "ac_status_passed" "$passed" "$total"
