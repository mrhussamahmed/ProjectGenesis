artifact_id: ART-CTX-001
title: Context Index
type: guide
status: authoritative
version: v1.2
created: 2026-05-09
updated: 2026-05-13
owner: AI Bootstrap Maintainers
source: User request, reference repository audit, and SPEC-BOOT-002
linked_specs: [SPEC-BOOT-002]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Context Index

This file tells AI agents what to read first. If context is too large, read the
minimum context, state what was skipped, and update `AI_HANDOFF.md` before
stopping.

## Shared AI role system

All agents use `memory/ai/SHARED_AGENT_RULES.md` before meaningful work. Each
task uses one primary `memory/ai/ROLE_*.md` file that defines the operating
role for that session.

Claude may load role files through `SCRIPTS/start-claude.sh`. Codex reads the
same role files directly. Claude startup prompts are optional convenience only;
they are not the source of truth.

Role files do not replace specs, ADRs, backlog, traceability, artifact
registry, current state, or handoff. Role files define behavior. Project files
define project truth.

## Minimum Context Before Any Work

- `CURRENT_STATE.md`
- `AI_HANDOFF.md`
- `ARTIFACT_REGISTRY.md`
- `SPECS/SPEC_INDEX.md`
- `TRACEABILITY_MATRIX.md`
- `BRANCH_AND_WORKTREE_GUIDE.md`
- `GOVERNANCE.md`
- relevant spec files
- relevant ADRs
- `git status --short --branch`, when Git is available

## Product Intake

- `BOOTSTRAP_USAGE.md`
- `00_intake/INTAKE_INDEX.md`
- `00_intake/SOURCE_REGISTRY.md`
- `OPEN_QUESTIONS.md`
- product input files under `00_intake/raw/`, if present
- compatibility input files under `INPUT/`, if present
- `SPECS/templates/SPEC_TEMPLATE.md`
- `BACKLOG/templates/BACKLOG_ITEM_TEMPLATE.md`

`00_intake/raw/` is the canonical raw intake folder. `INPUT/` remains a legacy
alias during migration and must point agents back to the canonical intake
registry.

## Implementation

- `AI_PROJECT_BOOTSTRAP.md`
- `CURRENT_STATE.md`
- `AI_HANDOFF.md`
- relevant spec
- relevant backlog item
- relevant ADRs
- `TEST_PLAN.md`
- `TESTS/ACCEPTANCE_CRITERIA_MAP.md`
- `BRANCH_AND_WORKTREE_GUIDE.md`
- `PARALLEL_EXECUTION_PLAN.md`, if concurrent work exists

## Architecture Work

- `ARCHITECTURE.md`
- `DECISIONS.md`
- `ADR/ADR_INDEX.md`
- `ADR/templates/ADR_TEMPLATE.md`
- `RISK_MODEL.md`
- `SECURITY_AND_PRIVACY.md`
- `OBSERVABILITY.md`

## Testing

- `TEST_STRATEGY.md`
- `TEST_PLAN.md`
- `TESTS/ACCEPTANCE_CRITERIA_MAP.md`
- `TESTS/MANUAL_TEST_CHECKLIST.md`
- relevant spec acceptance criteria
- `TEST_RESULTS.md`

## PR Review

- `PR_REVIEW_POLICY.md`
- `PR_MERGE_POLICY.md`
- `AI_REVIEW_PROMPTS.md`
- review package under `REVIEWS/`
- PR diff or local diff
- relevant specs, ADRs, tests, backlog items
- `TRACEABILITY_MATRIX.md`
- `ARTIFACT_REGISTRY.md`
- `CURRENT_STATE.md`
- `AI_HANDOFF.md`

## Backlog Planning

- source input
- `SPECS/SPEC_INDEX.md`
- approved or proposed specs
- `BACKLOG.md`
- `BACKLOG/BACKLOG_INDEX.md`
- `PARALLEL_EXECUTION_PLAN.md`
- `RISK_MODEL.md`
- `BRANCH_AND_WORKTREE_GUIDE.md`

## Handoff

- `AI_HANDOFF.md`
- `HANDOFFS/HANDOFF_INDEX.md`
- `WORKLOG/WORKLOG_INDEX.md`
- `CURRENT_STATE.md`
- `TEST_RESULTS.md`
- `git status --short --branch`

## Release

- `RELEASE_READINESS.md`
- `CI_CD_GUIDE.md`
- `OBSERVABILITY.md`
- `SECURITY_AND_PRIVACY.md`
- `PR_MERGE_POLICY.md`
- `TRACEABILITY_MATRIX.md`
- `TEST_RESULTS.md`
