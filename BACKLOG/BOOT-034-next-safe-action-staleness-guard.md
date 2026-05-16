artifact_id: ART-BACKLOG-BOOT-034
title: BOOT-034 Next Safe Action Staleness Guard
type: backlog-item
status: active
version: v1.0
created: 2026-05-16
updated: 2026-05-16
owner: AI Bootstrap Maintainers
source: Phase 1 closeout coherence verification and PR #10 BOOT-033 review-loop lesson
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

proposed

## Readiness Evidence

- Source evidence: PR #10 / BOOT-033 required five Codex review passes before
  stale circular next-action wording was fully removed from current evidence.
- Spec status: `SPEC-BOOT-003` is approved and governs durable evidence,
  state sync, and handoff compression safety.
- Acceptance criteria: not yet finalized.
- Dependencies: Phase 1 closeout verification.
- Architecture impact: none unless validator enforcement is selected.
- Test expectations: bootstrap validation and diff check for documentation-only
  convention; red checks and shell syntax checks if validator behavior changes.
- Branch/worktree plan: separate Phase 2 branch from green `main`.
- Required reviewers: fresh-context review; adversarial review if validator,
  template, operation-routing, or policy behavior changes.
- Blocked until: Phase 2 planning chooses documentation-only, template, or
  validator enforcement path.

## Test Expectations

- `bash SCRIPTS/validate-bootstrap.sh`
- `bash SCRIPTS/validate-bootstrap-red-checks.sh` if validator behavior changes
- `git diff --check`

## Definition Of Done

- [ ] Convention chosen and recorded in the appropriate authoritative file.
- [ ] Templates or validators updated only if the chosen path requires them.
- [ ] Red-check fixtures added before validator enforcement, if any.
- [ ] Traceability updated.
- [ ] Artifact registry updated.
- [ ] Handoff updated.
- [ ] Fresh-context review complete before merge.

## Parallelization

- Status: not-allowed
- File ownership boundaries: owns only the selected Phase 2 convention,
  template, validator, and related source-of-truth records.
- Shared files requiring coordination: registry, traceability, state, handoff,
  test results, worklog, templates, and validator scripts if selected.
- Stop conditions: proposed rule would change review policy, source-of-truth
  hierarchy, or operation-routing semantics beyond stale next-action handling.
