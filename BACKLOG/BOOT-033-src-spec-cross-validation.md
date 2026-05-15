artifact_id: ART-BACKLOG-BOOT-033
title: BOOT-033 SRC And SPEC Cross-Validation
type: backlog-item
status: active
version: v1.0
created: 2026-05-15
updated: 2026-05-15
owner: AI Bootstrap Maintainers
source: IB-P1-01 planning input promoted into tracked backlog after Phase 0 merge
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
- Source IDs: none; planning input promoted from research package
- Approved assumptions: empty registers are acceptable until product input
  exists if cited IDs are not present
- Open questions: exact provisional syntax
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

ready after BOOT-029

## Readiness Evidence

- Source evidence: IB-P1-01 planning input and current-state candidate list.
- Spec status: `SPEC-BOOT-002` active; `SPEC-BOOT-003` approved.
- Acceptance criteria: red checks prove missing ID detection.
- Dependencies: BOOT-029.
- Architecture impact: none.
- Test expectations: validator red checks and shell syntax checks.
- Branch/worktree plan: separate branch from `main`.
- Required reviewers: fresh-context adversarial review because validator
  mechanics change.
- Blocked until: BOOT-029 merged.

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
