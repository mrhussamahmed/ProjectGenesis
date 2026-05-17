artifact_id: ART-REVIEW-SPLIT-STATE-HANDOFF-PLAN-001
title: Split-State Handoff Boundary Plan Adversarial Review
type: pr-review
status: active
version: v1.2
created: 2026-05-17
updated: 2026-05-17
owner: AI Bootstrap Maintainers
source: Fresh-context Codex adversarial review of docs/superpowers/plans/2026-05-17-split-state-handoff.md
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Split-State Handoff Boundary Plan Adversarial Review

## Review Decision

approve with minor comments

## Risk Level

high

## Model Or Effort Level Used Or Recommended

adversarial deep

## Reviewer

- Agent: Codex
- Role: Adversarial PR Reviewer
- Date: 2026-05-17

## Inputs Reviewed

- Review target: `docs/superpowers/plans/2026-05-17-split-state-handoff.md`
- Local diff/status: `git status --short --branch`, `git diff --name-status`, `git ls-files --others --exclude-standard`
- Operation classification authority: `OPERATION_ROUTING.md`
- Review and merge policy: `PR_REVIEW_POLICY.md`, `PR_MERGE_POLICY.md`
- Risk model: `RISK_MODEL.md`
- Current state and handoff: `CURRENT_STATE.md`, `AI_HANDOFF.md`
- Registry and traceability: `ARTIFACT_REGISTRY.md`, `TRACEABILITY_MATRIX.md`
- Spec index: `SPECS/SPEC_INDEX.md`
- Validator and hook scripts: `SCRIPTS/validate-bootstrap.sh`, `SCRIPTS/operation-profile.sh`, `SCRIPTS/validate-bootstrap-red-checks.sh`, `.githooks/pre-commit`, `.githooks/pre-push`
- Role files sampled for contradiction evidence: `memory/ai/ROLE_PRODUCT_ANALYST.md`, `memory/ai/ROLE_SPEC_AUTHOR.md`, `memory/ai/ROLE_ARCHITECT.md`, `memory/ai/ROLE_QA_REVIEWER.md`, `memory/ai/ROLE_SECURITY_REVIEWER.md`, `memory/ai/ROLE_DEVOPS_RELEASE_REVIEWER.md`, `memory/ai/ROLE_DIAGRAM_ARCHITECT.md`

## Findings

