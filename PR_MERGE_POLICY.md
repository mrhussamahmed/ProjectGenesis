artifact_id: ART-REVIEW-002
title: PR Merge Policy
type: merge-policy
status: authoritative
version: v1.4
created: 2026-05-09
updated: 2026-05-18
owner: AI Bootstrap Maintainers
source: User request, SPEC-BOOT-003, BOOT-STATE-001, and BOOT-GREEN-MERGE-001
linked_specs: [SPEC-BOOT-003]
linked_tickets: [BOOT-STATE-001, BOOT-GREEN-MERGE-001]
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# PR Merge Policy

A PR may be merged when all applicable objective gates are satisfied. Human,
maintainer, and Code Owner approval are not required as merge gates. AI may
merge after the objective gates pass.

## AI Green-Merge Contract

AI may merge a PR without human approval when all of these are true:

- required CI/status checks pass
- required local validation passes
- no unresolved P0/P1 findings remain
- no unresolved blocking P2 findings remain
- scope is clean (no unrelated changes; dirty worktree state is explained)
- no failed required check is bypassed

Human approval is optional. A maintainer or Code Owner may comment on a PR at
any time, but their approval is not required to merge.

## Objective Merge Gates

Unless a named exception below explicitly allows otherwise, a PR may be merged
only when all applicable conditions are met:

- it links to an approved or active spec, or to a named exception below
- it links to a backlog item or ticket
- durable operation classification and final evidence envelope exist for
  meaningful work
- acceptance criteria are satisfied or explicitly deferred with rationale (deferrals must not effectively bypass a P0/P1/blocking-P2 finding)
- required tests pass — failures must be fixed, not accepted; non-required test failures may be tracked and deferred only when explicitly classified as non-blocking
- traceability matrix is updated
- artifact registry is updated
- canonical `AI_HANDOFF.md` and `CURRENT_STATE.md` are updated only when
  durable project truth changed and the update should remain true on `main`
  after merge
- adversarial review is complete as defect detection (not as authorization)
- P0 and P1 findings are resolved (P0/P1 must not be accepted with rationale)
- blocking P2 findings are resolved (blocking P2 must not be accepted with rationale; non-blocking P2 findings may be tracked and deferred)
- security and privacy review is complete if required
- release or rollback notes exist if relevant
- worktree status is clean or dirty status is explained
- unrelated changes are removed or split into another PR

## Bootstrap Baseline Exception

The initial bootstrap baseline may be committed or merged without a
product-specific approved spec when all of these are true:

- the change is limited to creating or correcting bootstrap governance,
  templates, validation, hooks, CI templates, shared state, and documentation
- the work links to `BOOT-001` in `BACKLOG.md`
- `TRACEABILITY_MATRIX.md` maps the bootstrap requirements
- `ARTIFACT_REGISTRY.md`, `CURRENT_STATE.md`, and `AI_HANDOFF.md` are updated
  when durable project truth changes
- `bash SCRIPTS/validate-bootstrap.sh` passes
- fresh adversarial review is complete or review findings are recorded before
  the baseline commit

This exception is only for the bootstrap package baseline. It must not be used
for product implementation, architecture-sensitive product decisions, runtime
code, schemas, APIs, migrations, dependencies, or deployment changes.

## Recurring Bootstrap Governance Exception

A bootstrap-governance PR may merge without an approved or active spec only
when all of these are true:

- the change is limited to bootstrap governance, agent instructions, review
  policy, merge policy, validation scripts, hooks, CI checks, templates,
  shared-state mechanics, or documentation for the bootstrap operating model
- the PR links to a backlog item or ticket describing the governance work
- `TRACEABILITY_MATRIX.md` maps the governance requirement, implementation,
  tests, and review evidence
- `ARTIFACT_REGISTRY.md`, `CURRENT_STATE.md`, `AI_HANDOFF.md`, and
  `TEST_RESULTS.md` are updated when impacted
- operation classification and final evidence are durable in PR/review
  evidence, not only in local session files
- `bash SCRIPTS/validate-bootstrap.sh`, relevant red checks, shell syntax checks, `git diff --check`, and CI all pass. A required check that fails or is bypassed cannot be merged. A check may only be skipped when the operation profile explicitly does not apply to it and the rationale is recorded as a non-blocking decision; that record must not effectively bypass a P0/P1/blocking-P2 finding
- fresh adversarial review is complete with no unresolved P0/P1 findings and
  no unresolved blocking P2 findings

Human, maintainer, or Code Owner approval is not required to use this
exception. The exception is governed by objective gates above and by the
adversarial defect-detection review described in `PR_REVIEW_POLICY.md`.

This exception must not be used for product implementation, runtime code,
schemas, APIs, migrations, dependencies, deployment changes,
security-sensitive runtime behavior, or architecture-sensitive product
decisions.

## Merge Readiness Evidence

The PR package or merge note must include:

- linked specs or named exception, plus backlog items
- changed files
- tests run and results
- review findings and resolutions
- risk classification
- operation profile and validation mode
- rollout and rollback notes
- traceability row updates
- artifact registry updates
- handoff update when durable project truth changed
- branch-specific status in PR evidence, not active canonical state

## Not Allowed

- Merging product implementation with no linked spec.
- Merging bootstrap-governance work without either a linked spec or a named
  exception above.
- Merging architecture-impacting changes with no ADR or documented provisional
  risk.
- Merging with unresolved P0 or P1 findings (acceptance-with-rationale is not permitted for P0 or P1).
- Merging with unresolved blocking P2 findings (acceptance-with-rationale is not permitted for blocking P2 either; non-blocking P2 may be tracked and deferred).
- Merging with hidden or bypassed failing required checks.
- Merging unrelated changes to avoid cleanup.
- Reintroducing required human, maintainer, or Code Owner approval as a merge
  gate in active authoritative policy. The validator enforces this.
