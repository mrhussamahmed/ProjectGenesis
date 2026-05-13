artifact_id: ART-REVIEW-002
title: PR Merge Policy
type: merge-policy
status: authoritative
version: v1.1
created: 2026-05-09
updated: 2026-05-14
owner: AI Bootstrap Maintainers
source: User request and SPEC-BOOT-003
linked_specs: [SPEC-BOOT-003]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# PR Merge Policy

A PR may be merged only when:

- it links to an approved or active spec
- it links to a backlog item or ticket
- durable operation classification and final evidence envelope exist for
  meaningful work
- acceptance criteria are satisfied or explicitly deferred with approval
- required tests pass or failures are documented and accepted
- traceability matrix is updated
- artifact registry is updated
- `AI_HANDOFF.md` is updated
- `CURRENT_STATE.md` is updated
- adversarial review is complete
- P0 and P1 findings are resolved
- blocking P2 findings are resolved or explicitly accepted with rationale
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
- `bash SCRIPTS/validate-bootstrap.sh` passes
- fresh adversarial review is complete or review findings are recorded before
  the baseline commit

This exception is only for the bootstrap package baseline. It must not be used
for product implementation, architecture-sensitive product decisions, runtime
code, schemas, APIs, migrations, dependencies, or deployment changes.

## Merge Readiness Evidence

The PR package or merge note must include:

- linked specs and backlog items
- changed files
- tests run and results
- review findings and resolutions
- risk classification
- operation profile and validation mode
- rollout and rollback notes
- traceability row updates
- artifact registry updates
- handoff update

## Not Allowed

- Merging implementation with no linked spec.
- Merging architecture-impacting changes with no ADR or documented provisional
  risk.
- Merging with unresolved P0 or P1 findings.
- Merging with hidden failing tests.
- Merging unrelated changes to avoid cleanup.
