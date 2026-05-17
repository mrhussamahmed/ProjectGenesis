artifact_id: ART-PR-REVIEW-PACKAGE-SPLIT-STATE-HANDOFF-001
title: Split-State Handoff Boundary PR Review Package
type: pr-review-package
status: draft
version: v1.0
created: 2026-05-17
updated: 2026-05-17
owner: AI Bootstrap Maintainers
source: BOOT-STATE-001 implementation package
linked_specs: []
linked_tickets: [BOOT-STATE-001]
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# PR Review Package: Split-State Handoff Boundary

## PR Title

BOOT-STATE-001 split canonical, PR, and local AI handoff state

## PR Purpose

Problem: PR #20 showed that committed `AI_HANDOFF.md` can contain feature
branch reality that becomes false on `main`, causing post-merge CI failure.
The fix must prevent recurrence without making normal development
process-heavy.

## Anti-Goals

- no database
- no full YAML state migration
- no per-PR committed diary
- no mandatory post-merge cleanup
- no heavy checklist replacing the current problem

## Linked Specs

- none; this PR intends to use the recurring bootstrap-governance exception in
  `PR_MERGE_POLICY.md`, but merge authority remains blocked until explicit
  maintainer approval evidence is recorded or Path A is used

## Linked Backlog Items Or Tickets

- `BACKLOG/BOOT-STATE-001-split-state-handoff.md`

## Operation Routing

- Routing authority: `OPERATION_ROUTING.md`
- Operation profile: `strict-protected`
- Validation mode: strict
- Pre-change classification location: this PR review package and
  `BACKLOG/BOOT-STATE-001-split-state-handoff.md`
- Final evidence envelope location: this PR review package,
  `TEST_RESULTS.md`, and the committed implementation review record
- Impact map summary: governance, merge/review policy, role files, hooks,
  validators, red checks, templates, state, registry, traceability, and
  worklog are impacted
- Skipped reads or validations: CI not run locally; must run after PR push

## Branch-Specific State

- Branch: `codex/split-state-plan`
- Worktree: repository root
- Owner agent: Codex
- Current branch status: request-changes finding acknowledged; Path B
  maintainer approval evidence is not recorded, so merge authority remains
  blocked pending maintainer approval or Path A
- Next branch action: request fresh adversarial review
- Shared/protected files touched: governance, policy, role, hook, validator,
  template, state, registry, traceability, test-result, and worklog files
- Coordination notes for parallel agents: do not overlap on the same
  governance/validator files until this branch is reviewed

## Linked ADRs

- none

## Changed Files

- `.gitignore`
- `.githooks/pre-commit`
- `.githooks/pre-push`
- `AGENTS.md`
- `CLAUDE.md`
- `BRANCH_AND_WORKTREE_GUIDE.md`
- `GOVERNANCE.md`
- `OPERATION_ROUTING.md`
- `PR_REVIEW_POLICY.md`
- `PR_MERGE_POLICY.md`
- `memory/ai/SHARED_AGENT_RULES.md`
- `memory/ai/ROLE_*.md`
- `SCRIPTS/operation-profile.sh`
- `SCRIPTS/validate-bootstrap.sh`
- `SCRIPTS/validate-bootstrap-red-checks.sh`
- `REVIEWS/templates/PR_REVIEW_PACKAGE_TEMPLATE.md`
- `REVIEWS/templates/ADVERSARIAL_PR_REVIEW_TEMPLATE.md`
- `BACKLOG.md`
- `BACKLOG/BACKLOG_INDEX.md`
- `BACKLOG/BOOT-STATE-001-split-state-handoff.md`
- `docs/superpowers/plans/2026-05-17-split-state-handoff.md`
- `AI_HANDOFF.md`
- `CURRENT_STATE.md`
- `ARTIFACT_REGISTRY.md`
- `TRACEABILITY_MATRIX.md`
- `TEST_RESULTS.md`
- `WORKLOG/WORKLOG_INDEX.md`
- `REVIEWS/REVIEW_INDEX.md`
- `REVIEWS/REVIEW-2026-05-17-split-state-handoff-plan.md`
- `REVIEWS/REVIEW-2026-05-17-split-state-handoff-implementation.md`

## Summary Of Changes

- Added a bounded recurring bootstrap-governance exception to
  `PR_MERGE_POLICY.md`.
- Added `BOOT-STATE-001` as the backlog authority for this governance work.
- Added `.ai/` as gitignored local session storage.
- Updated agent entrypoints and role files to separate local resume state, PR
  branch state, and canonical committed state.
- Moved local hook profile lookup to `.ai/SESSION.md` with branch and freshness
  checks, strict fallback, and legacy handoff fallback.
- Removed canonical branch-equality validation and replaced it with a narrow
  active-section volatile-state guard.
- Added red checks for local session behavior, strict fallback, stale/mismatched
  local sessions, role-rule contradictions, and compact canonical handoff.
- Trimmed `AI_HANDOFF.md` and `CURRENT_STATE.md` to merge-safe baseline
  snapshots.
