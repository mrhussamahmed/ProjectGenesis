#!/usr/bin/env bash
set -euo pipefail

repo_root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$repo_root"

failures=0

fail() {
  echo "FAIL: $*" >&2
  failures=$((failures + 1))
}

check_file() {
  local path="$1"
  [[ -f "$path" ]] || fail "missing required file: $path"
}

check_dir() {
  local path="$1"
  [[ -d "$path" ]] || fail "missing required directory: $path"
}

handoff_branch_matches_github_main_merge() {
  local git_branch="$1"
  local handoff_branch="$2"
  local parent_count
  local subject
  local source_branch

  [[ "$git_branch" == "main" ]] || return 1

  parent_count="$(git cat-file -p HEAD 2>/dev/null | awk '$1 == "parent" { count++ } END { print count + 0 }')"
  [[ "$parent_count" -eq 2 ]] || return 1

  subject="$(git log -1 --format=%s 2>/dev/null || true)"
  if [[ "$subject" =~ ^Merge\ pull\ request\ \#[0-9]+\ from\ [^[:space:]/]+/(.+)$ ]]; then
    source_branch="${BASH_REMATCH[1]}"
    [[ "$source_branch" == "$handoff_branch" ]] && return 0
  fi

  return 1
}

required_files=(
  "AI_PROJECT_BOOTSTRAP.md"
  "BOOTSTRAP_USAGE.md"
  "GETTING_STARTED.md"
  "NEW_PROJECT_INITIALIZATION.md"
  "MAINTAINER_ARCHIVE/BOOTSTRAP_AUDIT.md"
  "CLAUDE.md"
  "AGENTS.md"
  "GOVERNANCE.md"
  "MAINTAINER_ARCHIVE/GOVERNANCE_PERFORMANCE.md"
  "OPERATION_ROUTING.md"
  "PROJECT_MEMORY.md"
  "CURRENT_STATE.md"
  "AI_HANDOFF.md"
  "CONTEXT_INDEX.md"
  "ARCHITECTURE.md"
  "DECISIONS.md"
  "OPEN_QUESTIONS.md"
  "BACKLOG.md"
  "IMPLEMENTATION_PLAN.md"
  "MAINTAINER_ARCHIVE/PARALLEL_EXECUTION_PLAN.md"
  "BRANCH_AND_WORKTREE_GUIDE.md"
  "ARTIFACT_REGISTRY.md"
  "TRACEABILITY_MATRIX.md"
  "MAINTAINER_ARCHIVE/STALE_ITEMS.md"
  "TEST_STRATEGY.md"
  "TEST_PLAN.md"
  "TEST_RESULTS.md"
  "PR_REVIEW_POLICY.md"
  "PR_MERGE_POLICY.md"
  "AI_REVIEW_PROMPTS.md"
  "00_intake/SOURCE_REGISTRY.md"
  "00_intake/INTAKE_INDEX.md"
  "INPUT/README.md"
  "01_context/PROJECT_BRIEF.md"
  "01_context/PROJECT_CHARTER.md"
  "01_context/GLOSSARY.md"
  "01_context/CONSTRAINTS.md"
  "02_requirements/REQUIREMENTS_INDEX.md"
  "02_requirements/ASSUMPTIONS_REGISTER.md"
  "02_requirements/RISK_REGISTER.md"
  "CONTEXT_PACKS/README.md"
  "CONTEXT_PACKS/product-intake.md"
  "CONTEXT_PACKS/spec-authoring.md"
  "CONTEXT_PACKS/architecture.md"
  "CONTEXT_PACKS/implementation.md"
  "CONTEXT_PACKS/review.md"
  "CONTEXT_PACKS/resume.md"
  "COMMANDS/COMMAND_INDEX.md"
  "COMMANDS/COMMAND_TEMPLATE.md"
  "memory/ai/SHARED_AGENT_RULES.md"
  "memory/ai/ROLE_PRODUCT_ANALYST.md"
  "memory/ai/ROLE_SPEC_AUTHOR.md"
  "memory/ai/ROLE_ARCHITECT.md"
  "memory/ai/ROLE_BACKLOG_PLANNER.md"
  "memory/ai/ROLE_IMPLEMENTATION_AGENT.md"
  "memory/ai/ROLE_QA_REVIEWER.md"
  "memory/ai/ROLE_SECURITY_REVIEWER.md"
  "memory/ai/ROLE_DEVOPS_RELEASE_REVIEWER.md"
  "memory/ai/ROLE_DOCUMENTATION_CURATOR.md"
  "memory/ai/ROLE_ADVERSARIAL_PR_REVIEWER.md"
  "memory/ai/ROLE_DIAGRAM_ARCHITECT.md"
  "INPUT/.gitkeep"
  "RISK_MODEL.md"
  "HOOKS_AND_GUARDRAILS.md"
  "RELEASE_READINESS.md"
  "SECURITY_AND_PRIVACY.md"
  "OBSERVABILITY.md"
  "CI_CD_GUIDE.md"
  "CONTRIBUTING.md"
  "SPECS/SPEC_INDEX.md"
  "SPECS/templates/SPEC_TEMPLATE.md"
  "ADR/ADR_INDEX.md"
  "ADR/templates/ADR_TEMPLATE.md"
  "BACKLOG/BACKLOG_INDEX.md"
  "BACKLOG/templates/BACKLOG_ITEM_TEMPLATE.md"
  "REVIEWS/REVIEW_INDEX.md"
  "REVIEWS/templates/ADVERSARIAL_PR_REVIEW_TEMPLATE.md"
  "REVIEWS/templates/PR_REVIEW_PACKAGE_TEMPLATE.md"
  "TESTS/MANUAL_TEST_CHECKLIST.md"
  "MAINTAINER_ARCHIVE/TESTS/ACCEPTANCE_CRITERIA_MAP.md"
  "WORKLOG/WORKLOG_INDEX.md"
  "HANDOFFS/HANDOFF_INDEX.md"
  "SCRIPTS/start-claude.sh"
  "SCRIPTS/validate-bootstrap.sh"
  "SCRIPTS/validate-bootstrap-red-checks.sh"
  "MAINTAINER_ARCHIVE/SCRIPTS/scaffold-extract.sh"
  "SCRIPTS/metric-evidence-coverage.sh"
  "SCRIPTS/metric-acceptance-coverage.sh"
  "SCRIPTS/metric-traceability-completeness.sh"
  "MAINTAINER_ARCHIVE/SCRIPTS/run-seeded-defect-bench.sh"
  "MAINTAINER_ARCHIVE/TESTS/ADVERSARIAL_SEED_BENCHMARK.md"
  ".githooks/pre-commit"
  ".githooks/commit-msg"
  ".githooks/pre-push"
  ".github/workflows/bootstrap-validation.yml"
)

required_dirs=(
  "SPECS"
  "SPECS/templates"
  "ADR"
  "ADR/templates"
  "BACKLOG"
  "BACKLOG/templates"
  "REVIEWS"
  "REVIEWS/templates"
  "TESTS"
  "MAINTAINER_ARCHIVE"
  "MAINTAINER_ARCHIVE/ARTIFACTS"
  "MAINTAINER_ARCHIVE/ARTIFACTS/ARCHIVE"
  "WORKLOG"
  "HANDOFFS"
  "INPUT"
  "00_intake"
  "00_intake/raw"
  "00_intake/summaries"
  "01_context"
  "02_requirements"
  "CONTEXT_PACKS"
  "COMMANDS"
  "memory"
  "memory/ai"
  "SCRIPTS"
  ".githooks"
  ".github/workflows"
)

for path in "${required_files[@]}"; do
  check_file "$path"
done

for path in "${required_dirs[@]}"; do
  check_dir "$path"
done

while IFS= read -r file; do
  case "$file" in
    ./AGENTS.md|./CLAUDE.md|./SPECS/templates/*|./ADR/templates/*|./BACKLOG/templates/*|./REVIEWS/templates/*) continue ;;
  esac
  file="${file#./}"
  grep -Eq '^artifact_id: .+' "$file" || fail "$file missing non-empty artifact_id metadata"
  grep -Eq '^status: .+' "$file" || fail "$file missing status metadata"
  grep -Eq '^version: .+' "$file" || fail "$file missing version metadata"
  grep -Eq '^authoritative: (true|false)$' "$file" || fail "$file missing authoritative metadata"
done < <(find . \
  \( -path './.git' -o -path './.claude' -o -path './research' \) -prune \
  -o -type f -name '*.md' -print)

for section in \
  "## Current Date" \
  "## Active Agent" \
  "## Current Role" \
  "## Current Branch" \
  "## Current Worktree" \
  "## Last Completed Task" \
  "## Current In-Progress Task" \
  "## Files Changed" \
  "## Tests Run" \
  "## Tests Not Run" \
  "## Known Risks" \
  "## Dirty Worktree Status" \
  "## Next Recommended Action" \
  "## What The Next AI Must Read First" \
  "## Implementation Status"; do
  grep -Fq "$section" AI_HANDOFF.md || fail "AI_HANDOFF.md missing section: $section"
done

placeholder_pattern='TODO|TBD|FIXME|REPLACE_ME|YOUR_|NEEDS CLARIFICATION'
while IFS= read -r file; do
  case "$file" in
    SPECS/templates/*|ADR/templates/*|BACKLOG/templates/*|REVIEWS/templates/*) continue ;;
  esac
  if grep -En "$placeholder_pattern" "$file" >/tmp/bootstrap-placeholder-hit.$$ 2>/dev/null; then
    echo "Potential unresolved placeholder in $file:" >&2
    cat /tmp/bootstrap-placeholder-hit.$$ >&2
    rm -f /tmp/bootstrap-placeholder-hit.$$
    fail "$file contains unresolved placeholder-like text"
  fi
  rm -f /tmp/bootstrap-placeholder-hit.$$
done < <(find . \
  \( -path './.git' -o -path './.claude' -o -path './research' \) -prune \
  -o -type f -name '*.md' -print | sed 's#^\./##')

while IFS= read -r file; do
  if grep -Eq '^status: (approved|active)$' "$file"; then
    while IFS= read -r requirement_id; do
      [[ -n "$requirement_id" ]] && fail "$file approved spec missing source IDs: $requirement_id"
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
          if (source_col == 0) {
            print first
            next
          }
          source_value = trim($(source_col))
          if (source_value == "" || tolower(source_value) == "none") {
            print first
          }
        }
      }
    ' "$file")
  fi
done < <(find SPECS -maxdepth 1 -type f -name '*.md' -print)

while IFS= read -r id; do
  [[ -n "$id" ]] && fail "BACKLOG.md active backlog item missing linked spec: $id"
done < <(awk -F'|' '
  function trim(value) {
    gsub(/^[ \t]+|[ \t]+$/, "", value)
    return value
  }
  /^\| [^|-]/ && $2 !~ /ID/ {
    id = trim($2)
    dependencies = trim($8)
    readiness = trim($9)
    if (id !~ /^BOOT-/ && readiness ~ /^(ready|in-progress|in-review|done)$/ && dependencies !~ /(SPEC-|discovery exception)/) {
      print id
    }
  }
' BACKLOG.md)

if git_branch="$(git branch --show-current 2>/dev/null)" && [[ -n "$git_branch" ]]; then
  handoff_branch="$(awk '
    /^## Current Branch$/ {
      getline
      getline
      gsub(/`/, "")
      print
      exit
    }
  ' AI_HANDOFF.md)"
  if [[ -n "$handoff_branch" && "$handoff_branch" != "$git_branch" ]] &&
    ! handoff_branch_matches_github_main_merge "$git_branch" "$handoff_branch"; then
    fail "AI_HANDOFF.md branch does not match git branch: $handoff_branch != $git_branch"
  fi
fi

if [[ -d COMMANDS ]]; then
  while IFS= read -r file; do
    case "$file" in
      COMMANDS/COMMAND_INDEX.md) continue ;;
    esac
    for section in \
      "## Purpose" \
      "## Required Role" \
      "## Required Files To Read" \
      "## Inputs" \
      "## Outputs" \
      "## Stop Conditions" \
      "## Validation" \
      "## Authority Limit"; do
      grep -Fq "$section" "$file" || fail "$file command missing section: $section"
    done
  done < <(find COMMANDS -maxdepth 1 -type f -name '*.md' -print)
fi

if [[ -d CONTEXT_PACKS ]]; then
  while IFS= read -r file; do
    for section in \
      "## Files To Read First" \
      "## Files To Read If Relevant" \
      "## Files Not To Scan Unless Needed" \
      "## Expected Outputs" \
      "## Stop Conditions" \
      "## Authority Limit"; do
      grep -Fq "$section" "$file" || fail "$file context pack missing section: $section"
    done
    grep -Fq "cannot" "$file" || fail "$file context pack missing explicit authority limit"
  done < <(find CONTEXT_PACKS -maxdepth 1 -type f -name '*.md' ! -name 'README.md' -print)
fi

if [[ -f "00_intake/SOURCE_REGISTRY.md" ]]; then
  while IFS='|' read -r kind id; do
    case "$kind" in
      freshness) fail "00_intake/SOURCE_REGISTRY.md source registry row missing freshness: $id" ;;
      processing) fail "00_intake/SOURCE_REGISTRY.md source registry row missing processing state: $id" ;;
    esac
  done < <(awk -F'|' '
    function trim(value) {
      gsub(/^[ \t]+|[ \t]+$/, "", value)
      return value
    }
    /^\| SRC-/ {
      id = trim($2)
      freshness = trim($7)
      processing = trim($8)
      if (freshness == "" || freshness == "none") {
        print "freshness|" id
      }
      if (processing == "" || processing == "none") {
        print "processing|" id
      }
    }
  ' 00_intake/SOURCE_REGISTRY.md)
fi

if [[ -f "02_requirements/ASSUMPTIONS_REGISTER.md" ]]; then
  while IFS='|' read -r kind id; do
    case "$kind" in
      expiry) fail "02_requirements/ASSUMPTIONS_REGISTER.md assumption row missing expiry: $id" ;;
      evidence) fail "02_requirements/ASSUMPTIONS_REGISTER.md approved assumption missing approval evidence: $id" ;;
      disallowed-evidence) fail "02_requirements/ASSUMPTIONS_REGISTER.md approved assumption has disallowed approval evidence: $id" ;;
      unsupported-evidence) fail "02_requirements/ASSUMPTIONS_REGISTER.md approved assumption missing allowed approval evidence: $id" ;;
    esac
  done < <(awk -F'|' '
    function trim(value) {
      gsub(/^[ \t]+|[ \t]+$/, "", value)
      return value
    }
    /^\| ASM-/ {
      id = trim($2)
      status = trim($6)
      expiry = trim($7)
      evidence = trim($8)
      evidence_lc = tolower(evidence)
      if (expiry == "" || expiry == "none") {
        print "expiry|" id
      }
      if (status == "approved") {
        if (evidence == "" || evidence == "none") {
          print "evidence|" id
        } else if (evidence_lc ~ /(self-approved|self approved|self approval|same agent|by author|author-only)/) {
          print "disallowed-evidence|" id
        } else if (evidence !~ /(explicit user approval|user approval|approved spec|active spec|accepted ADR|maintainer-approved|verified external|SPEC-[A-Z0-9-]+|ADR-[A-Z0-9-]+|SRC-[0-9]+)/) {
          print "unsupported-evidence|" id
        }
      }
    }
  ' 02_requirements/ASSUMPTIONS_REGISTER.md)
fi

# BOOT-033 SRC/SPEC cross-validation.
#
# Verify that cited SRC-* and SPEC-* identifiers in `BACKLOG/BOOT-*.md`
# files exist in their respective registers. Provisional placeholders
# prefixed with `provisional:` or `pending:` are allowed without
# registration; "none" or "n/a" values are treated as no-citation and
# skipped. Bare canonical IDs must be registered:
#
# - `SRC-[0-9]+` must appear in `00_intake/SOURCE_REGISTRY.md` as a
#   table row (`| SRC-NNN |`).
# - `SPEC-[A-Z][A-Z0-9-]*-[0-9]+` must appear in `SPECS/SPEC_INDEX.md`
#   as a table row (`| SPEC-XXX-NNN |`) or as an existing spec file in
#   `SPECS/` named `SPEC-XXX-NNN-*.md`.
#
# The validator only inspects citations in `BACKLOG/BOOT-*.md` so
# downstream product intake and existing planning narratives are not
# disturbed. Future work can extend the scope to other files when the
# downstream source/spec catalog grows.

src_registered() {
  local id="$1"
  [[ -z "$id" ]] && return 0
  if [[ -f 00_intake/SOURCE_REGISTRY.md ]]; then
    grep -qE "^\| $id +\|" 00_intake/SOURCE_REGISTRY.md && return 0
  fi
  return 1
}

spec_registered() {
  local id="$1"
  [[ -z "$id" ]] && return 0
  if [[ -f SPECS/SPEC_INDEX.md ]]; then
    grep -qE "^\| $id +\|" SPECS/SPEC_INDEX.md && return 0
  fi
  if find SPECS -maxdepth 1 -type f -name "${id}-*.md" -print 2>/dev/null | grep -q .; then
    return 0
  fi
  return 1
}

# Strip provisional/pending prefixes from each token so the canonical
# `SRC-N` / `SPEC-X-N` ID is the only thing the validator checks.
extract_ids() {
  local line="$1"
  local pattern="$2"
  printf '%s' "$line" \
    | grep -oE "(provisional:|pending:)?$pattern" \
    | grep -vE '^(provisional:|pending:)' \
    || true
}

if [[ -d BACKLOG ]]; then
  while IFS= read -r file; do
    src_line="$(awk 'tolower($0) ~ /^- source ids:/ { sub(/^[^:]*:[ ]*/, ""); print; exit }' "$file")"
    if [[ -n "$src_line" ]]; then
      lower="$(printf '%s' "$src_line" | tr '[:upper:]' '[:lower:]')"
      if [[ "$lower" != none* ]] && [[ "$lower" != "n/a" ]]; then
        while IFS= read -r id; do
          [[ -z "$id" ]] && continue
          src_registered "$id" || fail "$file cites unregistered source ID: $id"
        done < <(extract_ids "$src_line" 'SRC-[0-9]+')
      fi
    fi
    spec_line="$(awk 'tolower($0) ~ /^- linked spec:/ { sub(/^[^:]*:[ ]*/, ""); print; exit }' "$file")"
    if [[ -n "$spec_line" ]]; then
      lower="$(printf '%s' "$spec_line" | tr '[:upper:]' '[:lower:]')"
      if [[ "$lower" != none* ]] && [[ "$lower" != "n/a" ]]; then
        while IFS= read -r id; do
          [[ -z "$id" ]] && continue
          spec_registered "$id" || fail "$file cites unregistered spec ID: $id"
        done < <(extract_ids "$spec_line" 'SPEC-[A-Z][A-Z0-9-]*-[0-9]+')
      fi
    fi
  done < <(find MAINTAINER_ARCHIVE/BACKLOG -maxdepth 1 -type f -name 'BOOT-*.md' -print 2>/dev/null)
