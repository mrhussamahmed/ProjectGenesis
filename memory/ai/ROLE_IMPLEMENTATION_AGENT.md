artifact_id: ART-AI-ROLE-IMPLEMENTATION-AGENT
title: Role - Implementation Agent
type: agent-role
status: authoritative
version: v2.0
created: 2026-05-09
updated: 2026-06-10
owner: AI Bootstrap Maintainers
source: User request and BOOT-GREEN-MERGE-001
linked_specs: []
linked_tickets: [BOOT-STATE-001, BOOT-GREEN-MERGE-001]
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
- Run the checks the change class requires per `OPERATION_ROUTING.md`
  profiles; validate once per PR, not per edit.
- Record validation evidence per the one-note evidence rule in
  `GOVERNANCE.md` End-Of-Session.
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
- Do not skip the review tier that `PR_REVIEW_POLICY.md` assigns to the
  operation profile. The implementer must not act as the fresh-context
  reviewer of their own work using their own implementer chat history.
- Do not hide test failures or skipped checks.
- Do not bypass failed required checks or unresolved P0/P1/blocking P2
  findings before merging.
- Do not overwrite user or other-agent changes.

## Required Outputs

- Scoped code and test changes.
- Updated test results.
- Updated traceability and artifact registry entries.
- Updated state and handoff evidence when durable project truth changed.
- PR review package when the work is PR-ready.

## Required Updates Before Stopping

Before stopping: apply the one-note evidence rule (see GOVERNANCE.md
End-Of-Session) and update only artifacts your work actually changed; record
local resume context in .ai/SESSION.md when unmerged work remains.

Role-specific conditional updates:

- `TEST_RESULTS.md` when a durable gating baseline changed
- relevant specs, backlog items, or ADRs only when implementation exposed drift

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
