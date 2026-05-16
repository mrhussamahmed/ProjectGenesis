#!/usr/bin/env bash
set -euo pipefail

# metric-evidence-coverage.sh — Report evidence-coverage metrics.
#
# Counts how much of the repository's authority-bearing material carries
# explicit "Source IDs" evidence. This is a first empirical measurement,
# not a generalized claim about review quality or anti-hallucination
# effectiveness.
#
# Reports two complementary numbers:
#   - spec_fr_source_coverage: fraction of approved/active spec FR/NFR rows
#     that name a non-empty, non-"none" Source IDs column. The validator
#     already requires this; the metric exists so changes are observable.
#   - backlog_source_coverage: fraction of `BACKLOG/BOOT-*.md` files that
#     name at least one cited Source ID (non-"none") in their "Source IDs:"
#     field, treating an explicit "none; ..." narrative as zero so the
#     metric tracks downstream growth.
#
# Output is line-oriented `key: numerator/denominator (percent%)` so it is
# easy to grep, pipe, or diff.

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

# -----------------------------------------------------------------------------
# spec_fr_source_coverage
# -----------------------------------------------------------------------------

spec_total=0
spec_with_source=0
while IFS= read -r file; do
  if ! grep -Eq '^status: (approved|active)$' "$file"; then
    continue
  fi
  while IFS='|' read -r kind id; do
    case "$kind" in
      total) spec_total=$((spec_total + 1)) ;;
      with_source) spec_with_source=$((spec_with_source + 1)) ;;
    esac
  done < <(awk -F'|' '
    function trim(value) {
      gsub(/^[ \t]+|[ \t]+$/, "", value)
      return value
    }
    /^\|/ {
      first = trim($2)
      if (first == "ID") {
        source_col = 0
        for (i = 2; i < NF; i++) {
          header = tolower(trim($i))
          if (header == "source" || header == "source ids") {
            source_col = i
          }
        }
        next
      }
      if (first ~ /(^|-)FR-[A-Za-z0-9]/ || first ~ /(^|-)NFR-[A-Za-z0-9]/) {
        print "total|" first
        if (source_col == 0) {
          next
        }
        value = trim($(source_col))
        if (value != "" && tolower(value) != "none") {
          print "with_source|" first
        }
      }
    }
  ' "$file")
done < <(find SPECS -maxdepth 1 -type f -name '*.md' -print 2>/dev/null)

emit_metric "spec_fr_source_coverage" "$spec_with_source" "$spec_total"

# -----------------------------------------------------------------------------
# backlog_source_coverage
# -----------------------------------------------------------------------------

backlog_total=0
backlog_with_source=0
if [[ -d BACKLOG ]]; then
  while IFS= read -r file; do
    backlog_total=$((backlog_total + 1))
    value="$(awk '
      tolower($0) ~ /^- source ids:/ {
        sub(/^[^:]*:[ ]*/, "")
        sub(/[ ]*$/, "")
        print
        exit
      }
    ' "$file")"
    if [[ -z "$value" ]]; then
      continue
    fi
    lower="$(printf '%s' "$value" | tr '[:upper:]' '[:lower:]')"
    if [[ "$lower" == none* ]] || [[ "$lower" == "n/a" ]]; then
      continue
    fi
    backlog_with_source=$((backlog_with_source + 1))
  done < <(find BACKLOG -maxdepth 1 -type f -name 'BOOT-*.md' -print 2>/dev/null)
fi

emit_metric "backlog_source_coverage" "$backlog_with_source" "$backlog_total"
