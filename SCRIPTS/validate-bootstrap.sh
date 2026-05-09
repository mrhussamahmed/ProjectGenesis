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

required_files=(
  "AI_PROJECT_BOOTSTRAP.md"
  "BOOTSTRAP_USAGE.md"
  "BOOTSTRAP_AUDIT.md"
  "CLAUDE.md"
  "AGENTS.md"
  "GOVERNANCE.md"
  "PROJECT_MEMORY.md"
  "CURRENT_STATE.md"
  "AI_HANDOFF.md"
  "CONTEXT_INDEX.md"
  "ARCHITECTURE.md"
  "DECISIONS.md"
  "OPEN_QUESTIONS.md"
  "BACKLOG.md"
  "IMPLEMENTATION_PLAN.md"
  "PARALLEL_EXECUTION_PLAN.md"
  "BRANCH_AND_WORKTREE_GUIDE.md"
  "ARTIFACT_REGISTRY.md"
  "TRACEABILITY_MATRIX.md"
  "STALE_ITEMS.md"
  "TEST_STRATEGY.md"
  "TEST_PLAN.md"
  "TEST_RESULTS.md"
  "PR_REVIEW_POLICY.md"
  "PR_MERGE_POLICY.md"
  "AI_REVIEW_PROMPTS.md"
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
  "TESTS/ACCEPTANCE_CRITERIA_MAP.md"
  "WORKLOG/WORKLOG_INDEX.md"
  "HANDOFFS/HANDOFF_INDEX.md"
  "SCRIPTS/start-claude.sh"
  "SCRIPTS/validate-bootstrap.sh"
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
  "ARTIFACTS"
  "ARTIFACTS/ARCHIVE"
  "WORKLOG"
  "HANDOFFS"
  "INPUT"
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
done < <(find . -type f -name '*.md' -not -path './.git/*' -print)

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
done < <(find . -type f -name '*.md' -not -path './.git/*' -print | sed 's#^\./##')

grep -Fq "ARTIFACT_REGISTRY.md" CONTEXT_INDEX.md || fail "CONTEXT_INDEX.md does not reference ARTIFACT_REGISTRY.md"
grep -Fq "TRACEABILITY_MATRIX.md" CONTEXT_INDEX.md || fail "CONTEXT_INDEX.md does not reference TRACEABILITY_MATRIX.md"
grep -Fq "SPECS/SPEC_INDEX.md" CONTEXT_INDEX.md || fail "CONTEXT_INDEX.md does not reference SPECS/SPEC_INDEX.md"
grep -Fq "memory/ai/SHARED_AGENT_RULES.md" CONTEXT_INDEX.md || fail "CONTEXT_INDEX.md does not reference memory/ai/SHARED_AGENT_RULES.md"
grep -Fq "memory/ai/ROLE_*.md" CONTEXT_INDEX.md || fail "CONTEXT_INDEX.md does not reference memory/ai/ROLE_*.md"
grep -Fq "Default mode is orientation-only" SCRIPTS/start-claude.sh || fail "SCRIPTS/start-claude.sh does not document default orientation-only behavior"
grep -Fq "default orientation-only mode" CLAUDE.md || fail "CLAUDE.md does not document default orientation-only behavior"
grep -Fq "default orientation-only" BOOTSTRAP_USAGE.md || fail "BOOTSTRAP_USAGE.md does not document default orientation-only behavior"

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