| Severity | File | Evidence | Finding | Required Change |
|----------|------|----------|---------|-----------------|
| P1 | `docs/superpowers/plans/2026-05-17-split-state-handoff.md` | Plan metadata has `linked_specs: []` at line 10. The implementation tasks change governance, validators, hooks, role files, review policy, registry, and traceability at lines 97-115. `SPECS/SPEC_INDEX.md` line 34 says implementation requires an approved or active spec; `PR_MERGE_POLICY.md` lines 19-23 require an approved or active spec and a backlog item or ticket. | The plan is implementation-ready in tone but has no approved or active spec, backlog item, ticket, or explicit governance exception. Implementing it as written would violate Definition of Ready and merge policy before code review starts. | Add an approved or active spec and backlog item/ticket for this split-state change, or record an explicit bootstrap-governance exception accepted by maintainers. Link them in the plan metadata, review package, traceability row, and PR body before implementation. |
| P1 | `docs/superpowers/plans/2026-05-17-split-state-handoff.md`; `SCRIPTS/validate-bootstrap.sh`; `OPERATION_ROUTING.md` | The plan moves operation classification to `.ai/SESSION.md` at lines 258-293 and 556-558, and trims committed handoff history at lines 316-353. The current validator still requires `Pre-Change Classification` and `Operation profile:` in `AI_HANDOFF.md` at `SCRIPTS/validate-bootstrap.sh` lines 754-755, then inspects those sections for protected-file profile correctness at lines 759-814. `OPERATION_ROUTING.md` lines 70-78 requires classification before edits and durable evidence. | The plan removes the old handoff source for operation evidence but does not update the validator checks or the durable-evidence rule that still depend on `AI_HANDOFF.md`. This leaves the implementation in a contradictory state: either validation fails after trimming handoff, or agents must keep stale classification blocks in canonical handoff, preserving the bug the plan is meant to remove. | Add explicit implementation steps and red checks to relocate validator classification checks from `AI_HANDOFF.md` to PR evidence or a committed review/package artifact for shared work, with `.ai/SESSION.md` used only as a local hook hint. Update `OPERATION_ROUTING.md` to define which evidence is durable enough for adaptive routing. |
| P1 | `docs/superpowers/plans/2026-05-17-split-state-handoff.md` | Task 3 syntax validation uses `bash -n SCRIPTS/operation-profile.sh .githooks/pre-commit .githooks/pre-push` at lines 299-305; final validation repeats the same multi-file pattern at lines 587-589. | `bash -n` only syntax-checks the first script argument; the hook paths become positional parameters to the first script. Syntax errors in `.githooks/pre-commit`, `.githooks/pre-push`, `SCRIPTS/validate-bootstrap.sh`, or `SCRIPTS/validate-bootstrap-red-checks.sh` could pass the planned check. | Replace the command with separate checks, for example `for f in SCRIPTS/operation-profile.sh .githooks/pre-commit .githooks/pre-push SCRIPTS/validate-bootstrap.sh SCRIPTS/validate-bootstrap-red-checks.sh; do bash -n "$f"; done`, and add this exact form to the implementation validation plan. |
| P1 | `docs/superpowers/plans/2026-05-17-split-state-handoff.md`; `memory/ai/ROLE_*.md` | The plan updates only four role files at lines 184-191. Other active role files still require `CURRENT_STATE.md` and `AI_HANDOFF.md` before stopping: product analyst lines 76-84, spec author lines 69-78, architect lines 71-80, QA reviewer lines 66-73, security reviewer lines 69-77, DevOps release reviewer lines 66-74, and diagram architect lines 76-84. | The old behavior will remain authoritative for several roles. A product, spec, architecture, QA, security, DevOps, or diagram session can still follow its role file and commit branch/session facts to canonical state, recreating PR #20-style drift. | Update every `memory/ai/ROLE_*.md` file that has required state/handoff updates, or add a shared override and remove or rewrite contradictory role-specific bullets in the same PR. Add a validator/red-check grep that fails if role files retain unconditional committed-state stopping rules. |
| P2 | `docs/superpowers/plans/2026-05-17-split-state-handoff.md` | The proposed canonical `Current In-Progress Task` text includes `.ai/SESSION.md` inside an active section at lines 320-328. The proposed volatile-state guard rejects `.ai/SESSION.md` inside active canonical sections at lines 430-449. | The guard can fail on the plan's own recommended canonical text unless the implementation uses a nuanced parser. This is exactly the kind of false positive the plan says it wants to avoid. | Move `.ai/SESSION.md` explanation outside scanned active sections, or specify the exact allowed and disallowed patterns so the guard rejects only claims that `.ai/SESSION.md` is canonical source of truth, not explanatory routing text. Add a red-check fixture for the allowed canonical wording. |
| P2 | `docs/superpowers/plans/2026-05-17-split-state-handoff.md` | The plan says high-risk governance, validator, hook, CI, role, or source-of-truth changes need a GitHub review object or committed `REVIEWS/` record at lines 377-386, but Task 10 allows using only a PR body as the durable review surface at lines 597-601. | The plan is ambiguous for this exact implementation PR, which is high-risk governance and validator work. A PR body can document review context, but it is not itself an adversarial review object. | Make Task 10 explicit: this implementation requires a GitHub review object or committed review record, plus a PR review package or PR body for context. Do not allow PR body-only review evidence for this change class. |
| P2 | `docs/superpowers/plans/2026-05-17-split-state-handoff.md` | The local parser accepts only `operation_profile` from `.ai/SESSION.md` at lines 268-288. The stale-session mitigation only says to include branch and timestamp and verify `git status` at lines 89 and 169-176; the parser does not enforce either. | A stale local `.ai/SESSION.md` can keep returning `docs-trivial` or `process-light-exception` for a later unrelated operation, causing hooks to select `shape-only` when the current work was never classified that way. Strict gates protect protected paths, but they do not prove docs-public-claim or state-sync work is correctly classified. | Require `.ai/SESSION.md` to carry branch and timestamp fields, and make `SCRIPTS/operation-profile.sh --validator-level` fall back to `strict` when the branch does not match `git branch --show-current`, the profile is unrecognized, or the session is stale. Add red checks for stale and branch-mismatched session files. |

