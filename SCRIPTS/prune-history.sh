#!/usr/bin/env bash
# prune-history.sh: rotate old WORKLOG index rows and old REVIEWS records
# into MAINTAINER_ARCHIVE/ (GEN-17/AUTO-8).
#
# The GEN-16 rotation cap says WORKLOG/WORKLOG_INDEX.md keeps at most 10
# rows and REVIEWS/ keeps only recent records; older history rotates to
# MAINTAINER_ARCHIVE/. This script automates that rotation.
#
# Usage:
#   bash SCRIPTS/prune-history.sh                  # dry-run (default)
#   bash SCRIPTS/prune-history.sh --dry-run
#   bash SCRIPTS/prune-history.sh --apply
#   bash SCRIPTS/prune-history.sh --apply --keep-worklog-rows 10 --keep-review-files 3
#
# Behavior:
#   1. WORKLOG/WORKLOG_INDEX.md: when the Worklogs table holds more than
#      --keep-worklog-rows rows (default 10), the oldest excess rows are
#      appended to MAINTAINER_ARCHIVE/snapshots/WORKLOG_INDEX-rotated.md
#      and removed from the live table. Rows are ordered by their Date
#      column (newest kept).
#   2. REVIEWS/: REVIEW-*.md and PR_REVIEW_PACKAGE-*.md files (never
#      REVIEW_INDEX.md or templates/) beyond --keep-review-files most
#      recent (default 3, by filename sort, which embeds the date) are
#      moved to MAINTAINER_ARCHIVE/REVIEWS/. References to the moved
#      files in REVIEWS/REVIEW_INDEX.md and ARTIFACT_REGISTRY.md are
#      rewritten to the archive path so the indexes stay truthful.
#
# Dry-run prints every planned move and rewrite and changes nothing.
# The script refuses to run outside the maintainer repository (it
# requires MAINTAINER_ARCHIVE/ to exist or --apply to create it is
# rejected when the directory is absent in dry-run output).

set -euo pipefail

repo_root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$repo_root"

mode="dry-run"
keep_worklog_rows=10
keep_review_files=3

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) mode="dry-run"; shift ;;
    --apply) mode="apply"; shift ;;
    --keep-worklog-rows) keep_worklog_rows="${2:?--keep-worklog-rows needs a value}"; shift 2 ;;
    --keep-review-files) keep_review_files="${2:?--keep-review-files needs a value}"; shift 2 ;;
    -h|--help)
      sed -n '2,30p' "$0" | sed 's/^# \{0,1\}//'
      exit 0
      ;;
    *)
      echo "prune-history: unknown argument: $1" >&2
      exit 2
      ;;
  esac
done

if [[ ! "$keep_worklog_rows" =~ ^[0-9]+$ || ! "$keep_review_files" =~ ^[0-9]+$ ]]; then
  echo "prune-history: keep counts must be non-negative integers" >&2
  exit 2
fi

if [[ ! -d MAINTAINER_ARCHIVE ]]; then
  echo "prune-history: MAINTAINER_ARCHIVE/ not found; this is a maintainer-only tool. Nothing to do." >&2
  exit 1
fi

changes=0

git_available() {
  git rev-parse --git-dir >/dev/null 2>&1
}

move_file() {
  local src="$1" dest="$2"
  if [[ "$mode" == "apply" ]]; then
    mkdir -p "$(dirname "$dest")"
    if git_available; then
      git mv "$src" "$dest"
    else
      mv "$src" "$dest"
    fi
  fi
  echo "rotate: $src -> $dest"
  changes=$((changes + 1))
}

rewrite_reference() {
  local file="$1" old="$2" new="$3"
  if grep -Fq "$old" "$file"; then
    if [[ "$mode" == "apply" ]]; then
      python3 - "$file" "$old" "$new" <<'PYEOF'
import sys
path, old, new = sys.argv[1], sys.argv[2], sys.argv[3]
s = open(path).read()
open(path, "w").write(s.replace(old, new))
PYEOF
    fi
    echo "rewrite: $file: $old -> $new"
    changes=$((changes + 1))
  fi
}

# --- 1. WORKLOG index row rotation -----------------------------------------

worklog_index="WORKLOG/WORKLOG_INDEX.md"
rotated_snapshot="MAINTAINER_ARCHIVE/snapshots/WORKLOG_INDEX-rotated.md"