- Addressed implementation review request-changes findings by making
  committed state updates conditional in PR policy and moving operation
  evidence pointers out of trimmed `AI_HANDOFF.md`.
- Corrected the Path B authority record so adversarial review is not treated as
  maintainer approval; explicit maintainer approval remains pending.

## Acceptance Criteria

- Canonical state files remain true on `main` after merge.
- Branch/worktree/session details can live in gitignored `.ai/SESSION.md`.
- Shared branch status has a clear PR/review-package home.
- Hook fast path reads valid local session profile hints and defaults strict.
- Validator rejects active volatile session facts in canonical state.
- Red checks cover split-state behavior.
- High-risk review evidence is durable.
- Path B merge authority has explicit maintainer approval evidence, or the PR
  uses Path A with an approved/active spec.

## Tests Added Or Changed

- Added red-check fixtures for `.ai/SESSION.md` pruning, local operation-profile
  extraction, strict fallback, stale local sessions, branch-mismatched local
  sessions, canonical allowed wording, handoff without classification, active
  volatile-state rejection, role contradiction rejection, and PR policy
  contradiction rejection.
- Tightened red-check fixture copying to exclude local-only `.claude/`,
  `.ai/`, and `research/` directories.

## Test Results

- `git check-ignore .ai/SESSION.md`: passed
- `for f in SCRIPTS/operation-profile.sh .githooks/pre-commit .githooks/pre-push SCRIPTS/validate-bootstrap.sh SCRIPTS/validate-bootstrap-red-checks.sh; do bash -n "$f"; done`: passed
- `bash SCRIPTS/validate-bootstrap.sh`: passed after request-changes fixes
- `bash SCRIPTS/validate-bootstrap-red-checks.sh`: passed after adding the PR
  policy contradiction fixture and maintainer authority-boundary fixture
- `git diff --check`: passed after maintainer-approval boundary fixes
- CI: pending PR push

## Known Risks

- The change touches governance, role, validator, hook, and review-policy
  mechanics, so fresh adversarial review is mandatory.
- Local session state is intentionally invisible to other agents; shared branch
  status must be kept in PR evidence.

## Known Limitations

- This does not introduce a database or structured YAML state system.
- GitHub review evidence still depends on either a GitHub review object or a
  committed review record from the reviewer.

## Maintainer Exception Approval

- Status: pending.
- Current evidence: none. `REVIEWS/REVIEW-2026-05-17-split-state-handoff-plan.md`
  is an adversarial review record and must not be treated as maintainer
  approval.
- Required before merge under Path B: explicit maintainer approval using the
  recurring bootstrap-governance exception for this PR, recorded in a GitHub PR
  review/comment by a maintainer or in a committed maintainer approval artifact.
- Fallback if approval is not provided: use Path A with an approved/active spec
  and keep `BOOT-STATE-001` as the linked backlog item.

## Assumptions

- none

## Unresolved Questions

- none

## Rollout Considerations

- Merge only after CI and fresh adversarial review pass.
- After merge, canonical state should still name `main`.

## Rollback Considerations

- Revert the PR if local-session routing or validator behavior blocks normal
  development unexpectedly.
- The strict fallback means deleting `.ai/SESSION.md` restores conservative
  behavior.

## Security And Privacy Considerations

- `.ai/SESSION.md` is gitignored and must not contain secrets.
- Hooks still run strict validation for protected paths.

## Observability Considerations

- CI remains the durable validation signal after PR push.

## Traceability Links

- `TRACEABILITY_MATRIX.md` row `TRACE-SPLIT-STATE-HANDOFF-PLAN-001`

## Artifact Updates

- `ARTIFACT_REGISTRY.md` registers `BOOT-STATE-001`, the plan, review package,
  and updated policy/validator artifacts.

## Worktree And Branch Status

- Branch: `codex/split-state-plan`
- Worktree: repository root
- Dirty status: implementation diff present
- Untracked files: existing local `.claude/` and `research/` scratch paths are
  not part of this PR; tracked additions include the backlog item, plan, review
  record, and this package

## Adversarial Review Questions

1. Does the implementation actually reduce per-PR process compared with the
   previous state?
2. Does `.ai/SESSION.md` create unacceptable hidden-state risk for multiple
   agents?
3. Does moving operation profile out of committed handoff preserve fast-path
   validation safely?
4. Are canonical state files still useful after branch/session data moves out?
5. Are the validator guards narrow enough to avoid false positives?
6. Is the review evidence policy clear enough to avoid another chat-only
   review gap?
7. Does the implementation avoid repo-history bloat?
8. Are there contradictions with existing governance, role files, or hook
   behavior?

## Required Review Evidence

Because this implementation touches governance, validators, hooks, role files,
and review policy, PR-body-only evidence is not enough. The implementation PR
must have one of:

- a GitHub PR review object from the adversarial reviewer; or
- a committed review record under `REVIEWS/` registered in
  `REVIEWS/REVIEW_INDEX.md`.
