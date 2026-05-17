artifact_id: ART-REVIEW-SPLIT-STATE-HANDOFF-IMPL-001
title: Split-State Handoff Boundary Implementation Review
type: pr-review
status: active
version: v1.2
created: 2026-05-17
updated: 2026-05-17
owner: AI Bootstrap Maintainers
source: Fresh-context Codex adversarial implementation review of local diff on codex/split-state-plan
linked_specs: []
linked_tickets: [BOOT-STATE-001]
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Split-State Handoff Boundary Implementation Review

## Review Decision

request changes

## Risk Level

high

## Model Or Effort Level Used Or Recommended

adversarial deep

## Reviewer

- Agent: Codex
- Role: Adversarial PR Reviewer
- Date: 2026-05-17

## Inputs Reviewed

- Review package: `REVIEWS/PR_REVIEW_PACKAGE-split-state-handoff.md`
- PR diff or local diff: `git status --short --branch`, `git diff --name-only`
- Operation classification: `OPERATION_ROUTING.md`; `SCRIPTS/operation-profile.sh --validator-level`
- Final evidence envelope: `REVIEWS/PR_REVIEW_PACKAGE-split-state-handoff.md`; `TEST_RESULTS.md`
- Specs: none; reviewed recurring bootstrap-governance exception path in `PR_MERGE_POLICY.md`
- Backlog items or tickets: `BACKLOG/BOOT-STATE-001-split-state-handoff.md`
- ADRs: none
- Tests: `git check-ignore .ai/SESSION.md`; shell syntax loop; `bash SCRIPTS/validate-bootstrap.sh`; `bash SCRIPTS/validate-bootstrap-red-checks.sh`; `git diff --check`
- Traceability: `TRACEABILITY_MATRIX.md`
- Artifact registry: `ARTIFACT_REGISTRY.md`
- Current state and handoff: `CURRENT_STATE.md`; `AI_HANDOFF.md`

## Findings

| Severity | File | Evidence | Finding | Required Change |
|----------|------|----------|---------|-----------------|
| P1 | `PR_MERGE_POLICY.md`; `PR_REVIEW_POLICY.md` | `PR_MERGE_POLICY.md` lines 30-31 still require `AI_HANDOFF.md` and `CURRENT_STATE.md` to be updated for every PR unless an exception applies. `PR_REVIEW_POLICY.md` line 103 still lists "missing AI handoff after significant work" as a blocking issue. The approved plan's acceptance criteria say canonical state files must not require updates for every feature branch. | The implementation leaves authoritative merge/review policy with the old unconditional handoff/state requirement. That contradicts the split-state model and can recreate the exact process pressure that caused branch/session facts to be committed. | Rewrite the default merge and review checks to require evidence in the correct split-state location. Canonical `AI_HANDOFF.md` and `CURRENT_STATE.md` should be required only when durable project truth changed and the update remains true on `main`; branch-specific status should be satisfied by PR/review evidence. Add a red check or validator assertion so these policies cannot regress to unconditional committed-state language. |
| P1 | `PR_MERGE_POLICY.md`; `REVIEWS/PR_REVIEW_PACKAGE-split-state-handoff.md`; `BACKLOG/BOOT-STATE-001-split-state-handoff.md` | `PR_MERGE_POLICY.md` line 63 requires a maintainer to explicitly approve using the recurring bootstrap-governance exception for the PR. The PR review package lines 166-169 records this as an assumption, and the backlog item lines 61-63 also infers approval from plan review approval. | Path B is not yet evidenced as an explicit maintainer approval in the branch artifacts. Treating it as an assumption is weaker than the merge-policy requirement and leaves the no-spec exception unproven for merge. | Replace the assumption with explicit maintainer approval evidence in the PR body, PR comment, or review package, and cite that evidence from the backlog item. If that approval is not available, use Path A before merge. |
| P2 | `REVIEWS/PR_REVIEW_PACKAGE-split-state-handoff.md`; `AI_HANDOFF.md` | Review package lines 52-55 say pre-change classification and final evidence live in `AI_HANDOFF.md`, but the trimmed `AI_HANDOFF.md` no longer contains a Task 0 classification or branch-specific final evidence. | The review package points reviewers back to canonical handoff for branch operation evidence, which is stale under the new split-state model. The package itself has the right durable surface; its location fields just contradict that. | Update the operation-routing fields to name the review package, committed implementation review record, and `TEST_RESULTS.md` as durable evidence. Do not point to canonical `AI_HANDOFF.md` for branch-specific classification/final evidence unless it actually contains durable main-safe truth. |

