artifact_id: ART-BACKLOG-BOOT-031
title: BOOT-031 Scaffold Extraction Tool
type: backlog-item
status: active
version: v1.0
created: 2026-05-15
updated: 2026-05-15
owner: AI Bootstrap Maintainers
source: IB-P0-01 planning input promoted into tracked backlog after Phase 0 merge
linked_specs: [SPEC-BOOT-002, SPEC-BOOT-003]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# BOOT-031: Scaffold Extraction Tool

## Purpose

Implement a dry-run-first scaffold extraction tool after the checklist defines
the exact reset and exclusion policy.

## User Or System Value

Lets a downstream user create a clean project scaffold without manually
removing ProjectGenesis history and without losing required governance files.

## Scope

In scope:

- Add `SCRIPTS/scaffold-extract.sh <target-dir>` or an equivalently scoped
  extraction script.
- Keep dry-run behavior as the default.
- Add golden or fixture validation showing the extracted scaffold passes
  bootstrap validation.
- Record rollback and overwrite safeguards.

Out of scope:

- Full multi-command CLI.
- Project-type profile support.
- Public README claim expansion before tests exist.

## Links

- Linked spec: `SPEC-BOOT-002`, `SPEC-BOOT-003`
- Linked acceptance criteria: extracted target validates and contains reset
  source-of-truth state.
- Linked requirements: scaffold reuse, clean downstream initialization
- Source IDs: none; planning input promoted from research package
- Approved assumptions: script follows BOOT-030 policy
- Open questions: exact fixture location to be decided in BOOT-031
- Related ADR: none expected
- Related external ticket: none

## Dependencies

- BOOT-030 merged and reviewed.

## Risks

- Incorrect extraction could drop required files or leave instance history.
  Mitigate with dry-run default, explicit target directory, and validation in
  an extracted fixture.

## Suggested Owner Role

Implementation Agent, QA Reviewer

## Estimated Complexity

medium

## Implementation Phase

Phase 1B.

## Related Files Or Modules

- `SCRIPTS/scaffold-extract.sh`
- `SCRIPTS/validate-bootstrap-red-checks.sh`
- extraction fixture or generated test target
- `TEST_RESULTS.md`
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

blocked

## Readiness Evidence

- Source evidence: BOOT-030 checklist after merge.
- Spec status: `SPEC-BOOT-002` active; `SPEC-BOOT-003` approved.
- Acceptance criteria: target extraction passes validator and clean-state
  checks.
- Dependencies: BOOT-030.
- Architecture impact: possible script/metadata impact, to be confirmed in
  BOOT-031 classification.
- Test expectations: red-check fixtures, bootstrap validation on extracted
  target, shell syntax checks.
- Branch/worktree plan: separate branch from `main`.
- Required reviewers: fresh-context adversarial review.
- Blocked until: BOOT-030 merged.

## Test Expectations

- `bash -n SCRIPTS/scaffold-extract.sh`
- `bash SCRIPTS/validate-bootstrap.sh`
- `bash SCRIPTS/validate-bootstrap-red-checks.sh`
- Extract into a temporary target and run `bash SCRIPTS/validate-bootstrap.sh`
  inside that target.
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
- File ownership boundaries: owns extraction script, extraction fixtures, and
  related test records.
- Shared files requiring coordination: validator/red-check scripts if touched,
  registry, traceability, state, handoff, test results, worklog.
- Stop conditions: extraction policy ambiguity, destructive target behavior,
  or need for project-type profile support.
