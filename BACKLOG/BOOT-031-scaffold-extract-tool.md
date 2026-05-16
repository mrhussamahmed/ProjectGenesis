artifact_id: ART-BACKLOG-BOOT-031
title: BOOT-031 Scaffold Extraction Tool
type: backlog-item
status: active
version: v1.2
created: 2026-05-15
updated: 2026-05-16
owner: AI Bootstrap Maintainers
source: Phase 1 execution planning input promoted into tracked backlog, PR #6 review fix, and BOOT-031 implementation on branch claude/boot-031-scaffold-extract-tool
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
- Source IDs: none; source evidence is the current user instruction to plan
  before implementation and the durable Phase 1 candidate list in
  `CURRENT_STATE.md`.
- Approved assumptions: none
- Dependency fact: BOOT-031 must follow the extraction policy created by
  BOOT-030 and remains blocked until BOOT-030 is reviewed and merged.
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

in-review

## Readiness Evidence

- Source evidence: BOOT-030 checklist merged through PR #7 at
  `9066894`/`9e21ce9`.
- Spec status: `SPEC-BOOT-002` active; `SPEC-BOOT-003` approved.
- Acceptance criteria: extracted target passes `bash SCRIPTS/validate-bootstrap.sh`
  via the new golden red-check fixture; dry-run default writes nothing; safety
  refusals are covered by red checks.
- Dependencies: BOOT-030 merged.
- Architecture impact: adds the new `SCRIPTS/scaffold-extract.sh` script and
  four red-check fixtures; the validator itself is unchanged.
- Test expectations: shell syntax checks, bootstrap validation,
  bootstrap red checks (including four new BOOT-031 fixtures), and an in-target
  validation invoked by the script's Phase 4.
- Branch/worktree plan: `claude/boot-031-scaffold-extract-tool` from latest
  green `main`.
- Required reviewers: fresh-context adversarial Codex review through the
  installed plugin once GitHub `validate` is green.

## Test Expectations

- `bash -n SCRIPTS/scaffold-extract.sh`
- `bash SCRIPTS/validate-bootstrap.sh`
- `bash SCRIPTS/validate-bootstrap-red-checks.sh`
- Extract into a temporary target and run `bash SCRIPTS/validate-bootstrap.sh`
  inside that target.
- `git diff --check`

## Definition Of Done

- [x] Spec linked.
- [x] Acceptance criteria satisfied: extracted scaffold validates locally and
      red-check golden fixture passes.
- [x] Tests added: four new red-check fixtures
      (`case_scaffold_extract_golden_validates`,
      `case_scaffold_extract_dry_run_writes_nothing`,
      `case_scaffold_extract_refuses_source_as_target`,
      `case_scaffold_extract_refuses_nonempty_without_force`).
- [x] Traceability updated.
- [x] Artifact registry updated (new `ART-SCAFFOLD-EXTRACT-SCRIPT`).
- [x] Handoff updated.
- [ ] Review complete or pending review recorded: fresh-context Codex review
      will run after the PR is open and GitHub `validate` is green.

## Parallelization

- Status: not-allowed
- File ownership boundaries: owns extraction script, extraction fixtures, and
  related test records.
- Shared files requiring coordination: validator/red-check scripts if touched,
  registry, traceability, state, handoff, test results, worklog.
- Stop conditions: extraction policy ambiguity, destructive target behavior,
  or need for project-type profile support.
