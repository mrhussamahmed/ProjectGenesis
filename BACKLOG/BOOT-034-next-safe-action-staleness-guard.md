artifact_id: ART-BACKLOG-BOOT-034
title: BOOT-034 Next Safe Action Staleness Guard
type: backlog-item
status: active
version: v1.2
created: 2026-05-16
updated: 2026-05-16
owner: AI Bootstrap Maintainers
source: Phase 1 closeout coherence verification, PR #10 BOOT-033 review-loop lesson, BOOT-034 validator-backed implementation, and BOOT-034 PR #13 v1.2 review-fix addressing the fresh-context Codex adversarial review findings
linked_specs: [SPEC-BOOT-003]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# BOOT-034: Next Safe Action Staleness Guard

## Purpose

Prevent committed handoff and state evidence from preserving stale
forward-looking `Next safe action:` instructions after the referenced action
has already been applied.

## User Or System Value

Reduces review churn and recursive state-fix loops like the PR #10 / BOOT-033
v1.0 through v1.5 sequence, where successive review passes found stale
next-action instructions in older evidence envelopes.

## Scope

In scope:

- Define a repository convention for historical evidence envelopes that were
  superseded by later commits.
- Decide whether stale `Next safe action:` wording should be documented-only,
  template-driven, or validator-enforced.
- If validator-enforced, add targeted red-check fixtures before changing the
  validator behavior.
- Update templates or handoff guidance only after the convention is reviewed.

Out of scope:

- Rewriting historical review records for cosmetic wording only.
- Changing source-of-truth hierarchy or review policy without a separate
  strict-protected review.
- Blocking legitimate historical evidence that clearly says it is superseded.

## Implementation Decision

Validator-backed path selected. `SCRIPTS/validate-bootstrap.sh` adds a narrow
fail-closed check that counts unmarked `Next safe action:` envelope fields in
`AI_HANDOFF.md` and `CURRENT_STATE.md`. At most one unmarked field per file
is allowed. Historical envelopes must mark their `Next safe action:` payload
with `completed`, `superseded`, `historical`, or `delegated` (case
insensitive, whole-word). `SCRIPTS/validate-bootstrap-red-checks.sh` adds
eight fixtures covering:

- two unmarked entries trip the guard on `AI_HANDOFF.md`,
- two unmarked entries trip the guard on `CURRENT_STATE.md`,
- `completed`, `superseded`, `historical`, and `delegated` are accepted as
  markers (four fixtures),
- the live `## Next Recommended Action` section heading is not over-matched,
- and unrelated narrative prose mentioning `Next safe action:` inside
  backticks is not over-matched.

Existing historical envelope fields in `AI_HANDOFF.md` were bulk-marked with
a `(historical)` prefix to satisfy the new rule on the current state. The
new BOOT-034 envelope retains a single unmarked `Next safe action:` as the
active current entry.

## Links

- Linked spec: `SPEC-BOOT-003`
- Linked acceptance criteria: future handoff/state records have an approved
  convention or check that prevents active stale next-action guidance after
  the action is complete.
- Linked requirements: durable evidence, handoff compression safety,
  state-sync coherence, review-loop reduction
- Source IDs: none; source evidence is the PR #10 BOOT-033 review-loop record
  in `REVIEWS/REVIEW-2026-05-16-pr-10-boot-033-src-spec-cross-validation.md`
  and this Phase 1 closeout verification.
- Approved assumptions: none
- Related ADR: none expected
- Related external ticket: none

## Dependencies

- Phase 1 complete.
- BOOT-033 merged and post-merge source-of-truth cleanup verified.

## Risks

- Overzealous validation could reject useful historical evidence. Mitigate by
  first documenting the convention and proving any validator rule with focused
  red-check fixtures.

## Suggested Owner Role

Documentation Curator, QA Reviewer

## Estimated Complexity

medium

## Implementation Phase

Phase 2 candidate.

## Related Files Or Modules

- `AI_HANDOFF.md`
- `CURRENT_STATE.md`
- `OPERATION_ROUTING.md`
- `REVIEWS/templates/PR_REVIEW_PACKAGE_TEMPLATE.md`
- `BACKLOG/templates/BACKLOG_ITEM_TEMPLATE.md`
- `SCRIPTS/validate-bootstrap.sh`, only if validator enforcement is chosen
- `SCRIPTS/validate-bootstrap-red-checks.sh`, only if validator enforcement is chosen

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

- Source evidence: PR #10 / BOOT-033 required five Codex review passes before
  stale circular next-action wording was fully removed from current evidence.
- Spec status: `SPEC-BOOT-003` is approved and governs durable evidence,
  state sync, and handoff compression safety.
- Acceptance criteria: validator rule prevents future stale forward-looking
  `Next safe action:` entries; red-check fixtures cover both failure and
  success cases; existing committed evidence is brought into compliance.
- Dependencies: Phase 1 closeout verification complete; BOOT-035 merged and
  `main` CI green at `f116f85`.
- Architecture impact: none beyond validator script and red-check fixture
  additions.
- Test expectations: bootstrap validation, red checks, and `git diff --check`
  must pass locally and in CI.
- Branch/worktree plan: `claude/boot-034-next-safe-action-staleness-guard`
  from green `main` at `f116f85`.
- Required reviewers: fresh-context Codex adversarial review because
  validator mechanics change.
- Blocked until: Codex adversarial review approves with no P0/P1/blocking P2
  findings.

## Test Expectations

- `bash -n SCRIPTS/validate-bootstrap.sh`
- `bash -n SCRIPTS/validate-bootstrap-red-checks.sh`
- `bash SCRIPTS/validate-bootstrap.sh`
- `bash SCRIPTS/validate-bootstrap-red-checks.sh`
- `git diff --check`
- GitHub Actions `Bootstrap Validation`

## Definition Of Done

- [x] Convention chosen and recorded in the appropriate authoritative file.
- [x] Templates or validators updated only if the chosen path requires them.
- [x] Red-check fixtures added before validator enforcement, if any.
- [x] Traceability updated.
- [x] Artifact registry updated.
- [x] Handoff updated.
- [ ] Fresh-context review complete before merge.

## Parallelization

- Status: not-allowed
- File ownership boundaries: owns only the selected Phase 2 convention,
  template, validator, and related source-of-truth records.
- Shared files requiring coordination: registry, traceability, state, handoff,
  test results, worklog, templates, and validator scripts if selected.
- Stop conditions: proposed rule would change review policy, source-of-truth
  hierarchy, or operation-routing semantics beyond stale next-action handling.
