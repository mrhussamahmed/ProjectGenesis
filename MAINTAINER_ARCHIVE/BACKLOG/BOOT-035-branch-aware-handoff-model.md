artifact_id: ART-BACKLOG-BOOT-035
title: BOOT-035 Branch-Aware Handoff Model
type: backlog-item
status: active
version: v1.4
created: 2026-05-16
updated: 2026-05-16
owner: AI Bootstrap Maintainers
source: Phase 1 closeout coherence verification, repeated post-merge CI branch-field failures, BOOT-035 branch-aware handoff implementation startup, BOOT-035 in-review evidence, BOOT-035 review approval, PR #12 BOOT-035 merge, and BOOT-035 shallow-checkout CI fix
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

## Chosen Design

BOOT-035 uses a narrow validator-backed merge exception rather than making
`AI_HANDOFF.md` branch-neutral or introducing per-stream handoff files in this
slice.

The validator continues to require exact equality between `AI_HANDOFF.md`
`## Current Branch` and `git branch --show-current` in normal branch contexts.
The only allowed mismatch is:

- the current Git branch is `main`;
- `HEAD` is an actual two-parent merge commit, detected from commit-object
  `parent` headers so depth-1 GitHub Actions checkouts work;
- the merge commit subject follows GitHub's `Merge pull request ... from
  owner/branch-name` shape; and
- the parsed source `branch-name` exactly matches the branch named in
  `AI_HANDOFF.md`.

This targets the observed failure mode without making the handoff branch field
globally branch-neutral. Normal feature-branch drift, stale branch fields on
ordinary `main` commits, and merge commits whose source branch does not match
the handoff branch must still fail validation.

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

done

## Readiness Evidence

- Source evidence: repeated merge or post-merge CI failures from the singular
  `AI_HANDOFF.md` branch field are recorded for PR #5 through PR #10.
- Spec status: `SPEC-BOOT-003` is approved and governs branch/worktree
  hygiene, durable evidence, and validation behavior.
- Acceptance criteria: GitHub-style merge commits on `main` pass when
  `AI_HANDOFF.md` names the merged source branch; ordinary branch drift still
  fails on feature branches, normal `main` commits, and mismatched merge
  sources.
- Dependencies: Phase 1 closeout verification.
- Architecture impact: possible if per-stream handoff files become a durable
  artifact family.
- Test expectations: strict validation, red-check fixtures including a
  depth-1 checkout fixture, shell syntax checks, and GitHub Actions
  confirmation after post-merge cleanup push.
- Branch/worktree plan: implemented on `codex/boot-035-branch-aware-handoff`;
  merged through PR #12, then cleaned up on `main`.
- Required reviewers: fresh-context design review before validator changes and
  fresh-context adversarial implementation review before merge.
- Design gate: narrow merge-commit validator exception selected;
  fresh-context design review completed with no P0 blocker and one resolved
  P1 wording constraint to parse the GitHub merge subject rather than a
  nonexistent second-parent branch name.

## Test Expectations

- `bash -n SCRIPTS/validate-bootstrap.sh`
- `bash -n SCRIPTS/validate-bootstrap-red-checks.sh`
- `bash SCRIPTS/validate-bootstrap.sh`
- `bash SCRIPTS/validate-bootstrap-red-checks.sh`
- `git diff --check`
- GitHub Actions `Bootstrap Validation`

## Definition Of Done

- [x] Branch-aware handoff design chosen and documented.
- [x] Validator behavior updated only if required by the chosen design.
- [x] Red-check fixtures prove the merge-drift case and guard against hiding
      real handoff branch drift.
- [x] Artifact registry updated.
- [x] Traceability updated.
- [x] Current state and handoff updated.
- [x] Fresh-context adversarial review complete.
- [x] GitHub-style merge commit validation works in depth-1 checkout fixtures.
- [x] GitHub Actions confirmation is required after the cleanup push; if it
      fails, BOOT-035 reopens and the cleanup must be amended before stopping.

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