## Operation Routing Review

- Profile correctness: The review itself is high-risk planning/governance review because it creates a durable review record and updates registry, traceability, state, handoff, test results, and worklog.
- Escalation precedence: Target implementation plan touches governance, validators, hooks, roles, and review policy, so implementation should route as `strict-protected`.
- Protected artifacts: The plan correctly identifies many protected artifacts, but misses validator checks tied to `AI_HANDOFF.md` operation evidence and misses several role files.
- Skipped validation rationale: Full implementation validation is not applicable to a plan-only review. I did run `git diff --check` and a pre-edit `bash SCRIPTS/validate-bootstrap.sh`.
- Handoff and evidence durability: Review findings are recorded in this committed review record; state and indexes are updated in this same review branch.

## Required Changes

- Resolve all P1 findings before implementation starts.
- Resolve or explicitly accept P2 findings before implementation PR review.
- Re-run plan review after the updated plan names its spec/backlog authority, validator classification migration, complete role-file coverage, corrected shell syntax checks, and high-risk review-evidence path.

## Optional Improvements

- Split the eventual implementation into two PRs only if the team wants lower review risk: first policy and role boundary, then validator/hook behavior. If kept as one PR, keep the review package strict and compact.
- Add a small `SCRIPTS/validate-shell-syntax.sh` helper if multi-file `bash -n` checks keep being repeated incorrectly.

## Validation Evidence

- `git diff --check`: passed before review-record edits.
- `bash SCRIPTS/validate-bootstrap.sh`: failed before review-record edits only with `AI_HANDOFF.md branch does not match git branch: main != codex/split-state-plan`.
- Final `bash SCRIPTS/validate-bootstrap.sh`: passed after durable review record and state/index updates.
- Final `git diff --check`: passed after durable review record and state/index updates.

## Final Recommendation

Request changes. The plan is directionally sound and targets the right incident class, but it is not ready to implement until the durable operation-evidence path, role-file coverage, readiness authority, and shell validation commands are corrected.

## Re-Review 2026-05-17

### Review Decision

request changes

### Re-Review Inputs

- Revised plan: `docs/superpowers/plans/2026-05-17-split-state-handoff.md`
- Review target lines checked with `nl -ba`
- Policies checked: `PR_MERGE_POLICY.md`, `memory/ai/SHARED_AGENT_RULES.md`, `AI_PROJECT_BOOTSTRAP.md`, `OPERATION_ROUTING.md`
- State and evidence checked: `CURRENT_STATE.md`, `AI_HANDOFF.md`, `TRACEABILITY_MATRIX.md`, `ARTIFACT_REGISTRY.md`, `TEST_RESULTS.md`

### Prior Finding Resolution

| Prior Severity | Status | Evidence |
|----------------|--------|----------|
| P1 missing readiness authority | partially resolved | The revised plan adds a readiness gate at lines 68-87 and Task 0 at lines 145-182. Remaining issue recorded below because the recommended exception path conflicts with current merge policy unless the plan wires the exception into that policy or requires an approved/active spec path. |
| P1 operation evidence still tied to canonical handoff | resolved for plan approval | Task 6 now removes canonical `AI_HANDOFF.md` operation-evidence requirements and replaces them with durable PR/review evidence checks at lines 528-549. Task 8 adds durable evidence location language at lines 732-741. |
| P1 incorrect multi-file `bash -n` | resolved | Task 3 now checks hook files in a loop at lines 395-405, and final validation checks all script/hook files in a loop at lines 851-863. |
| P1 incomplete role-file coverage | resolved | Task 2 now targets every `memory/ai/ROLE_*.md` file at lines 251-255 and adds a contradiction check at lines 317-321. |
| P2 active-section `.ai/SESSION.md` false positive | resolved | The canonical wording no longer names `.ai/SESSION.md` in the active section at lines 418-426, and the guard now rejects only canonical/durable/shared-evidence claims at lines 561-573. |
| P2 PR-body-only high-risk review evidence ambiguity | resolved | Task 10 now requires a GitHub PR review object or committed `REVIEWS/` record for this implementation at lines 827-838. |
| P2 stale local session risk | resolved | Task 3 adds branch, timestamp, profile validation, strict fallback, and epoch TTL behavior at lines 330-389. Task 7 adds stale and branch-mismatch red checks at lines 642-664. |

