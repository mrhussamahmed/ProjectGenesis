artifact_id: ART-GOV-001
title: Governance
type: governance
status: authoritative
version: v2.0
created: 2026-05-09
updated: 2026-06-10
owner: AI Bootstrap Maintainers
source: User request, reference repository audit, SPEC-BOOT-002, SPEC-BOOT-003, BOOT-STATE-001, and BOOT-GREEN-MERGE-001
linked_specs: [SPEC-BOOT-002, SPEC-BOOT-003]
linked_tickets: [BOOT-STATE-001, BOOT-GREEN-MERGE-001]
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
8. Risk-routed review: Review depth follows the operation profile per
   OPERATION_ROUTING.md and PR_REVIEW_POLICY.md: docs-trivial,
   docs-non-authoritative, and state-sync changes require a recorded
   self-check in the PR body; planning-governance and strict-protected changes
   require fresh-context adversarial review.
9. Production readiness: security, reliability, maintainability, observability,
   and release safety are explicit.
10. Minimize interruption: ask only when missing information blocks progress or
    creates major risk.
11. No over-engineering: keep governance practical and local checks fast.
12. Adaptive routing: use `OPERATION_ROUTING.md` to match effort, reads,
    writes, validation, and review to verified impact.

## Source-Of-Truth Enforcement

Use the hierarchy in `AI_PROJECT_BOOTSTRAP.md`. If lower-priority sources
conflict with higher-priority sources, follow the higher source and document the
conflict.

## Operation Routing

Before meaningful file edits, classify the operation using
`OPERATION_ROUTING.md`. The classification must be durable for meaningful work
and must identify touched protected artifacts, dirty worktree state, required
validation, required review, traceability impact, registry impact, and
handoff/state impact.

Adaptive routing can reduce reading, writing, and repeated validation only when
the operation record proves limited impact. It cannot skip required
understanding, hide evidence, weaken review, or make chat history
authoritative.

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

- Adversarial review is performed in a fresh context, not by the implementer's
  conversation. A fresh-context reviewer (which may be the same agent
  re-entering with no implementer chat history, or a different agent) reports
  defects per `PR_REVIEW_POLICY.md`. AI may merge after objective gates pass
  per `PR_MERGE_POLICY.md`; human, maintainer, or Code Owner approval is not a
  required merge gate.
- High-risk changes require focused review by security, architecture, QA, and
  release roles. These reviews are also defect detection, not authorization.
- Reviewers use repository evidence, not implementer chat history.
- Required human/maintainer/Code Owner approval must not be reintroduced as a
  merge gate in active authoritative policy. The validator enforces this.

## Direct Main Documentation Exception

`BRANCH_AND_WORKTREE_GUIDE.md` defines the only direct-`main` exception. It is
limited to low-risk documentation edits that do not alter source-of-truth
meaning. Governance, specs, ADRs, backlog, templates, validation, hooks, roles,
security, release, dependency policy, registry, traceability, current state,
and handoff changes require a branch and normal review.

Agents must not use the direct-`main` exception for ambiguity, convenience, or
large documentation changes. When in doubt, use a branch.

## Required End-Of-Session Updates

Record one validation-evidence note per PR (in the PR body or review package).
Update TEST_RESULTS.md, TRACEABILITY_MATRIX.md, and ARTIFACT_REGISTRY.md only
when a durable baseline, requirement mapping, or artifact lifecycle changed -
at most once per PR, not per session.

State updates follow the split-state boundary:

- `.ai/SESSION.md` for local resume context when unmerged local work remains
- `CURRENT_STATE.md` and `AI_HANDOFF.md` only when durable project truth
  changed and should remain true on `main` after merge