fi

# BOOT-034 Next Safe Action Staleness Guard.
#
# Committed handoff and state evidence in `AI_HANDOFF.md` and
# `CURRENT_STATE.md` may carry one or more `Next safe action:` envelope
# fields. After an envelope's action is complete, the line goes stale and
# must not keep instructing the next agent to redo work that already
# happened. The PR #10 / BOOT-033 v1.0 through v1.5 review loop is the
# canonical incident: successive fresh-context reviews each surfaced an
# older, unmarked `Next safe action:` line that was misread as still
# active.
#
# The check is narrow and fail-closed:
#
# - It scans only `AI_HANDOFF.md` and `CURRENT_STATE.md`.
# - It only matches Markdown list-item bullets that start (after optional
#   leading whitespace) with `-` or `*`, then `Next safe action:` (case
#   insensitive). Section headings such as `## Next Recommended Action`
#   start with `#` and are skipped. Narrative prose mentioning
#   `Next safe action:` inside backticks is skipped because it does not
#   begin with a list bullet.
# - Multiline bullets are stitched together: any indented continuation
#   line is appended to the bullet's payload until the next bullet,
#   blank line, or section heading.
# - Lines inside fenced code blocks (` ``` ` or `~~~`) are ignored so
#   illustrative `Next safe action:` examples in code fences do not trip
#   the rule.
# - A bullet is "marked" (historical) when its trimmed payload starts
#   with one of the canonical marker words (`completed`, `superseded`,
#   `historical`, `delegated`) or with a leading parenthetical such as
#   `(historical)` containing one of those words. The marker must be at
#   the start of the payload; marker words appearing later in the
#   payload (for example, "confirm delegated authority" or "ensure work
#   is completed before merge") do NOT count as marked, so the rule
#   stays fail-closed on legitimately active instructions that happen to
#   mention a marker word.
# - Empty payloads (a bullet with `Next safe action:` and no content on
#   the same line or any continuation line) count as unmarked. They
#   indicate a structurally incomplete envelope and should be flagged.
# - At most one unmarked `Next safe action:` field is allowed per file.
#   That single line represents the current/active envelope. All other
#   envelopes are historical and must carry one of the explicit markers
#   at the start of the payload.
#
# The marker set is intentionally small: `completed`, `superseded`,
# `historical`, `delegated`. If a maintainer wants to describe a
# different historical state (for example a merged PR), the canonical
# pattern is `Next safe action: completed by PR #N merge; ...` which
# already matches the `completed` marker.
#
# The rule deliberately does not police general prose; it only inspects
# the structured `Next safe action:` envelope field used by
# `OPERATION_ROUTING.md`.

