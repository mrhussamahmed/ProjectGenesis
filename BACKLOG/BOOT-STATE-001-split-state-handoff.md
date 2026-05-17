artifact_id: ART-BACKLOG-BOOT-STATE-001
title: Split-State Handoff Boundary
type: backlog-item
status: in-review
version: v1.0
created: 2026-05-17
updated: 2026-05-17
owner: AI Bootstrap Maintainers
source: User-requested split-state handoff plan; recurring bootstrap-governance exception in PR_MERGE_POLICY.md; maintainer approval in PR #21 comment 4472356122
linked_specs: []
linked_tickets: [BOOT-STATE-001]
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# BOOT-STATE-001: Split-State Handoff Boundary

## Purpose

Prevent branch/session-specific AI handoff data from being committed as durable
project truth while keeping development fast and multi-agent-friendly.

## User Or System Value

This reduces recurring post-merge cleanup and avoids stale branch names in
committed state files without adding a larger spec process for targeted
bootstrap-governance improvements.

## Scope

In scope:

- add the bounded recurring bootstrap-governance exception to
  `PR_MERGE_POLICY.md`
- split canonical, PR, and local session state responsibilities
- add `.ai/SESSION.md` as a gitignored local resume and hook-hint surface
- update agent instructions, role files, branch/worktree guidance, operation
  routing, review templates, validators, hooks, red checks, and current state
  artifacts as described in the approved plan

Out of scope:

- product implementation
- runtime code
- schemas, APIs, migrations, dependencies, and deployment changes
- security-sensitive runtime behavior
- architecture-sensitive product decisions
- database or YAML state-system migration

## Links

- Linked spec: none; this item uses the recurring bootstrap-governance
  exception in `PR_MERGE_POLICY.md`
- Linked acceptance criteria:
  `docs/superpowers/plans/2026-05-17-split-state-handoff.md`
- Linked requirements:
  `TRACEABILITY_MATRIX.md` row `TRACE-SPLIT-STATE-HANDOFF-PLAN-001`
- Source IDs:
  `REVIEWS/REVIEW-2026-05-17-split-state-handoff-plan.md`
- Approved assumptions:
  none
- Maintainer exception approval:
  PR #21 comment 4472356122 approves using the Recurring Bootstrap Governance
  Exception for this PR.
- Open questions:
  none for Task 0; implementation findings may create open questions later
- Related ADR:
  none
- Related external ticket:
  none

## Dependencies

- Task 0 must establish implementation authority before Task 1 starts.
- `PR_MERGE_POLICY.md` must contain the bounded recurring
  bootstrap-governance exception before this item can rely on Path B.
- Path B merge authority requires explicit maintainer approval evidence for this
  PR; evidence is recorded in PR #21 comment 4472356122.

## Risks

- Over-expanding the exception could weaken product governance; mitigated by
  excluding product implementation, runtime code, schemas, APIs, migrations,
  dependencies, deployment changes, security-sensitive runtime behavior, and
  architecture-sensitive product decisions.
- Moving volatile state out of committed files could hide branch status from
  other agents; mitigated by requiring shared branch state in PR/review
  evidence.

## Suggested Owner Role

Implementation Agent

## Estimated Complexity

high

## Implementation Phase

Task 0 of `docs/superpowers/plans/2026-05-17-split-state-handoff.md`
establishes authority. Tasks 1 and later implement the split-state mechanics.

## Related Files Or Modules

- `PR_MERGE_POLICY.md`
- `BACKLOG.md`
- `BACKLOG/BACKLOG_INDEX.md`
- `TRACEABILITY_MATRIX.md`
- `ARTIFACT_REGISTRY.md`
- `docs/superpowers/plans/2026-05-17-split-state-handoff.md`
- `AGENTS.md`
- `CLAUDE.md`
- `memory/ai/`
- `SCRIPTS/`
- `.githooks/`
- `REVIEWS/templates/`

## Linear Ticket

- Should become external ticket: no
- Tracker: none
- Ticket status: not-created
- Ticket ID or URL:
- Confirmation evidence:

## Priority

P1

## Readiness Status

in-review

## Readiness Evidence

- Source evidence:
  `REVIEWS/REVIEW-2026-05-17-split-state-handoff-plan.md`
- Spec status:
  not applicable; Path B maintainer approval is recorded in PR #21 comment
  4472356122
- Acceptance criteria:
  listed in `docs/superpowers/plans/2026-05-17-split-state-handoff.md`
- Dependencies:
  Task 0 authority before Task 1
- Architecture impact:
  bootstrap operating-model mechanics only; no product architecture impact
- Test expectations:
  bootstrap validation, red checks when validator/hook behavior changes, shell
  syntax checks for edited scripts/hooks, `git diff --check`, CI, and fresh
  adversarial review before merge
- Branch/worktree plan:
  branch `codex/split-state-plan`, repository root worktree
- Required reviewers:
  fresh-context adversarial reviewer; focused reviewers if implementation
  expands into security, release, architecture, or QA-sensitive behavior
- Blocked until:
  GitHub review and branch-protection gates allow merge

## Test Expectations

- `bash SCRIPTS/validate-bootstrap.sh`
- `git diff --check`
- relevant red checks when validator or hook behavior changes
- shell syntax checks when scripts or hooks change
- CI before merge

## Definition Of Done

- [x] Merge authority satisfied by explicit Path B maintainer approval or Path A
  approved/active spec.
- [x] Acceptance criteria satisfied locally.
- [x] Tests added or updated, or justified.
- [x] Traceability updated.
- [x] Artifact registry updated.
- [x] Handoff updated.
- [x] Review complete or pending review recorded.

## Parallelization

- Status: not-allowed
- File ownership boundaries:
  this PR touches shared governance, role, validator, hook, and state files
- Shared files requiring coordination:
  `PR_MERGE_POLICY.md`, `OPERATION_ROUTING.md`, `SCRIPTS/`,
  `.githooks/`, `memory/ai/`, `AI_HANDOFF.md`, and `CURRENT_STATE.md`
- Stop conditions:
  unresolved P0/P1 review finding, failed required validation without accepted
  rationale, or scope expansion beyond bootstrap governance
