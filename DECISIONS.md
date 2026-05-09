artifact_id: ART-ADR-001
title: Decision Governance
type: adr-guide
status: authoritative
version: v1.0
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

# Decision Governance

ADRs live under `ADR/`. This file defines when and how to create them.

## When An ADR Is Required

Create or update an ADR before implementation when work affects:

- technology choices
- architecture boundaries
- persistence model
- API contracts
- security model
- deployment model
- external integrations
- production dependencies
- data migrations
- irreversible or expensive-to-change tradeoffs

## ADR States

- draft
- proposed
- accepted
- superseded
- rejected
- deprecated

Implementation that depends on a decision should wait for `accepted` status or
record explicit provisional risk.

## ADR Rules

- Use `ADR/templates/ADR_TEMPLATE.md`.
- Register every ADR in `ADR/ADR_INDEX.md`.
- Link ADRs to specs, backlog items, tickets, architecture files, and tests.
- If an ADR is superseded, add a visible banner to the old ADR and update the
  registry and traceability matrix.
- If an ADR is rejected, keep it for historical context and record why.

## Decision Quality Bar

Every ADR must state:

- context and decision pressure
- options considered
- selected decision
- consequences and tradeoffs
- risks and mitigations
- validation evidence
- rollback or recovery path
- linked specs and backlog items
- owner and date

