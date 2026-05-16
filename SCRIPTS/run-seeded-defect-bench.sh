#!/usr/bin/env bash
set -euo pipefail

# run-seeded-defect-bench.sh — Run the seeded-defect benchmark.
#
# Builds on the existing `SCRIPTS/validate-bootstrap-red-checks.sh` harness,
# which seeds a temporary fixture per case and verifies that the bootstrap
# validator detects the planted defect. The benchmark wraps that harness so
# that the detection rate can be recorded as a single comparable number on
# every revision.
#
# This is the BOOT-032 first empirical evidence run. It does not generalize
# to other models or project types and does not gate CI. Future expansions
# should add new seed categories to
# `TESTS/ADVERSARIAL_SEED_BENCHMARK.md` plus matching fixtures in
# `SCRIPTS/validate-bootstrap-red-checks.sh`.

repo_root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$repo_root"

red_checks="SCRIPTS/validate-bootstrap-red-checks.sh"
if [[ ! -x "$red_checks" ]] && ! command -v bash >/dev/null 2>&1; then
  echo "ERROR: cannot invoke $red_checks" >&2
  exit 1
fi

tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/seeded-defect-bench.XXXXXX")"
trap 'rm -rf "$tmp_dir"' EXIT

run_log="$tmp_dir/red-checks.log"
red_status=0
if ! bash "$red_checks" >"$run_log" 2>&1; then
  red_status=$?
fi

# The red-check harness invokes each `case_*` function once and records
# `FAIL: ...` lines for the cases that did not behave as expected. A pass
# means the harness exited 0 and printed `Bootstrap red checks passed.`,
# at which point every seeded-defect case detected its planted defect.
detected_cases="$(grep -cE '^case_[A-Za-z0-9_]+\(\)' "$red_checks" || true)"
case_failures="$(grep -c '^FAIL: ' "$run_log" || true)"
case_passes=$((detected_cases - case_failures))
if [[ "$case_passes" -lt 0 ]]; then
  case_passes=0
fi

percent="n/a"
if [[ "$detected_cases" -gt 0 ]]; then
  percent="$(awk -v n="$case_passes" -v d="$detected_cases" 'BEGIN { printf "%.0f%%", (n / d) * 100 }')"
fi

printf 'seeded_defect_cases: %d\n' "$detected_cases"
printf 'seeded_defect_detected: %d\n' "$case_passes"
printf 'seeded_defect_detection_rate: %s\n' "$percent"
printf 'red_check_harness_status: %d\n' "$red_status"

if [[ "$case_failures" -gt 0 ]]; then
  echo "---"
  echo "Cases that did not detect the seeded defect (review needed):"
  grep '^FAIL: ' "$run_log" || true
fi

# Exit 0 even when the harness reports failures: the benchmark records a
# baseline measurement and intentionally does not gate CI on the result.
# Run `bash SCRIPTS/validate-bootstrap-red-checks.sh` directly when you
# want a strict pass/fail signal.
exit 0
