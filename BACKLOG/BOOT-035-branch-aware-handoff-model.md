artifact_id: ART-BACKLOG-BOOT-035
title: BOOT-035 Branch-Aware Handoff Model
type: backlog-item
status: active
version: v1.0
created: 2026-05-16
updated: 2026-05-16
owner: AI Bootstrap Maintainers
source: Phase 1 closeout coherence verification and repeated post-merge CI branch-field failures
linked_specs: [SPEC-BOOT-003]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# BOOT-035: Branch-Aware Handoff Model

## Purpose

Fix the structural merge-drift caused by the singular
`AI_HANDOFF.md` `## Current Branch` field.

## User Or System Value

Stops otherwise-good merge commits from failing `main` CI only because a
feature-branch handoff field still names the branch that was just merged.

## Scope

In scope:

- Decide the branch-aware handoff design:
  - make `AI_HANDOFF.md` branch-neutral on `main`, or
  - move branch-specific operational handoff state into per-stream files, or
  - update validator behavior so `main` merge commits are checked against
    branch-neutral state rather than stale feature-branch state.
- Preserve current source-of-truth hierarchy and handoff evidence requirements.
- Add focused red-check fixtures before changing validator behavior.
- Document the post-merge cleanup flow and any per-stream handoff lifecycle.

Out of scope:

- Weakening handoff evidence requirements.
- Removing current-state or handoff validation entirely.
- Changing PR review or merge policy beyond the minimum branch-field drift fix.
- Rewriting historical handoff evidence for cosmetic reasons.

## Links

- Linked spec: `SPEC-BOOT-003`
- Linked acceptance criteria: merging a feature branch to `main` no longer
  fails bootstrap validation solely because `AI_HANDOFF.md` still names the
  merged feature branch.
- Linked requirements: durable handoff evidence, branch/worktree hygiene,
  validation boundary correctness
- Source IDs: none; source evidence is the repeated post-merge CI failure
  pattern documented for PR #5 through PR #10 in `CURRENT_STATE.md`,
  `TEST_RESULTS.md`, and `WORKLOG/WORKLOG_INDEX.md`.
- Approved assumptions: none
- Related ADR: possible if the chosen design creates a new durable handoff
  artifact family.
- Related external ticket: none

## Dependencies

- Phase 1 complete.
- BOOT-034 may proceed independently; BOOT-035 addresses branch-field merge
  drift, not stale next-action wording.

## Risks

- A validator-only exception could hide real branch/handoff drift. Mitigate by
  pairing any validator change with a clear branch-neutral source-of-truth
  convention and red-check fixtures.
- Per-stream handoff files could become a duplicate source of truth. Mitigate
  by defining lifecycle, precedence, and cleanup rules before implementation.

## Suggested Owner Role

Documentation Curator, QA Reviewer, Implementation Agent

## Estimated Complexity

medium

## Implementation Phase

Phase 2 candidate.

## Related Files Or Modules

- `AI_HANDOFF.md`
- `CURRENT_STATE.md`
- `BRANCH_AND_WORKTREE_GUIDE.md`
- `OPERATION_ROUTING.md`
- `SCRIPTS/validate-bootstrap.sh`
- `SCRIPTS/validate-bootstrap-red-checks.sh`
- `HANDOFFS/`
- source-of-truth records

## Linear Ticket

- Should become external ticket: no
- Tracker: none
- Ticket status: not-created
- Ticket ID or URL:
- Confirmation evidence:

## Priority

P0

## Readiness Status

proposed

## Readiness Evidence

- Source evidence: repeated merge or post-merge CI failures from the singular
  `AI_HANDOFF.md` branch field are recorded for PR #5 through PR #10.
- Spec status: `SPEC-BOOT-003` is approved and governs branch/worktree
  hygiene, durable evidence, and validation behavior.
- Acceptance criteria: not yet finalized beyond preventing branch-field-only
  CI failures after merge.
- Dependencies: Phase 1 closeout verification.
- Architecture impact: possible if per-stream handoff files become a durable
  artifact family.
- Test expectations: strict validation, red-check fixtures, shell syntax checks
  if validator behavior changes, and GitHub Actions confirmation.
- Branch/worktree plan: separate strict-protected Phase 2 branch from green
  `main`.
- Required reviewers: fresh-context adversarial review; QA/release focus if
  validator or CI behavior changes.
- Blocked until: design path is chosen in a reviewed Phase 2 plan.

## Test Expectations

- `bash -n SCRIPTS/validate-bootstrap.sh`
- `bash -n SCRIPTS/validate-bootstrap-red-checks.sh`
- `bash SCRIPTS/validate-bootstrap.sh`
- `bash SCRIPTS/validate-bootstrap-red-checks.sh`
- `git diff --check`
- GitHub Actions `Bootstrap Validation`

## Definition Of Done

- [ ] Branch-aware handoff design chosen and documented.
- [ ] Validator behavior updated only if required by the chosen design.
- [ ] Red-check fixtures prove the merge-drift case and guard against hiding
      real handoff branch drift.
- [ ] Artifact registry updated.
- [ ] Traceability updated.
- [ ] Current state and handoff updated.
- [ ] Fresh-context adversarial review complete.
- [ ] GitHub Actions confirms `main` no longer fails on branch-field-only
      merge drift.

## Parallelization

- Status: not-allowed
- File ownership boundaries: owns handoff branch-model design, related
  validation behavior, and source-of-truth records.
- Shared files requiring coordination: handoff, current state, branch guide,
  operation routing, validator scripts, red-check scripts, registry,
  traceability, test results, and worklog.
- Stop conditions: chosen design changes source-of-truth hierarchy,
  branch-protection policy, or review policy beyond the narrow branch-field
  drift fix.
