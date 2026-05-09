artifact_id: ART-GOV-001
title: Governance
type: governance
status: authoritative
version: v1.1
created: 2026-05-09
updated: 2026-05-09
owner: AI Bootstrap Maintainers
source: User request and reference repository audit
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Governance

## Non-Negotiable Principles

1. Spec first: production implementation starts only from an approved or active
   spec.
2. Tests before or alongside implementation: acceptance criteria drive tests.
3. Evidence over memory: use files, code, tests, specs, tickets, and decisions.
4. Shared state over agent memory: neutral files define project truth.
5. One current truth: authoritative artifacts are recorded in
   `ARTIFACT_REGISTRY.md`.
6. No silent drift: conflicts are documented and resolved.
7. No fake completion: completion requires implementation, validation,
   documentation, traceability, and handoff evidence.
8. Fresh adversarial review: every PR receives fresh-context review.
9. Production readiness: security, reliability, maintainability, observability,
   and release safety are explicit.
10. Minimize interruption: ask only when missing information blocks progress or
    creates major risk.
11. No over-engineering: keep governance practical and local checks fast.

## Source-Of-Truth Enforcement

Use the hierarchy in `AI_PROJECT_BOOTSTRAP.md`. If lower-priority sources
conflict with higher-priority sources, follow the higher source and document the
conflict.

## Artifact Lifecycle

Important artifacts must include this metadata block:

```yaml
artifact_id:
title:
type:
status:
version:
created:
updated:
owner:
source:
linked_specs:
linked_tickets:
linked_adrs:
replaces:
replaced_by:
authoritative: true/false
```

Exception: `AGENTS.md` and `CLAUDE.md` are intentionally short agent entrypoint
files. They may omit the metadata block when they are registered in
`ARTIFACT_REGISTRY.md` and the validator explicitly excludes them from metadata
checks.

Allowed artifact statuses:

- draft
- active
- authoritative
- superseded
- deprecated
- cancelled
- archived
- generated
- temporary

## Spec Statuses

Allowed spec statuses:

- draft
- proposed
- approved
- active
- implemented
- tested
- released
- superseded
- cancelled
- archived

Implementation requires approved or active status unless provisional risk is
explicitly documented.

## Versioning

- `v0.x`: draft
- `v1.0`: first approved version
- `v1.x`: compatible update
- `v2.0`: major change to scope, architecture, behavior, or implementation
  direction

## Drift Handling

Spec drift exists when implementation, tests, backlog, docs, or PR scope differ
from the approved spec.

Architecture drift exists when implementation changes boundaries,
dependencies, data flow, API contracts, deployment assumptions, or integration
behavior without architecture or ADR updates.

Resolve drift by updating the relevant spec, architecture, ADR, tests, backlog,
traceability, and artifact registry together.

## Role Separation

- Implementers do not self-approve PRs.
- High-risk changes require focused review by security, architecture, QA, and
  release roles.
- Reviewers use repository evidence, not implementer chat history.

## Required End-Of-Session Updates

Every major work session ends with updates to:

- `CURRENT_STATE.md`
- `AI_HANDOFF.md`
- `ARTIFACT_REGISTRY.md`
- `TRACEABILITY_MATRIX.md`
- `SPECS/SPEC_INDEX.md`, when specs changed
- `TEST_RESULTS.md`, when checks ran
- `WORKLOG/WORKLOG_INDEX.md`
- `STALE_ITEMS.md`, when drift or stale files were found
