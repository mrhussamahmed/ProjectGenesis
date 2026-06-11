artifact_id: ART-EXAMPLE-SIMPLE-SAAS-TECH-DESIGN
title: Freelancer Invoice App Tech Design Exemplar
type: example-output
status: active
version: v1.0
created: 2026-06-11
updated: 2026-06-11
owner: ProjectGenesis Maintainers
source: GEN-17 golden-path example alignment (HUS-235)
linked_specs: [SPEC-BOOT-004]
linked_tickets: [HUS-235]
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# TECH_DESIGN-invoice-tracker: Solution Design

This is illustrative expected output, not a claim of live generated output.
It follows `SPECS/templates/TECH_DESIGN_TEMPLATE.md`; a real project saves
this as `SPECS/TECH_DESIGN-<project>.md`.

## Context And Constraints

Let one freelancer track invoices, expenses, and late payments (EX-REQ-001,
EX-REQ-002, EX-REQ-003). Binding constraints: single-account MVP
(EX-ASM-001), manual entry only (EX-ASM-002), no payment processing
(EX-Q-005 unresolved).

## Stack Decision Summary

Illustrative single-stack choice: one mainstream web framework with a
relational database and managed hosting - smallest operable footprint for a
single-developer MVP. The stack decision itself is the first ADR candidate
below; this example deliberately names no concrete vendor.

## Component Map

- Web UI - invoice/expense forms and dashboard - talks to API layer.
- API layer - CRUD plus overdue calculation - talks to database.
- Database - invoices, expenses, account settings - owned by API layer.

## Data Model Sketch

- Invoice: number, client, amount, due date, status (draft/sent/paid),
  notes; owned by the account; overdue derives from due date + unpaid state.
- Expense: date, category, amount, description; owned by the account.

## API And Integration Contracts

- CRUD endpoints for invoices and expenses (REST verbs over `/invoices`,
  `/expenses`); list endpoints accept status filters.
- No external integrations in the MVP (EX-ASM-002); reminder email sending
  is out of scope until EX-Q-002 resolves.

## Scalability And Operational Readiness

Single-tenant-per-account CRUD load; one app instance plus managed database
scales past the MVP horizon. Deploy: managed platform deploy from main.
Rollback: redeploy previous release; schema changes are additive-only.

## Security And Privacy Hooks

Hits the auth and personal-data triggers in `SECURITY_AND_PRIVACY.md`:
account authentication required for every route; client names and amounts
are personal business data - no third-party sharing in MVP.

## Observability Hooks

Request logs with status codes; error-rate alert on the API layer; daily
count of overdue-calculation runs proving the dashboard's critical path.

## Failure Modes

- Database unavailable: app unusable, blast radius one account set;
  detection via health check; recovery via managed-database restore.
- Overdue calculation drift: wrong dashboard states; detection via spot
  checks against due dates; recovery is recompute on read.

## ADR Candidates

| Decision | Trigger (per DECISIONS.md) | Status |
|----------|----------------------------|--------|
| Application stack and hosting choice | new external dependency | proposed (see `adr-001-stack-choice.md`) |
| Overdue derivation vs stored status | data-model ownership | open |

## Implementation Phases

1. Invoice model + CRUD (EX-BL-001, EX-BL-003).
2. Expense model + CRUD (EX-BL-002, EX-BL-004).
3. Late-payment dashboard (EX-BL-005).