if [[ -f "$worklog_index" ]]; then
  # Worklog table rows start with "| WORKLOG-". Sort by the Date column
  # (field 3) descending so the newest rows are kept.
  worklog_rows="$(grep -E '^\| WORKLOG-' "$worklog_index" || true)"
  if [[ -n "$worklog_rows" ]]; then
    row_count="$(printf '%s\n' "$worklog_rows" | wc -l | tr -d ' ')"
    if (( row_count > keep_worklog_rows )); then
      excess=$((row_count - keep_worklog_rows))
      # Oldest rows (lowest date) rotate out.
      # Use a scratch variable for the date key: assigning to an awk field
      # would rebuild $0 with spaces and corrupt the row text.
      rotate_rows="$(printf '%s\n' "$worklog_rows" \
        | awk -F'|' '{ d = $3; gsub(/^[ \t]+|[ \t]+$/, "", d); print d "\t" $0 }' \
        | sort -t$'\t' -k1,1 \
        | head -n "$excess" \
        | cut -f2-)"
      while IFS= read -r row; do
        echo "rotate-row: $worklog_index -> $rotated_snapshot: ${row:0:80}..."
        changes=$((changes + 1))
      done <<< "$rotate_rows"
      if [[ "$mode" == "apply" ]]; then
        mkdir -p "$(dirname "$rotated_snapshot")"
        if [[ ! -f "$rotated_snapshot" ]]; then
          {
            echo "# Rotated Worklog Index Rows"
            echo
            echo "Rows rotated out of \`WORKLOG/WORKLOG_INDEX.md\` by"
            echo "\`SCRIPTS/prune-history.sh\` (GEN-16 rotation cap)."
            echo
            echo "| Worklog ID | Date | Subject | File | Notes |"
            echo "|------------|------|---------|------|-------|"
          } > "$rotated_snapshot"
        fi
        printf '%s\n' "$rotate_rows" >> "$rotated_snapshot"
        # Pass the rows via the environment with a quoted heredoc so
        # backticks and dollar signs inside row text are never expanded.
        PRUNE_ROTATE_ROWS="$rotate_rows" python3 - "$worklog_index" <<'PYEOF'
import os, sys
path = sys.argv[1]
rotate = set(os.environ["PRUNE_ROTATE_ROWS"].splitlines())
lines = open(path).read().splitlines(keepends=True)
out = [l for l in lines if l.rstrip("\n") not in rotate]
open(path, "w").writelines(out)
PYEOF
      fi
    fi
  fi
fi

# --- 2. REVIEWS file rotation -----------------------------------------------

# Each review file gets a date key: the YYYY-MM-DD embedded in the
# filename when present, otherwise the file's last git commit date, with
# the filesystem mtime as a final fallback. Sorting on the key (oldest
# first) keeps undated PR_REVIEW_PACKAGE-* records in true age order
# instead of always rotating first by alphabetical accident.
review_file_date_key() {
  local f="$1" base key
  base="$(basename "$f")"
  key="$(printf '%s' "$base" | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}' | head -n 1 || true)"
  if [[ -z "$key" ]] && git_available; then
    key="$(git log -1 --format=%cs -- "$f" 2>/dev/null || true)"
  fi
  if [[ -z "$key" ]]; then
    key="$(date -r "$f" +%Y-%m-%d 2>/dev/null || echo 0000-00-00)"
  fi
  printf '%s' "$key"
}

review_files="$(find REVIEWS -maxdepth 1 -type f \( -name 'REVIEW-*.md' -o -name 'PR_REVIEW_PACKAGE-*.md' \) | sort)"
if [[ -n "$review_files" ]]; then
  review_count="$(printf '%s\n' "$review_files" | wc -l | tr -d ' ')"
  if (( review_count > keep_review_files )); then
    excess=$((review_count - keep_review_files))
    rotate_files="$(while IFS= read -r f; do
        printf '%s\t%s\n' "$(review_file_date_key "$f")" "$f"
      done <<< "$review_files" \
      | sort -t$'\t' -k1,1 -k2,2 \
      | head -n "$excess" \
      | cut -f2-)"
    while IFS= read -r src; do
      base="$(basename "$src")"
      dest="MAINTAINER_ARCHIVE/REVIEWS/$base"
      move_file "$src" "$dest"
      rewrite_reference "REVIEWS/REVIEW_INDEX.md" "\`$src\`" "\`$dest\`"
      rewrite_reference "ARTIFACT_REGISTRY.md" "\`$src\`" "\`$dest\`"
    done <<< "$rotate_files"
  fi
fi

if (( changes == 0 )); then
  echo "prune-history: nothing exceeds the rotation caps (worklog rows <= $keep_worklog_rows, review files <= $keep_review_files)."
else
  if [[ "$mode" == "dry-run" ]]; then
    echo "prune-history: dry-run only; re-run with --apply to perform the $changes change(s) above."
  else
    echo "prune-history: applied $changes change(s). Review with git diff/status, then run bash SCRIPTS/validate-bootstrap.sh."
  fi
fi
