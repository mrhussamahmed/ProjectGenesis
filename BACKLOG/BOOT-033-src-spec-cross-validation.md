artifact_id: ART-BACKLOG-BOOT-033
title: BOOT-033 SRC And SPEC Cross-Validation
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

# BOOT-033: SRC And SPEC Cross-Validation

## Purpose

Make the validator reject cited source IDs and spec IDs that do not exist in
the repository source-of-truth registers.

## User Or System Value

Closes a high-value anti-hallucination gap: agents should not be able to cite
`SRC-*` or `SPEC-*` identifiers that have not been registered.

## Scope

In scope:

- Extend validator checks for cited `SRC-*` IDs against
  `00_intake/SOURCE_REGISTRY.md`.
- Extend validator checks for cited `SPEC-*` IDs against `SPECS/SPEC_INDEX.md`
  or existing spec files.
- Add red-check fixtures for missing source and missing spec references.
- Define an explicit provisional or pending syntax if needed.

Out of scope:

- Requiring non-empty product source registers before product input exists.
- Full requirement coverage metrics.
- Changing spec or backlog templates unless validator behavior requires it.

## Links

- Linked spec: `SPEC-BOOT-002`, `SPEC-BOOT-003`
- Linked acceptance criteria: validator fails on unregistered source/spec IDs
  and passes on registered IDs.
- Linked requirements: source evidence, anti-hallucination, spec linkage
- Source IDs: none; source evidence is the current user instruction to plan
  before implementation and the durable Phase 1 candidate list in
  `CURRENT_STATE.md`.
- Approved assumptions: none
- Source-backed fact: no downstream product input exists yet; validator
  behavior for empty registers and provisional IDs must be defined in BOOT-033
  before implementation.
- Open questions: exact provisional syntax and how empty registers should be
  handled for artifacts with no cited IDs
- Related ADR: none
- Related external ticket: none

## Dependencies

- BOOT-029 merged.
- BOOT-032 may inform coverage and benchmark expectations, but this item can
  proceed independently after plan merge if prioritization changes.

## Risks

- False positives in draft/proposed specs. Mitigate with clear pending syntax
  and scoped validation by artifact status.

## Suggested Owner Role

Implementation Agent, QA Reviewer

## Estimated Complexity

medium

## Implementation Phase

Phase 1D.

## Related Files Or Modules

- `SCRIPTS/validate-bootstrap.sh`
- `SCRIPTS/validate-bootstrap-red-checks.sh`
- `00_intake/SOURCE_REGISTRY.md`
- `SPECS/SPEC_INDEX.md`
- `BACKLOG.md`
- source-of-truth records

## Linear Ticket

- Should become external ticket: no
- Tracker: none
- Ticket status: not-created
- Ticket ID or URL:
- Confirmation evidence:

## Priority

P1

## Readiness Status

queued after BOOT-032

## Readiness Evidence

- Source evidence: current user instruction to plan first, current-state Phase
  1 candidates, and BOOT-029 sequencing.
- Spec status: `SPEC-BOOT-002` active; `SPEC-BOOT-003` approved.
- Acceptance criteria: red checks prove missing ID detection.
- Dependencies: BOOT-029.
- Architecture impact: none.
- Test expectations: validator red checks and shell syntax checks.
- Branch/worktree plan: separate branch from `main`.
- Required reviewers: fresh-context adversarial review because validator
  mechanics change.
- Blocked until: BOOT-032 complete unless the Phase 1 sequence is explicitly
  re-planned.

## Test Expectations

- `bash -n SCRIPTS/validate-bootstrap.sh`
- `bash -n SCRIPTS/validate-bootstrap-red-checks.sh`
- `bash SCRIPTS/validate-bootstrap.sh`
- `bash SCRIPTS/validate-bootstrap-red-checks.sh`
- `git diff --check`

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
- File ownership boundaries: owns validator and red-check files for this PR.
- Shared files requiring coordination: validator scripts, registry,
  traceability, state, handoff, test results, worklog.
- Stop conditions: ID grammar needs spec/template changes beyond this scope.