### New Findings

| Severity | File | Evidence | Finding | Required Change |
|----------|------|----------|---------|-----------------|
| P1 | `docs/superpowers/plans/2026-05-17-split-state-handoff.md`; `PR_MERGE_POLICY.md` | The revised plan recommends a lightweight bootstrap-governance exception path at lines 68-87 and Task 0 records that exception at lines 145-182. Current merge policy still says a PR may be merged only when it links to an approved or active spec at `PR_MERGE_POLICY.md` lines 19-23, and its only no-spec exception is the initial bootstrap baseline at lines 39-55. | Path B can make implementation appear ready while remaining unmergeable under the current stricter merge policy. The plan records a backlog/traceability exception but does not require updating `PR_MERGE_POLICY.md` to recognize that exception class, and existing stricter policy wins. | Either make Path A mandatory for this implementation, or add an explicit Task 0/Task 5 step to update `PR_MERGE_POLICY.md` with bounded recurring bootstrap-governance exception criteria before Path B can be used. The criteria should require maintainer approval, backlog and traceability rows, strict-protected validation/review, and should explicitly exclude product implementation, runtime code, schemas, APIs, migrations, dependencies, and deployment changes. |

### Re-Review Recommendation

Request changes. The revised plan addresses the original technical and role-coverage blockers, but the recommended exception path needs to be reconciled with `PR_MERGE_POLICY.md` before implementation starts.

### Re-Review Validation Evidence

- `bash SCRIPTS/validate-bootstrap.sh`: passed after recording re-review findings and state/index updates.
- `git diff --check`: passed after recording re-review findings.
- Revised-plan placeholder scan: passed with no matches.

## Second Re-Review 2026-05-17

### Review Decision

approve with minor comments

### Inputs Reviewed

- Revised plan: `docs/superpowers/plans/2026-05-17-split-state-handoff.md`
- Merge policy: `PR_MERGE_POLICY.md`
- Current state and handoff: `CURRENT_STATE.md`, `AI_HANDOFF.md`
- Tracking artifacts: `REVIEWS/REVIEW_INDEX.md`, `TRACEABILITY_MATRIX.md`, `WORKLOG/WORKLOG_INDEX.md`, `TEST_RESULTS.md`

### Finding Resolution

| Prior Severity | Status | Evidence |
|----------------|--------|----------|
| P1 bootstrap-governance exception path conflicted with merge policy | resolved | The plan now requires Path B to first add a bounded recurring bootstrap-governance exception to `PR_MERGE_POLICY.md` before Path B can be used. See plan lines 68-90, 127, 141, and Task 0 lines 149-232. If maintainers reject that exception, the plan falls back to Path A. |

### Minor Comments

- Task 0 must remain the first implementation work. Path B is not available until `PR_MERGE_POLICY.md` contains the bounded recurring exception and that exception is reflected in backlog, traceability, and PR evidence.
- If implementation starts before maintainers approve the recurring exception, use Path A instead.

### Final Recommendation

Approve with minor comments. The revised plan now addresses the prior P1/P2 findings and is ready to proceed to implementation planning/execution, beginning with Task 0. Full implementation still requires strict-protected validation, red checks, shell syntax checks, CI, durable review evidence, and no unresolved P0/P1 findings.

### Second Re-Review Validation Evidence

- `bash SCRIPTS/validate-bootstrap.sh`: passed after recording the approve-with-minor-comments decision and state/index updates.
- `git diff --check`: passed after recording the approve-with-minor-comments decision.
- Revised-plan placeholder scan: passed with no matches.
