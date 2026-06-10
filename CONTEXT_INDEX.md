artifact_id: ART-CTX-001
title: Context Index
type: guide
status: authoritative
version: v2.0
created: 2026-05-09
updated: 2026-06-10
owner: AI Bootstrap Maintainers
source: User request, reference repository audit, SPEC-BOOT-002, SPEC-BOOT-003, and GEN-01 single read contract
linked_specs: [SPEC-BOOT-002, SPEC-BOOT-003]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Context Index

This file is the single read-list authority. No other file may enumerate
required-reading lists; entrypoints, guides, and commands point here. Read the
minimum context, then the section for your task, then work. If context is too
large, state what was skipped before stopping.

For instant orientation run `bash SCRIPTS/doctor.sh`. To enable scoped
validation for the session run `bash SCRIPTS/session.sh start <profile>`.

## Minimum Context Before Any Work

- `memory/ai/SHARED_AGENT_RULES.md`
- the selected `memory/ai/ROLE_*.md` file for the task
- `CURRENT_STATE.md`
- `AI_HANDOFF.md`
- this file (`CONTEXT_INDEX.md`)
- `git status --short --branch`, when Git is available

Escalate beyond a task section only through the read tiers in
`OPERATION_ROUTING.md`. Registry, traceability, and test evidence
(`ARTIFACT_REGISTRY.md`, `TRACEABILITY_MATRIX.md`, `TEST_RESULTS.md`) are
Tier 3 verification reads: open them when the operation profile or unresolved
evidence requires them, not by default.

## Command Shortcuts

When a user gives a short workflow phrase, read `COMMANDS/COMMAND_INDEX.md`.
If the phrase is an exact or unambiguous trigger, read the matched command file
and follow its required role, required reads, stop conditions, validation, and
authority limit. If the trigger or required input is ambiguous, ask for
clarification.

## Intake

- `CONTEXT_PACKS/product-intake.md`
- `00_intake/INTAKE_INDEX.md`
- `00_intake/SOURCE_REGISTRY.md`
- `OPEN_QUESTIONS.md`
- product input files under `00_intake/raw/`
- research notes under `00_intake/research/`, when validating assumptions

## Spec And Backlog

- `SPECS/SPEC_INDEX.md`
- `SPECS/templates/SPEC_TEMPLATE.md`, for new specs
- `02_requirements/REQUIREMENTS_INDEX.md`
- `BACKLOG/BACKLOG_INDEX.md`
- `BACKLOG/templates/BACKLOG_ITEM_TEMPLATE.md`, for new items

## Architecture

- `ARCHITECTURE.md`
- `DECISIONS.md` and `ADR/ADR_INDEX.md`
- `SPECS/templates/TECH_DESIGN_TEMPLATE.md`, for new designs
- `RISK_MODEL.md` and `SECURITY_AND_PRIVACY.md`, when risk or data handling
  changes

## Implementation

- the linked spec and backlog item
- relevant ADRs
- `TEST_PLAN.md` and the item's test expectations
- `BRANCH_AND_WORKTREE_GUIDE.md`, when branching is unclear
- `PARALLEL_EXECUTION_PLAN.md`, only when concurrent work exists (maintainer
  repo only; downstream projects create their own plan when needed)

## Review

- `PR_REVIEW_POLICY.md` and `PR_MERGE_POLICY.md`
- the PR diff and review package under `REVIEWS/`
- the linked spec, backlog item, and ADRs
- `TRACEABILITY_MATRIX.md` and `ARTIFACT_REGISTRY.md`, when verifying evidence
  claims

## Resume

- `.ai/SESSION.md`, when present: the first resume read for local unmerged work
- `CURRENT_STATE.md` and `AI_HANDOFF.md`
- `git status --short --branch`
- the artifacts named in the handoff's next recommended action

For any other task (testing, release, governance maintenance), classify the
operation per `OPERATION_ROUTING.md` and read only what its profile and read
tiers require.
