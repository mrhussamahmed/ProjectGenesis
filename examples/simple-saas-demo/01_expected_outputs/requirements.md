artifact_id: ART-EXAMPLE-SIMPLE-SAAS-REQS
title: Freelancer Invoice App Requirements
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

# Requirements

This is illustrative expected output, not a claim of live generated output.

| ID | Requirement | Status | Confidence | Source Or Basis | Scope |
|----|-------------|--------|------------|-----------------|-------|
| EX-REQ-001 | Freelancers can create, view, edit, and mark invoices by payment state. | confirmed | high | `EX-SRC-001` | initial |
| EX-REQ-002 | Freelancers can record expenses. | confirmed | high | `EX-SRC-001` | initial |
| EX-REQ-003 | Freelancers can identify late payments. | confirmed | high | `EX-SRC-001` | initial |
| EX-REQ-004 | The product should be usable as a SaaS app with user accounts. | inferred | medium | SaaS wording in `EX-SRC-001` | initial candidate |
| EX-REQ-005 | Users should see a summary of unpaid and overdue invoices. | inferred | medium | Late payment tracking need in `EX-SRC-001` | initial candidate |
| EX-REQ-006 | AI reminders should be explored later, not included in the initial build. | inferred | high | "Maybe add AI reminders later" in `EX-SRC-001` | deferred |

## Not Yet Requirements

- Automated email sending.
- AI-generated reminder copy.
- Payment processing.
- Accounting system sync.
- Tax calculation.
- Multi-user team workspaces.

These may become requirements only after source evidence, approved assumptions,
or product-owner approval exists.