## Operation Routing Review

- Profile correctness: `strict-protected` is appropriate because the branch touches governance, merge/review policy, role files, hooks, validators, templates, registry, traceability, and state files.
- Escalation precedence: The recurring bootstrap-governance exception is the right no-spec path only after explicit maintainer approval is durably evidenced.
- Protected artifacts: The changed file set is broad but matches BOOT-STATE-001 scope.
- Skipped validation rationale: CI is not available before push and remains pending.
- Handoff and evidence durability: Branch status is in the PR review package, but policy and package wording still contain legacy handoff assumptions that must be corrected.

## Split-State Review

- Canonical state remains merge-safe: `AI_HANDOFF.md` and `CURRENT_STATE.md` are compact main snapshots and passed validator guards.
- Branch-specific status is in PR evidence: Mostly yes, via `REVIEWS/PR_REVIEW_PACKAGE-split-state-handoff.md`.
- Local session facts are not committed: `.ai/` is ignored and validator/red checks cover local-session behavior.
- Review evidence durability is appropriate for risk: This committed review record provides durable evidence; re-review is required after P1 fixes.

## Required Changes

- Resolve both P1 findings before merge or approval.
- Resolve the P2 review-package evidence-location contradiction before merge.
- Re-run bootstrap validation, red checks, shell syntax checks, and `git diff --check` after fixes.
- Re-request adversarial review after the P1 findings are addressed.

## Optional Improvements

- Correct the stale comment in `SCRIPTS/operation-profile.sh` that says it scans the legacy handoff from the end; the current awk implementation effectively keeps the last matching profile while scanning forward.
- Consider rejecting future-dated `.ai/SESSION.md` timestamps so clock mistakes cannot make a stale local session appear fresh indefinitely.

## Validation Evidence

- `git check-ignore .ai/SESSION.md`: passed.
- Shell syntax loop for `SCRIPTS/operation-profile.sh`, `.githooks/pre-commit`, `.githooks/pre-push`, `SCRIPTS/validate-bootstrap.sh`, and `SCRIPTS/validate-bootstrap-red-checks.sh`: passed.
- `bash SCRIPTS/operation-profile.sh --validator-level`: returned `strict`.
- `git diff --check`: passed.
- `bash SCRIPTS/validate-bootstrap.sh`: passed.
- `bash SCRIPTS/validate-bootstrap-red-checks.sh`: passed.

## Final Recommendation

Request changes. The implementation is technically close and the local validation suite passes, but merge cannot proceed while authoritative merge/review policy still carries unconditional handoff/state requirements and the no-spec exception approval is recorded as an assumption rather than explicit maintainer evidence.

## Re-Review Conditions

- Re-review after the policy wording, Path B approval evidence, and review-package evidence locations are corrected.

## Re-Review 2026-05-17

### Review Decision

request changes

### Inputs Reviewed

- `PR_MERGE_POLICY.md`
- `PR_REVIEW_POLICY.md`
- `REVIEWS/PR_REVIEW_PACKAGE-split-state-handoff.md`
- `BACKLOG/BOOT-STATE-001-split-state-handoff.md`
- `REVIEWS/REVIEW-2026-05-17-split-state-handoff-plan.md`
- `SCRIPTS/validate-bootstrap.sh`
- `SCRIPTS/validate-bootstrap-red-checks.sh`
- `TEST_RESULTS.md`

### Prior Finding Resolution

| Prior Severity | Status | Evidence |
|----------------|--------|----------|
| P1 unconditional committed handoff/state requirements in policy | resolved | `PR_MERGE_POLICY.md` now makes canonical state updates conditional on durable project truth that remains true on `main`; `PR_REVIEW_POLICY.md` now requires PR evidence or durable handoff/state updates in the correct split-state location. The validator and red-check harness now reject the old unconditional policy language. |
| P1 Path B approval evidence recorded only as an assumption | not resolved | The PR package now labels the plan review as "explicit approval evidence", but that artifact is a Codex adversarial review record, not maintainer approval. The plan review's own minor comments say Path B is unavailable before maintainer approval. |
| P2 operation evidence points to trimmed handoff | resolved | `REVIEWS/PR_REVIEW_PACKAGE-split-state-handoff.md` now points pre-change classification and final evidence to the PR review package, backlog item, `TEST_RESULTS.md`, and committed review record instead of canonical `AI_HANDOFF.md`. |

