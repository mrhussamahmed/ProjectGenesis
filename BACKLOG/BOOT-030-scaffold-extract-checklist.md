artifact_id: ART-BACKLOG-BOOT-030
title: BOOT-030 Scaffold Extraction Checklist
type: backlog-item
status: active
version: v1.2
created: 2026-05-15
updated: 2026-05-15
owner: AI Bootstrap Maintainers
source: Phase 1 execution planning input promoted into tracked backlog, PR #6 review fix, and PR #6 merge/post-merge source-of-truth cleanup
linked_specs: [SPEC-BOOT-002, SPEC-BOOT-003]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# BOOT-030: Scaffold Extraction Checklist

## Purpose

Define the human-readable extraction policy for turning ProjectGenesis into a
clean downstream project scaffold before writing an extraction script.

## User Or System Value

Removes the biggest reuse blocker: downstream users should not inherit
ProjectGenesis-specific BOOT history, review records, and stale handoff state.

## Scope

In scope:

- Create `SCAFFOLD_FORK_CHECKLIST.md`.
- Define which artifacts are framework files, instance history, examples, or
  reset templates.
- Define the clean-state expectations for `CURRENT_STATE.md`, `AI_HANDOFF.md`,
  `TRACEABILITY_MATRIX.md`, `BACKLOG.md`, specs, reviews, and worklogs.
- Define validation expectations for a manually extracted scaffold.

Out of scope:

- Writing `SCRIPTS/scaffold-extract.sh`.
- Changing validators.
- Adding new metadata fields.
- Editing public README claims beyond a minimal pointer if needed.

## Links

- Linked spec: `SPEC-BOOT-002`, `SPEC-BOOT-003`
- Linked acceptance criteria: `SCAFFOLD_FORK_CHECKLIST.md` exists and is
  registered; extraction policy is reviewable before script work.
- Linked requirements: scaffold reuse, source-of-truth reset safety
- Source IDs: none; source evidence is the current user instruction to plan
  before implementation and the durable Phase 1 candidate list in
  `CURRENT_STATE.md`.
- Approved assumptions: none
- Planning rationale: checklist-first sequencing was approved through PR #6;
  BOOT-030 is the next executable Phase 1 slice after latest `main` validation
  is confirmed green.
- Open questions: whether later script needs per-artifact metadata
- Related ADR: none
- Related external ticket: none

## Dependencies

- BOOT-029 merged.

## Risks

- Checklist might miss a ProjectGenesis-specific artifact. Mitigate by
  requiring fresh-context review before script implementation.

## Suggested Owner Role

Documentation Curator

## Estimated Complexity

medium

## Implementation Phase

Phase 1A.

## Related Files Or Modules

- `SCAFFOLD_FORK_CHECKLIST.md`
- `ARTIFACT_REGISTRY.md`
- `TRACEABILITY_MATRIX.md`
- `CURRENT_STATE.md`
- `AI_HANDOFF.md`
- `TEST_RESULTS.md`
- `WORKLOG/WORKLOG_INDEX.md`

## Linear Ticket

- Should become external ticket: no
- Tracker: none
- Ticket status: not-created
- Ticket ID or URL:
- Confirmation evidence:

## Priority

P0

## Readiness Status

ready

## Readiness Evidence

- Source evidence: current user instruction to plan first, current-state Phase
  1 candidates, and BOOT-029 sequencing.
- Spec status: `SPEC-BOOT-002` active; `SPEC-BOOT-003` approved.
- Acceptance criteria: checklist records reset/exclude/archive behavior.
- Dependencies: BOOT-029 plan merged.
- Architecture impact: none unless later script introduces new metadata.
- Test expectations: bootstrap validation and diff check; red checks only if
  validator behavior changes.
- Branch/worktree plan: separate branch from `main`.
- Required reviewers: fresh-context review before merge.
- Blocked until: none; BOOT-029 merged through PR #6 on 2026-05-15.

## Test Expectations

- `bash SCRIPTS/validate-bootstrap.sh`
- `git diff --check`
- Red checks not required unless validator behavior changes.

## Definition Of Done

- [ ] Spec linked.
- [ ] Acceptance criteria satisfied.
- [ ] Tests added or updated, or justified.
- [ ] Traceability updated.
- [ ] Artifact registry updated.
- [ ] Handoff updated.
- [ ] Review complete or pending review recorded.

## Parallelization

- Status: not-allowed
- File ownership boundaries: owns extraction checklist and related
  source-of-truth records only.
- Shared files requiring coordination: registry, traceability, state, handoff,
  test results, worklog.
- Stop conditions: script or validator changes become necessary.
