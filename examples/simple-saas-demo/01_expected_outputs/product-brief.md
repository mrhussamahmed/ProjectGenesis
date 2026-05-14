artifact_id: ART-EXAMPLE-SIMPLE-SAAS-BRIEF
title: Freelancer Invoice App Product Brief
type: example-output
status: active
version: v1.0
created: 2026-05-14
updated: 2026-05-14
owner: ProjectGenesis Maintainers
source: Public launch readiness and adoption packaging task
linked_specs: [SPEC-BOOT-004]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Product Brief

This is illustrative expected output, not a claim of live generated output.

## Source

- `EX-SRC-001`: raw one-sentence product idea in
  `00_raw_input/freelancer-invoice-app.md`

## Product Summary

A SaaS app for freelancers to track invoices, expenses, and late payments.

## Fact Labels

| Item | Label | Evidence |
|------|-------|----------|
| The product is a SaaS app. | confirmed | `EX-SRC-001` says "SaaS app". |
| The target user is freelancers. | confirmed | `EX-SRC-001` says "freelancers". |
| Invoice tracking is in scope. | confirmed | `EX-SRC-001` says "track invoices". |
| Expense tracking is in scope. | confirmed | `EX-SRC-001` says "expenses". |
| Late payment tracking is in scope. | confirmed | `EX-SRC-001` says "late payments". |
| AI reminders may be useful later. | inferred | `EX-SRC-001` says "Maybe add AI reminders later." |
| Payment collection, tax filing, accounting sync, and banking integrations are not confirmed. | assumption | No source evidence yet. |

## Initial Scope

- Create and track invoices.
- Track expenses.
- Identify invoices that are late.
- Provide a simple freelancer-focused dashboard.

## Deferred Scope

- AI reminder drafting or sending.
- Automated collections workflows.
- Accounting, tax, bank, and payment-provider integrations.

## Risks

- Invoicing rules may vary by country, tax model, and client contract.
- Payment reminder behavior can affect client relationships.
- Any future AI reminder feature needs tone, consent, privacy, and accuracy
  rules before implementation.
