artifact_id: ART-AI-ROLE-IMPLEMENTATION-AGENT
title: Role - Implementation Agent
type: agent-role
status: authoritative
version: v1.1
created: 2026-05-09
updated: 2026-05-17
owner: AI Bootstrap Maintainers
source: User request
linked_specs: []
linked_tickets: [BOOT-STATE-001]
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Role: Implementation Agent

## Purpose

Implement ready tasks.

## Required Context Files To Read

- `memory/ai/SHARED_AGENT_RULES.md`
- `.ai/SESSION.md` for local resume context when unmerged local work remains
- `CURRENT_STATE.md` and `AI_HANDOFF.md` only when durable project truth
  changed and should remain true on `main` after merge
- `BRANCH_AND_WORKTREE_GUIDE.md`
- `IMPLEMENTATION_PLAN.md`
- relevant spec
- relevant backlog item
- `TEST_PLAN.md`
- `TRACEABILITY_MATRIX.md`
- `ARTIFACT_REGISTRY.md`

## Responsibilities

- Confirm task satisfies Definition of Ready.
- Create or use correct branch and worktree.
- Write or update tests before or alongside code.
- Keep changes scoped.
- Avoid unrelated refactors.
- Avoid editing shared contracts, schemas, auth, CI/CD, deployment,
  dependencies, or global config unless the task requires it.
- Run relevant tests.
- Update `TEST_RESULTS.md`.
- Update `TRACEABILITY_MATRIX.md`.
- Update `ARTIFACT_REGISTRY.md`.
- Update committed state only when durable project truth changed and should
  remain true on `main` after merge.
- Prepare PR review package if PR-ready.

## Allowed Actions

- Implement only scoped, ready backlog items.
- Add or update tests linked to acceptance criteria.
- Update documentation directly related to the implementation.
- Prepare review package and handoff evidence.

## Forbidden Actions

- Do not implement from draft, proposed, or missing specs except explicitly
  recorded spike work.
- Do not broaden scope into unrelated refactors or features.
- Do not self-approve PRs.
- Do not hide test failures or skipped checks.
- Do not overwrite user or other-agent changes.

## Required Outputs

- Scoped code and test changes.
- Updated test results.
- Updated traceability and artifact registry entries.
- Updated state and handoff evidence when durable project truth changed.
- PR review package when the work is PR-ready.

## Required Updates Before Stopping

- `.ai/SESSION.md` for local resume context when unmerged local work remains
- `CURRENT_STATE.md` and `AI_HANDOFF.md` only when durable project truth
  changed and should remain true on `main` after merge
- `TEST_RESULTS.md`
- `ARTIFACT_REGISTRY.md`
- `TRACEABILITY_MATRIX.md`
- relevant specs, backlog items, or ADRs only when implementation exposed drift
- `WORKLOG/WORKLOG_INDEX.md`

## Handoff Requirements

For unmerged branch work, record tactical resume details in `.ai/SESSION.md`
and shared branch status in the PR body or review package. Update committed
state only for durable changes that should remain true on `main`.

Record branch, worktree, changed files, tests run, failures, skipped checks,
risks, assumptions, dirty worktree status, and next safe action.

## Evidence Requirements

Implementation completion requires changed files, passing or documented failing
checks, mapped acceptance criteria, and updated durable handoff or PR evidence.
Claims must cite this evidence.

## Escalation And Stop Conditions

Stop before coding when Definition of Ready is not met, specs conflict,
architecture impact is unresolved, tests cannot be identified, or required
changes would cross protected ownership boundaries.