count_unmarked_next_safe_actions() {
  local target="$1"
  [[ -f "$target" ]] || { echo 0; return; }
  awk '
    function has_start_marker(payload,    lower) {
      lower = tolower(payload)
      sub(/^[ \t]+/, "", lower)
      if (lower == "") return 0
      # Parenthetical marker at the very start, optionally with extra
      # text inside the parens: e.g. "(historical)", "(completed; see X)".
      if (lower ~ /^\([^)]*(completed|superseded|historical|delegated)[^)]*\)/) return 1
      # Direct marker word at the very start of the payload, terminated
      # by a non-letter (whitespace, punctuation, end of line).
      if (lower ~ /^(completed|superseded|historical|delegated)([^a-z]|$)/) return 1
      return 0
    }
    function finalize(    payload) {
      if (!in_bullet) return
      payload = bullet_payload
      gsub(/^[ \t]+|[ \t]+$/, "", payload)
      # Empty payloads are structurally incomplete -- count as unmarked
      # so the staleness guard flags them.
      if (!has_start_marker(payload)) count += 1
      in_bullet = 0
      bullet_payload = ""
    }
    BEGIN {
      in_fence = 0
      in_bullet = 0
      bullet_payload = ""
    }
    # Toggle Markdown fence state on lines starting with ``` or ~~~.
    /^[ \t]*(```|~~~)/ {
      finalize()
      in_fence = !in_fence
      next
    }
    in_fence { next }
    # Section headings end any open bullet.
    /^#/ { finalize(); next }
    # Blank lines end any open bullet.
    /^[ \t]*$/ { finalize(); next }
    # New list bullet (either a new `Next safe action:` field or a
    # different bullet). Finalize the previous bullet first.
    /^[ \t]*[-*][ \t]/ {
      finalize()
      if (tolower($0) ~ /^[ \t]*[-*][ \t]+next safe action:/) {
        idx = index(tolower($0), "next safe action:")
        bullet_payload = substr($0, idx + length("next safe action:"))
        in_bullet = 1
      }
      next
    }
    # Continuation line for the open bullet.
    in_bullet { bullet_payload = bullet_payload " " $0 }
    END { finalize(); print count + 0 }
  ' "$target"
}

for stale_target in AI_HANDOFF.md CURRENT_STATE.md; do
  if [[ -f "$stale_target" ]]; then
    unmarked_count="$(count_unmarked_next_safe_actions "$stale_target")"
    if [[ "$unmarked_count" -gt 1 ]]; then
      fail "$stale_target has $unmarked_count unmarked 'Next safe action:' entries; only the current envelope may be unmarked. Mark historical entries with one of: completed, superseded, historical, delegated."
    fi
  fi
done

grep -Fq "ARTIFACT_REGISTRY.md" CONTEXT_INDEX.md || fail "CONTEXT_INDEX.md does not reference ARTIFACT_REGISTRY.md"
grep -Fq "TRACEABILITY_MATRIX.md" CONTEXT_INDEX.md || fail "CONTEXT_INDEX.md does not reference TRACEABILITY_MATRIX.md"
grep -Fq "SPECS/SPEC_INDEX.md" CONTEXT_INDEX.md || fail "CONTEXT_INDEX.md does not reference SPECS/SPEC_INDEX.md"
grep -Fq "memory/ai/SHARED_AGENT_RULES.md" CONTEXT_INDEX.md || fail "CONTEXT_INDEX.md does not reference memory/ai/SHARED_AGENT_RULES.md"
grep -Fq "memory/ai/ROLE_*.md" CONTEXT_INDEX.md || fail "CONTEXT_INDEX.md does not reference memory/ai/ROLE_*.md"
grep -Fq "OPERATION_ROUTING.md" CONTEXT_INDEX.md || fail "CONTEXT_INDEX.md does not reference OPERATION_ROUTING.md"
grep -Fq "OPERATION_ROUTING.md" memory/ai/SHARED_AGENT_RULES.md || fail "shared agent rules do not reference OPERATION_ROUTING.md"
grep -Fq "OPERATION_ROUTING.md" GOVERNANCE.md || fail "GOVERNANCE.md does not reference OPERATION_ROUTING.md"
grep -Fq "Default mode is orientation-only" SCRIPTS/start-claude.sh || fail "SCRIPTS/start-claude.sh does not document default orientation-only behavior"
grep -Fq "default orientation-only mode" CLAUDE.md || fail "CLAUDE.md does not document default orientation-only behavior"
grep -Fq "default orientation-only" BOOTSTRAP_USAGE.md || fail "BOOTSTRAP_USAGE.md does not document default orientation-only behavior"

for section in \
  "## Operation Profiles" \
  "## Escalation Precedence" \
  "## Protected Artifacts" \
  "## Read Tiers" \
  "## Token Budgets" \
  "## Write Plan" \
  "## Impact Map" \
  "## Validation Modes" \
  "## Evidence Envelope" \
  "## Handoff And Current State" \
  "## Claim Evidence" \
  "## Measurement"; do
  grep -Fq "$section" OPERATION_ROUTING.md || fail "OPERATION_ROUTING.md missing section: $section"
done

for profile in \
  "review-only" \
  "docs-trivial" \
  "docs-non-authoritative" \
  "docs-public-claim" \
  "state-sync" \
  "planning-governance" \
  "strict-protected"; do
  grep -Fq "\`$profile\`" OPERATION_ROUTING.md || fail "OPERATION_ROUTING.md missing operation profile: $profile"
done

for mode in fast standard strict; do
  grep -Eq "\| $mode \|" OPERATION_ROUTING.md || fail "OPERATION_ROUTING.md missing validation mode: $mode"
done

for field in \
  "Operation profile:" \
  "Target files:" \
  "Protected files touched:" \
  "Expected risk:" \
  "Branch requirement:" \
  "Required validation:" \
  "Required review:" \
  "Traceability impact:" \
  "Registry impact:" \
  "Handoff/state impact:" \
  "Dirty worktree status:" \
  "Escalation triggers checked:"; do
  grep -Fq "$field" OPERATION_ROUTING.md || fail "OPERATION_ROUTING.md missing pre-change field: $field"
done

for field in \
  "Classification confidence:" \
  "Files read:" \
  "Files changed:" \
  "Files intentionally not read:" \
  "Artifacts not impacted:" \
  "Validation run:" \
  "Validation skipped:" \
  "Review required:" \
  "Next safe action:"; do
  grep -Fq "$field" OPERATION_ROUTING.md || fail "OPERATION_ROUTING.md missing evidence envelope field: $field"
done

grep -Fq "Pre-Change Classification" AI_HANDOFF.md || fail "AI_HANDOFF.md missing pre-change classification record"
grep -Fq "Operation profile:" AI_HANDOFF.md || fail "AI_HANDOFF.md missing operation profile evidence"
grep -Fq "OPERATION_ROUTING.md" REVIEWS/templates/PR_REVIEW_PACKAGE_TEMPLATE.md || fail "PR review package template missing operation routing section"
grep -Fq "Operation Routing Review" REVIEWS/templates/ADVERSARIAL_PR_REVIEW_TEMPLATE.md || fail "adversarial review template missing operation routing review"

while IFS='|' read -r kind section; do
  [[ -z "$kind" ]] && continue
  case "$kind" in
    strict) fail "AI_HANDOFF.md protected mechanics classification must be strict-protected: $section" ;;
    planning) fail "AI_HANDOFF.md protected planning classification must be planning-governance or strict-protected: $section" ;;
  esac
done < <(awk '
  function trim(value) {
    gsub(/^[ \t]+|[ \t]+$/, "", value)
    return value
  }
  function evaluate() {
    if (!in_classification) {
      return
    }
    if (target_body ~ /(SCRIPTS\/|\.github\/workflows|\.githooks\/|memory\/ai\/|PR_REVIEW_POLICY\.md|PR_MERGE_POLICY\.md|RISK_MODEL\.md|BRANCH_AND_WORKTREE_GUIDE\.md|GOVERNANCE\.md|OPERATION_ROUTING\.md|CONTEXT_PACKS\/|COMMANDS\/|REVIEWS\/templates\/|SPECS\/templates\/|ADR\/templates\/|BACKLOG\/templates\/)/ && profile != "strict-protected") {
      print "strict|" section
    } else if (target_body ~ /(SPECS\/|BACKLOG\.md|BACKLOG\/|TRACEABILITY_MATRIX\.md|ARTIFACT_REGISTRY\.md|ADR\/|02_requirements\/|MAINTAINER_ARCHIVE\/TESTS\/ACCEPTANCE_CRITERIA_MAP\.md|TESTS\/ACCEPTANCE_CRITERIA_MAP\.md)/ && profile !~ /^(planning-governance|strict-protected)$/) {
      print "planning|" section
    }
  }
  /^## / {
    evaluate()
    section = trim(substr($0, 4))
    in_classification = ($0 ~ /Pre-Change Classification/)
    profile = ""
    body = ""
    target_body = ""
    in_target = 0
    next
  }
  in_classification {
    body = body "\n" $0
    if ($0 ~ /Target files:/) {
      in_target = 1
    }
    if ($0 ~ /Protected files touched:/) {
      in_target = 0
    }
    if (in_target) {
      target_body = target_body "\n" $0
    }
    if ($0 ~ /Operation profile:/) {
      if (match($0, /`[^`]+`/)) {
        profile = substr($0, RSTART + 1, RLENGTH - 2)
      } else {
        split($0, profile_parts, "Operation profile:")
        profile = trim(profile_parts[2])
        sub(/[[:space:]].*$/, "", profile)
      }
    }
  }
  END {
    evaluate()
  }
' AI_HANDOFF.md)

for path in "${required_files[@]}"; do
  grep -Fq "\`$path\`" ARTIFACT_REGISTRY.md || fail "ARTIFACT_REGISTRY.md does not register $path"
done

[[ -x "SCRIPTS/start-claude.sh" ]] || fail "SCRIPTS/start-claude.sh is not executable"

for mode in default product spec architecture backlog implementation qa security devops docs review diagrams handoff; do
  grep -Eq "^[[:space:]]*$mode\\)" SCRIPTS/start-claude.sh || fail "SCRIPTS/start-claude.sh missing allowlisted mode: $mode"
done

if [[ "$failures" -ne 0 ]]; then
  echo "Bootstrap validation failed with $failures issue(s)." >&2
  exit 1
fi

echo "Bootstrap validation passed."
