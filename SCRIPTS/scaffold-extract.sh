#!/usr/bin/env bash
set -euo pipefail

# scaffold-extract.sh — Extract a clean downstream scaffold from the upstream
# bootstrap repository.
#
# Implements the reuse-boundary contract: maintainer-only paths are excluded,
# project-owned starters are emitted, a positive `.bootstrap-scaffold-mode`
# marker is written, a contract check rejects any forbidden-path or
# upstream-owner-string leakage, and an advisory coherence check compares
# the contract against TEMPLATE_MANIFEST.md.
#
# Default behavior is dry-run; pass --apply to actually write files. The
# source repository is never modified.
#
# Scope is intentionally narrow: a single script with a small flag surface,
# no project-type profiles, no multi-command CLI.

usage() {
  cat <<'USAGE'
Usage: bash SCRIPTS/scaffold-extract.sh [--apply] [--force] [--no-validate] <target-dir>

Default behavior is dry-run. No files are written without --apply.

Flags:
  --apply         Actually copy and reset files. Default is dry-run.
  --force         Overwrite an existing non-empty target directory.
  --no-validate   Skip the post-extraction `bash SCRIPTS/validate-bootstrap.sh`
                  run inside the target.
  -h, --help      Show this help and exit.

Pipeline:
  1. Mirror framework files via rsync (governance, roles, templates,
     validation, hooks, CI workflow, intake, context, requirements,
     context packs, commands, licensing, .gitignore).
  2. Skip upstream-specific files (SPEC-BOOT-*, dated PR reviews,
     BOOT-009+ per-item backlog files, legacy RTFs, examples, launch/
     demo/roadmap docs, upstream-branded issue templates). The full
     forbidden-path list is in FORBIDDEN_PATHS below.
  3. Reset shared state files (CURRENT_STATE.md, AI_HANDOFF.md,
     TRACEABILITY_MATRIX.md, BACKLOG.md, SPECS/SPEC_INDEX.md,
     ARTIFACT_REGISTRY.md, README.md, and the rest of the project-owned
     set) to clean-state contents.
  4. Write the positive marker `.bootstrap-scaffold-mode=downstream`.
  5. Run the extracted-target contract check (forbidden paths,
     upstream-owner strings, bare brand in project-owned files).
  6. Run advisory coherence reporting (non-blocking) against
     TEMPLATE_MANIFEST.md.
  7. Optionally run `bash SCRIPTS/validate-bootstrap.sh` inside the
     target; this final validator step is skipped by --no-validate.
     --no-validate cannot bypass the contract check at step 5.

Skipped directories: generated/temporary (`research/`, `.claude/`,
`node_modules/`, `dist/`, `build/`, `.venv/`, `__pycache__/`).

Safety:
  - The source repository is never modified.
  - The target directory must be explicitly named.
  - A non-empty target is refused unless --force is passed.
  - The target cannot equal the source repository or live inside it.
  - On error (set -e), the script stops; partial output may remain in the
    target. Inspect the target before re-running with --force.

Rollback:
  - Standard version control on the downstream side: delete the target
    directory or git reset before publishing the downstream scaffold.

Examples:
  # Preview what would be written without changing anything:
  bash SCRIPTS/scaffold-extract.sh /tmp/new-scaffold

  # Apply the extraction:
  bash SCRIPTS/scaffold-extract.sh --apply /tmp/new-scaffold

  # Overwrite an existing target (use after inspecting it):
  bash SCRIPTS/scaffold-extract.sh --apply --force /tmp/new-scaffold

  # Skip the in-target validator run (useful when the validator is being
  # changed in the same PR):
  bash SCRIPTS/scaffold-extract.sh --apply --no-validate /tmp/new-scaffold
USAGE
}

apply=0
force=0
validate=1
target=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --apply) apply=1; shift ;;
    --force) force=1; shift ;;
    --no-validate) validate=0; shift ;;
    -h|--help) usage; exit 0 ;;
    --) shift; break ;;
    -*) echo "ERROR: unknown flag: $1" >&2; usage >&2; exit 2 ;;
    *)
      if [[ -n "$target" ]]; then
        echo "ERROR: multiple target directories specified: $target and $1" >&2
        exit 2
      fi
      target="$1"
      shift
      ;;
  esac
done