### Findings

| Severity | File | Evidence | Finding | Required Change |
|----------|------|----------|---------|-----------------|
| P1 | `PR_MERGE_POLICY.md`; `REVIEWS/PR_REVIEW_PACKAGE-split-state-handoff.md`; `BACKLOG/BOOT-STATE-001-split-state-handoff.md`; `REVIEWS/REVIEW-2026-05-17-split-state-handoff-plan.md` | `PR_MERGE_POLICY.md` requires "a maintainer explicitly approves using this exception for the PR." The PR package cites `REVIEWS/REVIEW-2026-05-17-split-state-handoff-plan.md` as explicit approval evidence, but that record identifies the reviewer as Codex and is an adversarial plan review. Its minor comments say Path B is unavailable until maintainers approve the recurring exception. | The no-spec Path B authority is still not durably evidenced. A Codex review approving a plan is not the same artifact as maintainer approval to use the exception for this PR, and the current citation overstates what the plan review proves. | Add explicit maintainer approval evidence for using the recurring bootstrap-governance exception for this PR, such as a PR comment/body line or committed approval note that names the maintainer approval and date, then cite that evidence from the PR package and backlog item. If no maintainer approval exists, use Path A before merge. |

### Validation Evidence

- `bash SCRIPTS/validate-bootstrap.sh`: passed.
- Shell syntax loop for operation profile, hooks, validator, and red checks: passed.
- `git diff --check`: passed.
- `git check-ignore .ai/SESSION.md && bash SCRIPTS/operation-profile.sh --validator-level`: returned `.ai/SESSION.md` and `strict`.
- `bash SCRIPTS/validate-bootstrap-red-checks.sh`: passed.

### Final Recommendation

Request changes. The technical fixes are green and the policy/evidence-location blockers are resolved, but merge remains blocked until Path B has explicit maintainer approval evidence rather than a citation to the Codex plan review.

## Second Re-Review 2026-05-17

### Review Decision

approve with minor comments

### Inputs Reviewed

- `PR_MERGE_POLICY.md`
- `REVIEWS/PR_REVIEW_PACKAGE-split-state-handoff.md`
- `BACKLOG/BOOT-STATE-001-split-state-handoff.md`
- `SCRIPTS/validate-bootstrap.sh`
- `SCRIPTS/validate-bootstrap-red-checks.sh`
- `TEST_RESULTS.md`

### Prior Finding Resolution

| Prior Severity | Status | Evidence |
|----------------|--------|----------|
| P1 Path B approval evidence overstated | resolved | `REVIEWS/PR_REVIEW_PACKAGE-split-state-handoff.md` now marks maintainer exception approval as pending and explicitly says the Codex plan review is not maintainer approval. `BACKLOG/BOOT-STATE-001-split-state-handoff.md` leaves merge authority unchecked until explicit Path B approval exists or Path A is used. `PR_MERGE_POLICY.md` now says adversarial review approval is not maintainer approval unless the reviewer is explicitly acting as maintainer for this exception. |

### Findings

No unresolved P0, P1, or blocking P2 findings.

### Merge Gate Status

This review approves the implementation changes, but the PR is not merge-ready
yet. Merge still requires:

- explicit maintainer approval to use the recurring bootstrap-governance
  exception for this PR, or Path A with an approved/active spec;
- PR CI after push.

### Validation Evidence

- `bash SCRIPTS/validate-bootstrap.sh`: passed.
- Shell syntax loop for operation profile, hooks, validator, and red checks: passed.
- `git diff --check`: passed.
- `git check-ignore .ai/SESSION.md && bash SCRIPTS/operation-profile.sh --validator-level`: returned `.ai/SESSION.md` and `strict`.
- `bash SCRIPTS/validate-bootstrap-red-checks.sh`: passed.

### Final Recommendation

Approve with minor comments. The implementation now honestly separates review
approval from maintainer exception approval and has no unresolved review
findings. Do not merge until the explicit merge-authority gate and CI gate are
satisfied.