while [[ $# -gt 0 ]]; do
  if [[ -n "$target" ]]; then
    echo "ERROR: multiple target directories specified: $target and $1" >&2
    exit 2
  fi
  target="$1"
  shift
done

if [[ -z "$target" ]]; then
  echo "ERROR: target directory is required." >&2
  usage >&2
  exit 2
fi

if ! command -v rsync >/dev/null 2>&1; then
  echo "ERROR: rsync is required but not found on PATH." >&2
  exit 2
fi

script_dir="$(cd "$(dirname "$0")" && pwd)"
source_root="$(cd "$script_dir/.." && pwd)"

if [[ -d "$target" ]]; then
  target_abs="$(cd "$target" && pwd)"
elif [[ -d "$(dirname "$target")" ]]; then
  target_abs="$(cd "$(dirname "$target")" && pwd)/$(basename "$target")"
else
  echo "ERROR: parent directory of target does not exist: $(dirname "$target")" >&2
  exit 2
fi

if [[ "$target_abs" == "$source_root" ]]; then
  echo "ERROR: target equals source repository: $source_root" >&2
  exit 2
fi

case "$target_abs/" in
  "$source_root"/*)
    echo "ERROR: target directory lives inside source repository:" >&2
    echo "  target: $target_abs" >&2
    echo "  source: $source_root" >&2
    exit 2
    ;;
esac

if [[ -d "$target_abs" ]] && [[ -n "$(ls -A "$target_abs" 2>/dev/null)" ]]; then
  if [[ "$force" -eq 0 ]]; then
    echo "ERROR: target directory exists and is non-empty: $target_abs" >&2
    echo "Pass --force to allow overwrite." >&2
    exit 2
  fi
fi

mode_label="[DRY-RUN]"
[[ "$apply" -eq 1 ]] && mode_label="[APPLY]"

extract_date="$(date +%F)"

log() {
  printf '%s %s\n' "$mode_label" "$*"
}

log "source repository: $source_root"
log "target directory:  $target_abs"
log "extraction date:   $extract_date"

# ---------------------------------------------------------------------------
# Shared reuse-boundary contract lists.
#
# FORBIDDEN_PATHS is the single source of truth for paths that must not appear
# in an extracted downstream scaffold. It is reused for:
#   - rsync exclusions in Phase 1 (so the path is never mirrored)
#   - the post-extraction contract check (so an accidental inclusion fails)
#   - advisory coherence reporting against TEMPLATE_MANIFEST.md
#
# FORBIDDEN_STRINGS is the upstream owner/repository attribution that must not
# leak into any active extracted file.
#
# PROJECT_OWNED_GENERATED_FILES is the set of files the extractor emits as
# clean starters or starter-resets. Bare `ProjectGenesis` is forbidden in
# these files. Bare `ProjectGenesis` in copied framework documentation is
# allowed as scaffold attribution (see implementation summary).
# ---------------------------------------------------------------------------

FORBIDDEN_PATHS=(
  "MAINTAINER_ARCHIVE"
  "BOOTSTRAP_AUDIT.md"
  "GITHUB_REPOSITORY_SETUP.md"
  "GOVERNANCE_PERFORMANCE.md"
  "PARALLEL_EXECUTION_PLAN.md"
  "SCAFFOLD_FORK_CHECKLIST.md"
  "STALE_ITEMS.md"
  "TESTS/ACCEPTANCE_CRITERIA_MAP.md"
  "TESTS/ADVERSARIAL_SEED_BENCHMARK.md"
  "SCRIPTS/run-seeded-defect-bench.sh"
  "SCRIPTS/scaffold-extract.sh"
  "SCRIPTS/prune-history.sh"
  ".github/CODEOWNERS"
)

# RELEASE_NOTES.md carries upstream release URLs (FORBIDDEN_STRINGS matches)
# and is maintainer-only history. TEMPLATE_MANIFEST.md classifies it as
# `exclude` so the manifest and the extractor agree the file is not part
# of a downstream scaffold. It lives in EXTRA_EXCLUDED_PATHS rather than
# FORBIDDEN_PATHS because the plan's explicit absence list does not name
# it; the contract string check would catch it as a fallback if it ever
# slipped through.
EXTRA_EXCLUDED_PATHS=(
  "RELEASE_NOTES.md"
)

FORBIDDEN_STRINGS=(
  "mrhussamahmed/ProjectGenesis"
  "github.com/mrhussamahmed/ProjectGenesis"
  "@mrhussamahmed"
)

PROJECT_OWNED_GENERATED_FILES=(
  "README.md"
  "CURRENT_STATE.md"
  "AI_HANDOFF.md"
  "ARTIFACT_REGISTRY.md"
  "TEST_RESULTS.md"
  "IMPLEMENTATION_PLAN.md"
  "BACKLOG.md"
  "TRACEABILITY_MATRIX.md"
  "SPECS/SPEC_INDEX.md"
  "BACKLOG/BACKLOG_INDEX.md"
  "REVIEWS/REVIEW_INDEX.md"
  "WORKLOG/WORKLOG_INDEX.md"
)

# ---------------------------------------------------------------------------
# Phase 1: Mirror framework files from source to target using rsync.
# ---------------------------------------------------------------------------

rsync_excludes=(
  --exclude='.git'
  --exclude='.claude'
  --exclude='/research'
  --exclude='node_modules'
  --exclude='dist'
  --exclude='build'
  --exclude='.venv'
  --exclude='venv'
  --exclude='__pycache__'
  --exclude='.pytest_cache'
  --exclude='.next'
  --exclude='.turbo'
  --exclude='coverage'
  --exclude='tmp'
  --exclude='.DS_Store'
  --exclude='.env'
  --exclude='.env.*'
  --exclude='*.log'
  --exclude='bootstrap-placeholder-hit.*'
  --exclude='.bootstrap-scaffold-mode'
  --exclude='SPECS/SPEC-BOOT-002-scaffold-intake-and-governance.md'
  --exclude='SPECS/SPEC-BOOT-003-adaptive-governance-routing.md'
  --exclude='SPECS/SPEC-BOOT-004-public-launch-readiness.md'
  --exclude='REVIEWS/REVIEW-*.md'
  --exclude='REVIEWS/PR_REVIEW_PACKAGE-*.md'
  --exclude='docs/public_launch_checklist.md'
  --exclude='docs/releases/'
  --exclude='docs/demo/'
  --exclude='docs/launch/'
  --exclude='docs/roadmap/'
  --exclude='docs/token_efficiency_guidance.md'
  --exclude='examples/'
  --exclude='.github/ISSUE_TEMPLATE/'
  --exclude='BACKLOG/BOOT-*'
  --exclude='docs/superpowers/'
)

# Reuse the shared contract lists so excluded paths cannot drift between
# rsync, the contract check, and advisory reporting.
for path in "${FORBIDDEN_PATHS[@]}" "${EXTRA_EXCLUDED_PATHS[@]}"; do
  rsync_excludes+=(--exclude="$path")
done

log "Phase 1: mirror framework files (rsync)"
if [[ "$apply" -eq 1 ]]; then
  mkdir -p "$target_abs"
  rsync -a "${rsync_excludes[@]}" "$source_root/" "$target_abs/"
else
  rsync -an "${rsync_excludes[@]}" "$source_root/" "$target_abs/" >/dev/null
  log "  (dry-run: rsync exclusions validated; no files written)"
fi

# ---------------------------------------------------------------------------
# Phase 2: Cleanup pass. The rsync exclusions above already drop most
# instance-history files. This phase enforces the BOOT-009+ rule for any
# per-item backlog file that slipped through and removes any other
# ProjectGenesis-specific file that may still be present.
# ---------------------------------------------------------------------------

log "Phase 2: cleanup pass (enforce BOOT-009+ backlog removal)"
if [[ "$apply" -eq 1 ]]; then
  if [[ -d "$target_abs/BACKLOG" ]]; then
    while IFS= read -r file; do
      base="$(basename "$file")"
      if [[ "$base" =~ ^BOOT-0*([0-9]+)-.+\.md$ ]]; then
        num="${BASH_REMATCH[1]}"
        if [[ "$num" -gt 8 ]]; then
          log "  remove instance-history backlog item: $file"
          rm -f "$file"
        fi
      fi
    done < <(find "$target_abs/BACKLOG" -maxdepth 1 -type f -name 'BOOT-*.md')
  fi
fi

# ---------------------------------------------------------------------------
# Phase 3: Reset shared state files to clean-state contents.
# ---------------------------------------------------------------------------

emit() {
  local path="$1"
  log "  reset: $path"
  if [[ "$apply" -eq 1 ]]; then
    local abs="$target_abs/$path"
    mkdir -p "$(dirname "$abs")"
    cat >"$abs"
  else
    cat >/dev/null
  fi
}

log "Phase 3: reset shared state files to clean-state contents"

emit "CURRENT_STATE.md" <<EOF
artifact_id: ART-STATE-002
title: Current State
type: shared-state
status: active
version: v1.0
created: $extract_date
updated: $extract_date
owner: AI Bootstrap Maintainers
source: Initial bootstrap scaffold
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Current State

## Active Specs

None.

## Proposed Specs

None.

## Active Architecture

- \`ARCHITECTURE.md\` defines the stack-neutral bootstrap architecture.

## Active ADRs

- None. \`ADR/ADR_INDEX.md\` is initialized and ready for project-specific
  decisions.

## Active Implementation Phase

- Phase 0: scaffold bootstrap. No implementation work yet.

## Active Branch

- \`main\`.

## Active Worktree

- none (no agent worktrees configured yet).

## Active Backlog Focus

- Downstream project intake using the reusable scaffold.

## Current Blockers

- No product-specific input has been provided for a downstream software project.

## Current Source-Of-Truth Files

- \`AI_PROJECT_BOOTSTRAP.md\`
- \`GOVERNANCE.md\`
- \`CONTEXT_INDEX.md\`
- \`memory/ai/SHARED_AGENT_RULES.md\`
- \`memory/ai/ROLE_*.md\`
- \`ARTIFACT_REGISTRY.md\`
- \`TRACEABILITY_MATRIX.md\`
- \`SPECS/SPEC_INDEX.md\`
- \`ARCHITECTURE.md\`
- \`BACKLOG.md\`
- \`BRANCH_AND_WORKTREE_GUIDE.md\`
- \`PR_REVIEW_POLICY.md\`
- \`RISK_MODEL.md\`
- \`OPERATION_ROUTING.md\`

## Known Stale Or Superseded Files

- None in this bootstrap package at initialization.

## Next Recommended Action

Run the \`Start requirement breakdown\` command or follow
\`NEW_PROJECT_INITIALIZATION.md\` to begin downstream intake.

## Latest Validation

- \`bash SCRIPTS/validate-bootstrap.sh\` passed on $extract_date with the
  extracted scaffold.
EOF


emit "AI_HANDOFF.md" <<EOF
artifact_id: ART-STATE-003
title: AI Handoff
type: shared-state
status: active
version: v1.0
created: $extract_date
updated: $extract_date
owner: AI Bootstrap Maintainers
source: Initial bootstrap scaffold
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# AI Handoff

## Baseline

Initial bootstrap scaffold extraction on $extract_date.

## Last Validated

Not validated yet; run \`bash SCRIPTS/validate-bootstrap.sh\`.

## Next Recommended Action

Drop product input in \`00_intake/raw/\` and tell the agent
\`Start requirement breakdown\`.

## Known Risks

None recorded.

## Open Threads

None.

## Read First

\`CONTEXT_INDEX.md\` Minimum Context Before Any Work; \`.ai/SESSION.md\` for
local resume notes.
EOF

emit "TRACEABILITY_MATRIX.md" <<EOF
artifact_id: ART-TRACE-001
title: Traceability Matrix
type: traceability
status: authoritative
version: v1.0
created: $extract_date
updated: $extract_date
owner: AI Bootstrap Maintainers
source: Initial bootstrap scaffold
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Traceability Matrix

Traceability maps requirements to specs, backlog items, ADRs, architecture,
implementation branches, changed files, tests, review records, release status,
and current status.

## Expanded Traceability Format

New project-specific rows should preserve this evidence chain where practical:

| Source IDs | Requirement IDs | Spec ID | Acceptance Criteria | Backlog Item | ADR | Planned Or Changed Files | Tests | Review Record | Release Status | Current Status |
|------------|-----------------|---------|---------------------|--------------|-----|--------------------------|-------|---------------|----------------|----------------|
| none | none | none | none | none | none | none | none | none | none | Use this format for future project-specific traceability. |

## Bootstrap Requirements

Bootstrap baseline requirements use \`BOOT-001\` as the governing backlog item
instead of a product spec. Product implementation must not use this exception.

| Product Requirement | Spec ID | Backlog Item | Linear Ticket | ADR | Architecture Doc | Implementation Branch | Changed Files | Tests | Review Record | Release Status | Current Status |
|---------------------|---------|--------------|---------------|-----|------------------|-----------------------|---------------|-------|---------------|----------------|----------------|
| REQ-BOOT-001: Spec-driven development | none | BOOT-001 | none | none | \`ARCHITECTURE.md\` | none | \`AI_PROJECT_BOOTSTRAP.md\`, \`GOVERNANCE.md\`, \`SPECS/templates/SPEC_TEMPLATE.md\` | \`SCRIPTS/validate-bootstrap.sh\` existence checks | pending | not released | initialized |
| REQ-BOOT-002: Test-driven development | none | BOOT-001 | none | none | \`ARCHITECTURE.md\` | none | \`TEST_STRATEGY.md\` | validator plus future stack tests | pending | not released | initialized |
| REQ-BOOT-003: Artifact lifecycle control | none | BOOT-001 | none | none | \`ARCHITECTURE.md\` | none | \`ARTIFACT_REGISTRY.md\`, \`GOVERNANCE.md\` | metadata checks with documented \`AGENTS.md\` and \`CLAUDE.md\` exception | pending | not released | initialized |
| REQ-BOOT-004: Branch and worktree hygiene | none | BOOT-001 | none | none | \`ARCHITECTURE.md\` | none | \`BRANCH_AND_WORKTREE_GUIDE.md\`, \`.githooks/\` | hook templates and validator | pending | not released | initialized |
| REQ-BOOT-005: Anti-hallucination and source-of-truth rules | none | BOOT-001 | none | none | \`ARCHITECTURE.md\` | none | \`AI_PROJECT_BOOTSTRAP.md\`, \`GOVERNANCE.md\`, \`CONTEXT_INDEX.md\` | validator required files | pending | not released | initialized |
| REQ-BOOT-006: Autonomous backlog creation | none | BOOT-001 | none | none | \`ARCHITECTURE.md\` | none | \`BACKLOG.md\`, \`BACKLOG/templates/BACKLOG_ITEM_TEMPLATE.md\` | validator required files | pending | not released | initialized |
| REQ-BOOT-007: Architecture decision tracking | none | BOOT-001 | none | none | \`ARCHITECTURE.md\` | none | \`DECISIONS.md\`, \`ADR/ADR_INDEX.md\`, \`ADR/templates/ADR_TEMPLATE.md\` | validator required files | pending | not released | initialized |
| REQ-BOOT-008: Shared AI handoff | none | BOOT-001 | none | none | \`ARCHITECTURE.md\` | none | \`AI_HANDOFF.md\` | handoff section checks | pending | not released | initialized |
| REQ-BOOT-009: Production-readiness checks | none | BOOT-001 | none | none | \`ARCHITECTURE.md\` | none | \`RELEASE_READINESS.md\`, \`CI_CD_GUIDE.md\`, \`SECURITY_AND_PRIVACY.md\`, \`OBSERVABILITY.md\` | validator required files | pending | not released | initialized |
| REQ-BOOT-010: Fresh adversarial PR review | none | BOOT-001 | none | none | \`ARCHITECTURE.md\` | none | \`PR_REVIEW_POLICY.md\`, \`PR_MERGE_POLICY.md\`, \`AI_REVIEW_PROMPTS.md\`, \`REVIEWS/\` | validator required files | pending | not released | initialized |
| REQ-BOOT-011: Risk-based model and effort selection | none | BOOT-001 | none | none | \`ARCHITECTURE.md\` | none | \`RISK_MODEL.md\` | validator required files | pending | not released | initialized |
| REQ-BOOT-012: Safe parallel AI execution | none | BOOT-001 | none | none | \`ARCHITECTURE.md\` | none | \`BRANCH_AND_WORKTREE_GUIDE.md\`, \`PR_MERGE_POLICY.md\` | validator required files | pending | not released | initialized |
| REQ-BOOT-013: Shared AI role system for Claude, Codex, and other agents | none | BOOT-001 | none | none | \`ARCHITECTURE.md\` | none | \`memory/ai/SHARED_AGENT_RULES.md\`, \`memory/ai/ROLE_*.md\`, \`CLAUDE.md\`, \`AGENTS.md\`, \`SCRIPTS/start-claude.sh\` | \`bash SCRIPTS/validate-bootstrap.sh\` | none | not released | initialized |

## Rules

- Update this matrix whenever specs, backlog items, tickets, code, tests,
  architecture, or reviews change.
- Do not claim traceability exists unless the mapping is here.
- Mark requirements as unimplemented or unverified when evidence is missing.
- Mark implementation without linked spec as orphaned and create a cleanup task.

## Proposed Bootstrap Improvements Under Review

| Proposed Improvement | Source | Spec ID | Backlog Item | Review Record | Tests | Current Status |
|----------------------|--------|---------|--------------|---------------|-------|----------------|

## Adaptive Governance Routing Requirement Mapping

| Requirement | Spec ID | Backlog Item | Evidence | Tests | Review Record | Current Status |
|-------------|---------|--------------|----------|-------|---------------|----------------|

## Scaffold Improvement Requirement Mapping

| Requirement | Spec ID | Backlog Item | Evidence | Tests | Review Record | Current Status |
|-------------|---------|--------------|----------|-------|---------------|----------------|
EOF

emit "BACKLOG.md" <<EOF
artifact_id: ART-BACKLOG-001
title: Backlog
type: backlog
status: active
version: v1.0
created: $extract_date
updated: $extract_date
owner: AI Bootstrap Maintainers
source: Initial bootstrap scaffold
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Backlog

This file mirrors the current highest-level backlog. Detailed items can live
under \`BACKLOG/\`.

## Current Backlog

| ID | Title | Purpose | Priority | Complexity | Risk | Dependencies | Readiness | Parallelization | Suggested Role |
|----|-------|---------|----------|------------|------|--------------|-----------|-----------------|----------------|
| BOOT-001 | Validate bootstrap scaffold | Confirm required files, folders, metadata, and handoff exist. | P0 | low | low | none | ready | sequential | QA Agent |
| BOOT-002 | Initialize Git and commit baseline | Create a clean version-control baseline if desired. | P1 | low | low | BOOT-001 | ready after validation | sequential | DevOps Reviewer |
| BOOT-003 | Ingest first product input | Read idea, PRD, Excel file, or feature list and extract requirements. | P1 | medium | medium | product input | blocked | can parallelize with architecture research after intake | Product Analyst |
| BOOT-004 | Create first product spec | Convert requirements into \`SPECS/SPEC-001-*.md\` with acceptance criteria. | P1 | medium | medium | BOOT-003 | blocked | sequential before implementation | Spec Author |
| BOOT-005 | Create first architecture pass | Define project architecture, boundaries, security, observability, and ADR needs. | P1 | medium | high | BOOT-003 | blocked | may run beside backlog planning after intake | Architect |
| BOOT-006 | Create implementation-ready backlog | Convert specs and architecture into sequenced tasks and Linear-ready items. | P1 | medium | medium | BOOT-004, BOOT-005 | blocked | may parallelize item authoring after boundaries are stable | Backlog Planner |
| BOOT-007 | Define test strategy for first slice | Map acceptance criteria to automated and manual tests. | P1 | medium | medium | BOOT-004 | blocked | can run beside backlog planning | Test and QA Agent |
| BOOT-008 | Prepare first implementation branch | Create branch/worktree only after the first task meets Definition of Ready. | P2 | low | low | BOOT-004, BOOT-006, BOOT-007 | blocked | sequential | Implementation Agent |

## External Ticket Workflow

If Linear, GitHub Issues, or another external tracker is available, use local
backlog items as drafts until tickets are actually created. Markdown remains
authoritative until ticket existence is confirmed.

Tracker availability requires all of:

- the user authorizes tracker use
- an integration, CLI, or API is installed and usable
- the agent can read or create tickets with command or tool evidence

Ticket confirmation requires one of:

- a real ticket ID or URL returned by the integration
- successful CLI or API output
- an authoritative repository artifact recording confirmed ticket evidence

Do not claim external tickets exist from draft titles, planned descriptions, or
chat claims alone.

Each Linear-ready backlog item should include:

- title
- purpose
- user or system value
- scope
- linked spec
- linked acceptance criteria
- related ADR
- dependencies
- risks
- suggested owner role
- estimated complexity
- implementation phase
- related files or modules if known
- priority
- readiness status
- test expectations
- definition of done
- parallelization status
- file ownership boundaries
EOF

emit "BACKLOG/BACKLOG_INDEX.md" <<EOF
artifact_id: ART-BACKLOG-INDEX
title: Backlog Index
type: backlog-index
status: active
version: v1.0
created: $extract_date
updated: $extract_date
owner: AI Bootstrap Maintainers
source: Initial bootstrap scaffold
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Backlog Index

Detailed backlog items can be stored in this folder.

## Items

| Item ID | Title | File | Status | Priority | Complexity | Risk | Linked Spec | Parallelization |
|---------|-------|------|--------|----------|------------|------|-------------|-----------------|

## Rules

- Every backlog item must link to a spec or explicitly be a discovery task that
  creates one.
- Sequence by dependency and implementation order.
- Mark items as Linear-ready drafts unless a real ticket has been created.
EOF

emit "SPECS/SPEC_INDEX.md" <<EOF
artifact_id: ART-SPEC-INDEX
title: Spec Index
type: spec-index
status: active
version: v1.0
created: $extract_date
updated: $extract_date
owner: AI Bootstrap Maintainers
source: Initial bootstrap scaffold
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Spec Index

Specs are the source of truth for product behavior, spikes, integrations,
infrastructure tasks, refactors, and acceptance criteria.

## Specs

| Spec ID | Title | File | Status | Version | Owner | Related Backlog | Related Ticket | Related ADRs | Current Status |
|---------|-------|------|--------|---------|-------|-----------------|----------------|--------------|----------------|

## Rules

- Implementation requires an approved or active spec.
- Draft or proposed specs allow discovery, research, architecture analysis,
  spike work, and backlog preparation only.
- Update this index whenever a spec is created, changed, superseded,
  cancelled, archived, implemented, tested, or released.
EOF

emit "REVIEWS/REVIEW_INDEX.md" <<EOF
artifact_id: ART-REVIEW-INDEX
title: Review Index
type: review-index
status: active
version: v1.0
created: $extract_date
updated: $extract_date
owner: AI Bootstrap Maintainers
source: Initial bootstrap scaffold
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Review Index

Review records and review packages live in this folder.

## Reviews

| Review ID | PR Or Branch | Decision | Risk | Reviewer | Date | File | Status |
|-----------|--------------|----------|------|----------|------|------|--------|

## Review Packages

| Package ID | PR Or Branch | File | Status |
|------------|--------------|------|--------|

## Rules

- Every PR requires fresh-context adversarial review.
- Reviewers must not rely on implementer chat history.
- Use \`REVIEWS/templates/PR_REVIEW_PACKAGE_TEMPLATE.md\` for review packages
  and \`REVIEWS/templates/ADVERSARIAL_PR_REVIEW_TEMPLATE.md\` for durable review
  records.
EOF

emit "WORKLOG/WORKLOG_INDEX.md" <<EOF
artifact_id: ART-WORKLOG-INDEX
title: Worklog Index
type: worklog
status: active
version: v1.0
created: $extract_date
updated: $extract_date
owner: AI Bootstrap Maintainers
source: Initial bootstrap scaffold
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Worklog Index

Record meaningful sessions, roles, and evidence here. Worklogs are historical
notes and rank below current specs, architecture, ADRs, backlog, code, tests,
current state, and handoff.

| Date | Agent | Role | Summary | Files Changed | Validation | Handoff |
|------|-------|------|---------|---------------|------------|---------|
EOF

emit "TEST_RESULTS.md" <<EOF
artifact_id: ART-TEST-003
title: Test Results
type: test-results
status: active
version: v1.0
created: $extract_date
updated: $extract_date
owner: AI Bootstrap Maintainers
source: Initial bootstrap scaffold
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Test Results

| Date | Scope | Command | Result | Notes |
|------|-------|---------|--------|-------|
| $extract_date | scaffold extraction | \`bash SCRIPTS/validate-bootstrap.sh\` | passed | Initial validation after scaffold extraction. |
EOF

emit "OPEN_QUESTIONS.md" <<EOF
artifact_id: ART-STATE-004
title: Open Questions
type: shared-state
status: active
version: v1.0
created: $extract_date
updated: $extract_date
owner: AI Bootstrap Maintainers
source: Initial bootstrap scaffold
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Open Questions

Open questions capture missing information that would cause wrong product
direction, security risk, compliance risk, major rework, or unsafe
implementation.

| ID | Question | Blocks | Owner | Status | Resolution |
|----|----------|--------|-------|--------|------------|
| OQ-001 | Will an external tracker (Linear, GitHub Issues, etc.) be used for the downstream project? | Ticket creation only | User or maintainer | open | If unavailable, Markdown backlog remains authoritative. |

## Rules

- Record an open question when missing information would block implementation
  or could cause major rework.
- Resolve questions by recording the answer here and updating affected specs,
  backlog, traceability, current state, and handoff.
EOF


emit "ADR/ADR_INDEX.md" <<EOF
artifact_id: ART-ADR-INDEX
title: ADR Index
type: adr-index
status: active
version: v1.0
created: $extract_date
updated: $extract_date
owner: AI Bootstrap Maintainers
source: Initial bootstrap scaffold
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# ADR Index

Architecture Decision Records live in this folder.

## ADRs

| ADR ID | Title | File | Status | Date | Owner | Linked Specs | Linked Backlog Items | Supersedes | Superseded By |
|--------|-------|------|--------|------|-------|--------------|----------------------|------------|---------------|
EOF


emit "IMPLEMENTATION_PLAN.md" <<EOF
artifact_id: ART-PLAN-001
title: Implementation Plan
type: implementation-plan
status: active
version: v1.0
created: $extract_date
updated: $extract_date
owner: AI Bootstrap Maintainers
source: Initial bootstrap scaffold
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Implementation Plan

This plan covers the bootstrap package itself. Product implementation plans
must be created from product-specific specs.

## Plan

1. Audit target and reference repositories.
2. Create root governance and shared state files.
3. Create spec, ADR, backlog, review, test, artifact, worklog, and handoff
   folder structure.
4. Create templates for specs, ADRs, backlog items, PR review packages, and
   adversarial review.
5. Create branch/worktree, hooks, CI/CD, security, observability, release, and
   contribution guidance.
6. Create lightweight validation script.
7. Run validation and record results.
8. Update current state, handoff, artifact registry, and traceability.

## First Product Implementation Plan

After product input arrives:

1. Product Analyst extracts requirements and open questions.
2. Spec Author creates \`SPECS/SPEC-001-*.md\`.
3. Architect updates \`ARCHITECTURE.md\` and creates ADRs where needed.
4. Backlog Planner creates implementation-ready items.
5. Test and QA Agent maps acceptance criteria to tests.
6. Implementation Agent creates the first branch only after Definition of Ready
   is satisfied.

## Validation Commands

\`\`\`sh
bash SCRIPTS/validate-bootstrap.sh
\`\`\`

Additional stack-specific commands must be defined in project-specific specs or
test plans.

## Rollback Or Recovery

Because this bootstrap is file-based, rollback is standard version control:
revert the change set or restore superseded artifacts from \`ARTIFACTS/ARCHIVE/\`
when appropriate.
EOF

# ---------------------------------------------------------------------------
# README.md clean-state. The extractor must not ship the upstream README to
# downstream consumers. The starter is intentionally minimal and project-
# neutral; consumers replace it with their own README before publishing.
# ---------------------------------------------------------------------------

emit "README.md" <<'EOF'
# Project Name

This repository was initialized from an AI project bootstrap scaffold.

## Next Steps

1. Add product source material to `00_intake/raw/`.
2. Ask an AI agent that follows `AGENTS.md` to run `Start requirement breakdown`.
3. Replace this README with the project's own description before publishing.
EOF

# ---------------------------------------------------------------------------
# ARTIFACT_REGISTRY.md clean-state. The validator checks that every required
# file path appears in this file inside backticks. We emit a minimal but
# complete registry that lists every framework file kept by the extraction.
# ---------------------------------------------------------------------------

emit "ARTIFACT_REGISTRY.md" <<EOF
artifact_id: ART-REG-001
title: Artifact Registry
type: registry
status: authoritative
version: v1.0
created: $extract_date
updated: $extract_date
owner: AI Bootstrap Maintainers
source: Initial bootstrap scaffold
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Artifact Registry

The registry identifies current, authoritative, active, draft, generated,
temporary, superseded, deprecated, cancelled, and archived artifacts. Do not
use superseded, deprecated, cancelled, or archived artifacts as current truth.

Common fields for all entries below unless stated otherwise:

- created: $extract_date
- updated: $extract_date
- created by: scaffold extraction
- owner: AI Bootstrap Maintainers
- linked tickets: none
- replaces: none
- replaced by: none

## Current Authoritative Artifacts

| Artifact ID | Type | Title | File Path | Status | Version | Source Input | Linked Specs | Linked ADRs | Authoritative | Notes |
|-------------|------|-------|-----------|--------|---------|--------------|--------------|-------------|---------------|-------|
| ART-AGENT-CLAUDE | agent-instructions | Claude Instructions | \`CLAUDE.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Short Claude entrypoint. |
| ART-AGENT-GENERIC | agent-instructions | Codex And Generic Agent Instructions | \`AGENTS.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Short generic agent entrypoint. |
| ART-LICENSE | license | License | \`LICENSE\` | authoritative | v1.0 | extracted scaffold | none | none | true | Project license. Downstream forkers must keep or replace per their own license requirements. |
| ART-README | public-readme | README | \`README.md\` | active | v1.0 | extracted scaffold | none | none | false | Project-neutral README starter. Downstream consumers should replace it with their own project description before publishing. |
| ART-GITIGNORE | config | Git Ignore | \`.gitignore\` | active | v1.0 | extracted scaffold | none | none | false | Generic generated-file and secret-adjacent ignores. |
| ART-AI-SHARED-RULES | agent-rules | Shared Agent Rules | \`memory/ai/SHARED_AGENT_RULES.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Shared behavior rules for all coding agents. |
| ART-AI-ROLE-PRODUCT-ANALYST | agent-role | Product Analyst Role | \`memory/ai/ROLE_PRODUCT_ANALYST.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Product discovery role definition. |
| ART-AI-ROLE-SPEC-AUTHOR | agent-role | Spec Author Role | \`memory/ai/ROLE_SPEC_AUTHOR.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Spec creation and maintenance role definition. |
| ART-AI-ROLE-ARCHITECT | agent-role | Architect Role | \`memory/ai/ROLE_ARCHITECT.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Architecture role definition. |
| ART-AI-ROLE-BACKLOG-PLANNER | agent-role | Backlog Planner Role | \`memory/ai/ROLE_BACKLOG_PLANNER.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Backlog planning role definition. |
| ART-AI-ROLE-IMPLEMENTATION-AGENT | agent-role | Implementation Agent Role | \`memory/ai/ROLE_IMPLEMENTATION_AGENT.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Ready-task implementation role definition. |
| ART-AI-ROLE-QA-REVIEWER | agent-role | QA Reviewer Role | \`memory/ai/ROLE_QA_REVIEWER.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Test and acceptance coverage review role definition. |
| ART-AI-ROLE-SECURITY-REVIEWER | agent-role | Security Reviewer Role | \`memory/ai/ROLE_SECURITY_REVIEWER.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Security and privacy review role definition. |
| ART-AI-ROLE-DEVOPS-RELEASE-REVIEWER | agent-role | DevOps Release Reviewer Role | \`memory/ai/ROLE_DEVOPS_RELEASE_REVIEWER.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | CI/CD, release, rollback, and observability review role definition. |
| ART-AI-ROLE-DOCUMENTATION-CURATOR | agent-role | Documentation Curator Role | \`memory/ai/ROLE_DOCUMENTATION_CURATOR.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Shared state and documentation alignment role definition. |
| ART-AI-ROLE-ADVERSARIAL-PR-REVIEWER | agent-role | Adversarial PR Reviewer Role | \`memory/ai/ROLE_ADVERSARIAL_PR_REVIEWER.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Fresh-context PR review role definition. |
| ART-AI-ROLE-RESEARCH-PLANNER | agent-role | Research Planner Role | \`memory/ai/ROLE_RESEARCH_PLANNER.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Research orchestration role definition. |
| ART-AI-ROLE-RESEARCHER | agent-role | Researcher Role | \`memory/ai/ROLE_RESEARCHER.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Reusable one-track research role definition. |
| ART-AI-ROLE-RESEARCH-CRITIC | agent-role | Research Critic Role | \`memory/ai/ROLE_RESEARCH_CRITIC.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Fresh-context research challenge role definition. |
| ART-AI-ROLE-RESEARCH-SYNTHESIZER | agent-role | Research Synthesizer Role | \`memory/ai/ROLE_RESEARCH_SYNTHESIZER.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Research brief synthesis role definition. |
| ART-AI-ROLE-UX-DESIGNER | agent-role | UX Designer Role | \`memory/ai/ROLE_UX_DESIGNER.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Evidence-backed UX brief role definition. |
| ART-BOOT-001 | governance | AI Project Bootstrap Operating System | \`AI_PROJECT_BOOTSTRAP.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Primary entrypoint. |
| ART-BOOT-002 | guide | Bootstrap Usage Guide | \`BOOTSTRAP_USAGE.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | How to use the package. |
| ART-NEW-PROJECT-INIT | guide | New Project Initialization | \`NEW_PROJECT_INITIALIZATION.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | New downstream project initialization prompt. |
| ART-GOV-001 | governance | Governance | \`GOVERNANCE.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Core governance rules. |
| ART-OPS-ROUTING-001 | governance | Operation Routing And Impact Map | \`OPERATION_ROUTING.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Adaptive governance control plane. |
| ART-CTX-001 | guide | Context Index | \`CONTEXT_INDEX.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Required reading map. |
| ART-ARCH-001 | architecture | Bootstrap Architecture | \`ARCHITECTURE.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Process architecture. |
| ART-ADR-001 | adr-guide | Decision Governance | \`DECISIONS.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | ADR rules. |
| ART-GIT-001 | guide | Branch And Worktree Guide | \`BRANCH_AND_WORKTREE_GUIDE.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Git and worktree rules. |
| ART-REG-001 | registry | Artifact Registry | \`ARTIFACT_REGISTRY.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Artifact inventory. |
| ART-TRACE-001 | traceability | Traceability Matrix | \`TRACEABILITY_MATRIX.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Requirement-to-evidence map. |
| ART-TEST-001 | test-strategy | Test Strategy | \`TEST_STRATEGY.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Testing principles. |
| ART-REVIEW-001 | review-policy | PR Review Policy | \`PR_REVIEW_POLICY.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Adversarial review rules. |
| ART-REVIEW-002 | merge-policy | PR Merge Policy | \`PR_MERGE_POLICY.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Merge gate. |
| ART-REVIEW-003 | prompt-library | AI Review Prompts | \`AI_REVIEW_PROMPTS.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Reviewer prompt library. |
| ART-RISK-001 | risk-model | Risk Model | \`RISK_MODEL.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Review effort selection. |
| ART-HOOKS-001 | guide | Hooks And Guardrails | \`HOOKS_AND_GUARDRAILS.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Local hook and CI guardrail guidance. |
| ART-SEC-001 | security | Security And Privacy | \`SECURITY_AND_PRIVACY.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Security rules. |
| ART-OBS-001 | observability | Observability | \`OBSERVABILITY.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Observability rules. |
| ART-CI-001 | ci-guide | CI/CD Guide | \`CI_CD_GUIDE.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | CI guidance. |
| ART-REL-001 | release | Release Readiness | \`RELEASE_READINESS.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Release checklist. |
| ART-CONTRIB-001 | contribution-guide | Contributing | \`CONTRIBUTING.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Contributor workflow. |

## Active Shared State Artifacts

| Artifact ID | Type | Title | File Path | Status | Version | Source Input | Linked Specs | Linked ADRs | Authoritative | Notes |
|-------------|------|-------|-----------|--------|---------|--------------|--------------|-------------|---------------|-------|
| ART-STATE-002 | shared-state | Current State | \`CURRENT_STATE.md\` | active | v1.0 | extracted scaffold | none | none | false | Current operational view. |
| ART-STATE-003 | shared-state | AI Handoff | \`AI_HANDOFF.md\` | active | v1.0 | extracted scaffold | none | none | false | Agent transition state. |
| ART-STATE-004 | shared-state | Open Questions | \`OPEN_QUESTIONS.md\` | active | v1.0 | extracted scaffold | none | none | false | Unresolved blockers. |
| ART-BACKLOG-001 | backlog | Backlog | \`BACKLOG.md\` | active | v1.0 | extracted scaffold | none | none | true | Current backlog mirror. |
| ART-PLAN-001 | implementation-plan | Implementation Plan | \`IMPLEMENTATION_PLAN.md\` | active | v1.0 | extracted scaffold | none | none | true | Bootstrap implementation plan. |
| ART-TEST-003 | test-results | Test Results | \`TEST_RESULTS.md\` | active | v1.0 | extracted scaffold | none | none | false | Validation history. |

## Template And Directory Artifacts

| Artifact ID | Type | Title | File Path | Status | Version | Source Input | Linked Specs | Linked ADRs | Authoritative | Notes |
|-------------|------|-------|-----------|--------|---------|--------------|--------------|-------------|---------------|-------|
| ART-SPEC-INDEX | spec-index | Spec Index | \`SPECS/SPEC_INDEX.md\` | active | v1.0 | extracted scaffold | none | none | true | Spec inventory. |
| ART-SPEC-TEMPLATE | template | Spec Template | \`SPECS/templates/SPEC_TEMPLATE.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Spec authoring template. |
| ART-ADR-INDEX | adr-index | ADR Index | \`ADR/ADR_INDEX.md\` | active | v1.0 | extracted scaffold | none | none | true | ADR inventory. |
| ART-ADR-TEMPLATE | template | ADR Template | \`ADR/templates/ADR_TEMPLATE.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | ADR authoring template. |
| ART-BACKLOG-INDEX | backlog-index | Backlog Index | \`BACKLOG/BACKLOG_INDEX.md\` | active | v1.0 | extracted scaffold | none | none | true | Backlog item inventory. |
| ART-BACKLOG-TEMPLATE | template | Backlog Item Template | \`BACKLOG/templates/BACKLOG_ITEM_TEMPLATE.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Backlog item template. |
| ART-REVIEW-INDEX | review-index | Review Index | \`REVIEWS/REVIEW_INDEX.md\` | active | v1.0 | extracted scaffold | none | none | true | Review record inventory. |
| ART-REVIEW-PR-TEMPLATE | template | PR Review Package Template | \`REVIEWS/templates/PR_REVIEW_PACKAGE_TEMPLATE.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | PR review package template. |
| ART-REVIEW-ADVERSARIAL-TEMPLATE | template | Adversarial PR Review Template | \`REVIEWS/templates/ADVERSARIAL_PR_REVIEW_TEMPLATE.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Adversarial PR review template. |
| ART-TEST-MANUAL-CHECKLIST | manual-test-checklist | Manual Test Checklist | \`TESTS/MANUAL_TEST_CHECKLIST.md\` | active | v1.0 | extracted scaffold | none | none | false | Manual test checklist. |
| ART-WORKLOG-INDEX | worklog | Worklog Index | \`WORKLOG/WORKLOG_INDEX.md\` | active | v1.0 | extracted scaffold | none | none | false | Session worklog. |
| ART-INTAKE-INDEX | intake-index | Intake Index | \`00_intake/INTAKE_INDEX.md\` | active | v1.0 | extracted scaffold | none | none | true | Canonical intake folder index. |
| ART-SOURCE-REGISTRY | source-registry | Source Registry | \`00_intake/SOURCE_REGISTRY.md\` | active | v1.0 | extracted scaffold | none | none | true | Source registry with stable SRC-* IDs. |
| ART-PROJECT-BRIEF | guide | Project Brief | \`01_context/PROJECT_BRIEF.md\` | active | v1.0 | extracted scaffold | none | none | false | Downstream project brief template. |
| ART-PROJECT-CHARTER | guide | Project Charter | \`01_context/PROJECT_CHARTER.md\` | active | v1.0 | extracted scaffold | none | none | false | Downstream project charter template. |
| ART-GLOSSARY | guide | Glossary | \`01_context/GLOSSARY.md\` | active | v1.0 | extracted scaffold | none | none | false | Downstream glossary template. |
| ART-CONSTRAINTS | guide | Constraints | \`01_context/CONSTRAINTS.md\` | active | v1.0 | extracted scaffold | none | none | false | Downstream constraints template. |
| ART-CONTEXT-UX-BRIEF | guide | UX Brief | \`01_context/UX_BRIEF.md\` | active | v1.0 | extracted scaffold | none | none | true | Downstream UX brief template. |
| ART-REQUIREMENTS-INDEX | requirements-index | Requirements Index | \`02_requirements/REQUIREMENTS_INDEX.md\` | active | v1.0 | extracted scaffold | none | none | true | Downstream requirements index. |
| ART-ASSUMPTIONS-REGISTER | assumptions-register | Assumptions Register | \`02_requirements/ASSUMPTIONS_REGISTER.md\` | active | v1.0 | extracted scaffold | none | none | true | Downstream assumptions register. |
| ART-RISK-REGISTER | risk-register | Risk Register | \`02_requirements/RISK_REGISTER.md\` | active | v1.0 | extracted scaffold | none | none | true | Downstream risk register. |
| ART-CONTEXT-PACK-README | guide | Context Packs README | \`CONTEXT_PACKS/README.md\` | active | v1.0 | extracted scaffold | none | none | false | Context pack index. |
| ART-CONTEXT-PACK-PRODUCT | context-pack | Product Intake Context Pack | \`CONTEXT_PACKS/product-intake.md\` | active | v1.0 | extracted scaffold | none | none | true | Product intake context pack. |
| ART-CONTEXT-PACK-RESEARCH | context-pack | Research Context Pack | \`CONTEXT_PACKS/research.md\` | active | v1.0 | extracted scaffold | none | none | true | Research orchestration context pack. |
| ART-CONTEXT-PACK-SPEC | context-pack | Spec Authoring Context Pack | \`CONTEXT_PACKS/spec-authoring.md\` | active | v1.0 | extracted scaffold | none | none | true | Spec authoring context pack. |
| ART-CONTEXT-PACK-ARCH | context-pack | Architecture Context Pack | \`CONTEXT_PACKS/architecture.md\` | active | v1.0 | extracted scaffold | none | none | true | Architecture context pack. |
| ART-CONTEXT-PACK-IMPL | context-pack | Implementation Context Pack | \`CONTEXT_PACKS/implementation.md\` | active | v1.0 | extracted scaffold | none | none | true | Implementation context pack. |
| ART-CONTEXT-PACK-REVIEW | context-pack | Review Context Pack | \`CONTEXT_PACKS/review.md\` | active | v1.0 | extracted scaffold | none | none | true | Review context pack. |
| ART-CONTEXT-PACK-RESUME | context-pack | Resume Context Pack | \`CONTEXT_PACKS/resume.md\` | active | v1.0 | extracted scaffold | none | none | true | Resume context pack. |
| ART-COMMAND-INDEX | command-index | Command Index | \`COMMANDS/COMMAND_INDEX.md\` | active | v1.0 | extracted scaffold | none | none | true | Command index. |
| ART-COMMAND-TEMPLATE | template | Command Template | \`COMMANDS/COMMAND_TEMPLATE.md\` | authoritative | v1.0 | extracted scaffold | none | none | true | Command authoring template. |
| ART-COMMAND-START-REQUIREMENT-BREAKDOWN | command | Start Requirement Breakdown | \`COMMANDS/start-requirement-breakdown.md\` | active | v1.0 | extracted scaffold | none | none | false | Reusable downstream project intake and requirement breakdown workflow command triggered by \`Start requirement breakdown\`. |
| ART-COMMAND-VALIDATE-IDEA | command | Validate The Idea | \`COMMANDS/validate-idea.md\` | active | v1.0 | extracted scaffold | none | none | false | Evidence-backed idea validation workflow. |
| ART-COMMAND-START-RESEARCH | command | Start Research | \`COMMANDS/start-research.md\` | active | v1.0 | extracted scaffold | none | none | false | Research orchestration pipeline to a user-gated brief. |
| ART-COMMAND-START-ARCH | command | Start Architecture Design | \`COMMANDS/start-architecture-design.md\` | active | v1.0 | extracted scaffold | none | none | false | Intent-to-architecture workflow. |
| ART-COMMAND-IMPLEMENT-NEXT | command | Implement Next Story | \`COMMANDS/implement-next-story.md\` | active | v1.0 | extracted scaffold | none | none | false | Scoped-validation story execution workflow. |
| ART-COMMAND-RESUME-WORK | command | Resume Work | \`COMMANDS/resume-work.md\` | active | v1.0 | extracted scaffold | none | none | false | Minimum-read session resume workflow. |
| ART-COMMAND-EXPORT-LINEAR | command | Export Backlog To Linear | \`COMMANDS/export-backlog-to-linear.md\` | active | v1.0 | extracted scaffold | none | none | false | Deterministic, dedupe-safe Linear export. |
| ART-SCRIPT-SESSION | script | Session Helper | \`SCRIPTS/session.sh\` | active | v1.0 | extracted scaffold | none | none | false | Writes \`.ai/SESSION.md\` so the validation fast path is reachable. |
| ART-SCRIPT-DOCTOR | script | Doctor Status Command | \`SCRIPTS/doctor.sh\` | active | v1.0 | extracted scaffold | none | none | false | Read-only orientation status. |
| ART-SCRIPT-STRICT-GATE | script | Strict Gate Paths | \`SCRIPTS/strict-gate-paths.sh\` | active | v1.0 | extracted scaffold | none | none | false | Single source of the strict-gate path pattern. |
| ART-STARTER-SESSION | template-starter | Session Starter | \`TEMPLATE_STARTERS/SESSION.md\` | active | v1.0 | extracted scaffold | none | none | false | Format reference for \`.ai/SESSION.md\`. |
| ART-STARTER-AC-MAP | template-starter | Acceptance Criteria Map Starter | \`TEMPLATE_STARTERS/ACCEPTANCE_CRITERIA_MAP.md\` | active | v1.0 | extracted scaffold | none | none | false | Clean acceptance-criteria map starter. |
| ART-TEMPLATE-TECH-DESIGN | template | Tech Design Template | \`SPECS/templates/TECH_DESIGN_TEMPLATE.md\` | active | v1.0 | extracted scaffold | none | none | false | One-page solution design skeleton. |
| ART-TEMPLATE-RESEARCH-NOTE | template | Research Note Template | \`00_intake/research/RESEARCH_NOTE_TEMPLATE.md\` | active | v1.0 | extracted scaffold | none | none | false | Assumption-to-evidence research note. |
| ART-TEMPLATE-RESEARCH-PLAN | template | Research Plan Template | \`00_intake/research/RESEARCH_PLAN_TEMPLATE.md\` | active | v1.0 | extracted scaffold | none | none | false | Research run depth, tracks, caps, and gates. |
| ART-TEMPLATE-RESEARCH-REPORT | template | Research Report Template | \`00_intake/research/RESEARCH_REPORT_TEMPLATE.md\` | active | v1.0 | extracted scaffold | none | none | false | Per-track evidence log with counterexamples. |
| ART-TEMPLATE-RESEARCH-CRITIC-REVIEW | template | Research Critic Review Template | \`00_intake/research/RESEARCH_CRITIC_REVIEW_TEMPLATE.md\` | active | v1.0 | extracted scaffold | none | none | false | Critic checklist, findings, and verdicts. |
| ART-TEMPLATE-RESEARCH-BRIEF | template | Research Brief Template | \`00_intake/research/RESEARCH_BRIEF_TEMPLATE.md\` | active | v1.0 | extracted scaffold | none | none | false | Decision-ready brief gated on explicit user approval. |
| ART-TEMPLATE-SUMMARY | template | Source Summary Template | \`00_intake/summaries/SUMMARY_TEMPLATE.md\` | active | v1.0 | extracted scaffold | none | none | false | Compact source summary schema. |
| ART-INTAKE-RAW-DIR | input-directory | Raw Intake Directory | \`00_intake/raw/.gitkeep\` | active | v1.0 | extracted scaffold | none | none | false | Placeholder keeps the canonical raw intake directory present. |
| ART-INTAKE-SUMMARIES-DIR | input-directory | Intake Summaries Directory | \`00_intake/summaries/.gitkeep\` | active | v1.0 | extracted scaffold | none | none | false | Placeholder keeps the intake summaries directory present. |
| ART-ARTIFACTS-DIR | input-directory | Artifacts Directory | \`ARTIFACTS/.gitkeep\` | active | v1.0 | extracted scaffold | none | none | false | Placeholder keeps the artifacts directory present. |
| ART-ARTIFACTS-ARCHIVE-DIR | input-directory | Artifacts Archive Directory | \`ARTIFACTS/ARCHIVE/.gitkeep\` | active | v1.0 | extracted scaffold | none | none | false | Placeholder keeps the artifacts archive directory present. |
| ART-VALIDATOR-SCRIPT | guide | Validator Script | \`SCRIPTS/validate-bootstrap.sh\` | authoritative | v1.0 | extracted scaffold | none | none | true | Bootstrap validator. |
| ART-VALIDATOR-RED-CHECKS | guide | Validator Red Checks | \`SCRIPTS/validate-bootstrap-red-checks.sh\` | authoritative | v1.0 | extracted scaffold | none | none | true | Validator red-check fixtures. |
| ART-START-CLAUDE | guide | Claude Startup Helper | \`SCRIPTS/start-claude.sh\` | authoritative | v1.0 | extracted scaffold | none | none | true | Claude startup helper. |
| ART-OPERATION-PROFILE | guide | Operation Profile Extractor | \`SCRIPTS/operation-profile.sh\` | authoritative | v1.0 | extracted scaffold | none | none | true | Slice 4 adaptive-routing extractor: reads AI_HANDOFF.md Operation profile and maps to validator level. |
| ART-PRECOMMIT-HOOK | guide | Pre-Commit Hook | \`.githooks/pre-commit\` | authoritative | v1.0 | extracted scaffold | none | none | true | Pre-commit local hook. |
| ART-COMMITMSG-HOOK | guide | Commit Message Hook | \`.githooks/commit-msg\` | authoritative | v1.0 | extracted scaffold | none | none | true | Commit message local hook. |
| ART-PREPUSH-HOOK | guide | Pre-Push Hook | \`.githooks/pre-push\` | authoritative | v1.0 | extracted scaffold | none | none | true | Pre-push local hook. |
| ART-CI-WORKFLOW | guide | CI Bootstrap Validation Workflow | \`.github/workflows/bootstrap-validation.yml\` | authoritative | v1.0 | extracted scaffold | none | none | true | CI workflow running the bootstrap validator. |
| ART-METRIC-EVIDENCE-COVERAGE | guide | Evidence Coverage Metric Script | \`SCRIPTS/metric-evidence-coverage.sh\` | authoritative | v1.0 | extracted scaffold | none | none | true | Reports spec-FR and backlog source-coverage metrics; first empirical evidence measurement for downstream scaffolds. |
| ART-METRIC-ACCEPTANCE-COVERAGE | guide | Acceptance Coverage Metric Script | \`SCRIPTS/metric-acceptance-coverage.sh\` | authoritative | v1.0 | extracted scaffold | none | none | true | Reports acceptance-criteria coverage metrics. |
| ART-METRIC-TRACEABILITY-COMPLETENESS | guide | Traceability Completeness Metric Script | \`SCRIPTS/metric-traceability-completeness.sh\` | authoritative | v1.0 | extracted scaffold | none | none | true | Reports bootstrap-requirement traceability completeness metrics from \`TRACEABILITY_MATRIX.md\`. |

## Lifecycle Rules

- Update this registry whenever an artifact is created, changed, superseded,
  cancelled, archived, or replaced.
- Status values: draft, active, authoritative, superseded, deprecated,
  cancelled, archived, generated, temporary.
- Add new project-specific artifacts (specs, ADRs, backlog items, reviews,
  worklogs) here when they are created.
EOF

# ---------------------------------------------------------------------------
# Phase 4: Write the positive downstream scaffold mode marker.
#
# `.bootstrap-scaffold-mode` is the positive marker the validator uses to
# decide between maintainer and downstream mode. The source repository
# `.gitignore` ignores this file so it cannot be accidentally committed.
# ---------------------------------------------------------------------------

log "Phase 4: write .bootstrap-scaffold-mode marker"
if [[ "$apply" -eq 1 ]]; then
  printf 'downstream\n' >"$target_abs/.bootstrap-scaffold-mode"
fi

# ---------------------------------------------------------------------------
# Phase 5: Extracted target contract check.
#
# Fail extraction if forbidden paths or upstream owner strings made it into
# the target, or if generated project-owned files contain bare ProjectGenesis.
# This check runs even when --no-validate is passed; the only validator that
# may be skipped via --no-validate is bash SCRIPTS/validate-bootstrap.sh.
# ---------------------------------------------------------------------------

run_contract_check() {
  local target="$1"
  local violations=0
  local path
  local file
  local match_output

  log "Phase 5: extracted-target contract check"

  for path in "${FORBIDDEN_PATHS[@]}"; do
    if [[ -e "$target/$path" ]]; then
      log "  CONTRACT FAIL: forbidden path present: $path"
      violations=$((violations + 1))
    fi
  done

  for path in "${EXTRA_EXCLUDED_PATHS[@]}"; do
    if [[ -e "$target/$path" ]]; then
      log "  CONTRACT FAIL: extra-excluded path present: $path"
      violations=$((violations + 1))
    fi
  done

  # Search for forbidden upstream strings in active extracted files. The .git
  # directory is excluded if present, though extraction should not copy it.
  local grep_pattern
  grep_pattern="$(printf '%s|' "${FORBIDDEN_STRINGS[@]}")"
  grep_pattern="${grep_pattern%|}"
  if match_output="$(grep -RInE "$grep_pattern" \
        --exclude-dir='.git' \
        "$target" 2>/dev/null)"; then
    while IFS= read -r line; do
      [[ -z "$line" ]] && continue
      log "  CONTRACT FAIL: forbidden upstream string: $line"
      violations=$((violations + 1))
    done <<< "$match_output"
  fi

  # Bare ProjectGenesis is forbidden in generated project-owned files only.
  # Bare ProjectGenesis in copied framework documentation is allowed
  # attribution (see implementation summary).
  for file in "${PROJECT_OWNED_GENERATED_FILES[@]}"; do
    if [[ -f "$target/$file" ]]; then
      if match_output="$(grep -n 'ProjectGenesis' "$target/$file" 2>/dev/null)"; then
        while IFS= read -r line; do
          [[ -z "$line" ]] && continue
          log "  CONTRACT FAIL: bare ProjectGenesis in project-owned file $file: $line"
          violations=$((violations + 1))
        done <<< "$match_output"
      fi
    else
      log "  CONTRACT FAIL: missing project-owned file: $file"
      violations=$((violations + 1))
    fi
  done

  if (( violations > 0 )); then
    echo "ERROR: extracted-target contract check failed with $violations violation(s)." >&2
    return 1
  fi

  log "  contract check passed"
  return 0
}

if [[ "$apply" -eq 1 ]]; then
  if ! run_contract_check "$target_abs"; then
    exit 1
  fi
else
  log "Phase 5: skipped (dry-run; contract check requires --apply)"
fi

# ---------------------------------------------------------------------------
# Phase 6: Advisory coherence reporting (non-blocking).
#
# Compare the extractor's forbidden-path contract with TEMPLATE_MANIFEST.md
# to surface drift. This check is advisory: drift is logged with an
# ADVISORY prefix and does not fail extraction, validation, hooks, or CI in
# this slice. Source-of-truth resolution stays in the implementation
# summary, not in this script's exit status.
# ---------------------------------------------------------------------------

run_advisory_coherence_check() {
  local manifest="$source_root/TEMPLATE_MANIFEST.md"
  if [[ ! -f "$manifest" ]]; then
    log "Phase 6: advisory coherence check skipped (manifest not present)"
    return 0
  fi

  log "Phase 6: advisory coherence check (manifest vs extractor)"

  local path
  local manifest_line
  for path in "${FORBIDDEN_PATHS[@]}"; do
    # Only flag if manifest describes the path as `copy` or `copy-clean` in a
    # table row. Header text and prose mentioning the same path do not count.
    if manifest_line="$(grep -E "\`$path\`.*\| \`?(copy|copy-clean)\`?" "$manifest" 2>/dev/null)"; then
      if [[ -n "$manifest_line" ]]; then
        log "  ADVISORY: extractor excludes \`$path\` but manifest still classifies it as copy: ${manifest_line%% |*}"
      fi
    fi
  done

  # .github/CODEOWNERS-specific advisory: legacy manifest text described it as
  # reusable. Flag any remaining text-level mention so the manifest and
  # extractor stay aligned over time.
  if grep -qE "\`\.github/CODEOWNERS\`.*reusable" "$manifest"; then
    log "  ADVISORY: \`.github/CODEOWNERS\` described in manifest as reusable, but extractor excludes it."
  fi

  return 0
}

run_advisory_coherence_check || true

# ---------------------------------------------------------------------------
# Phase 7: Optional in-target bootstrap validation.
# ---------------------------------------------------------------------------

if [[ "$apply" -eq 1 ]] && [[ "$validate" -eq 1 ]]; then
  log "Phase 7: run bash SCRIPTS/validate-bootstrap.sh inside target"
  (
    cd "$target_abs"
    bash SCRIPTS/validate-bootstrap.sh
  )
elif [[ "$apply" -ne 1 ]]; then
  log "Phase 7: skipped (dry-run mode; pass --apply to write and validate)"
else
  log "Phase 7: skipped (--no-validate)"
fi

log "Done."
