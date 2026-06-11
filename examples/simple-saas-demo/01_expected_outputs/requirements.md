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

This table uses the canonical `02_requirements/REQUIREMENTS_INDEX.md` schema
so intake output can be pasted into a real project without reshaping.

| Requirement ID | Statement | Type | Priority | Source IDs | Confidence | Status | Linked Specs | Linked Backlog | Notes |
|----------------|-----------|------|----------|------------|------------|--------|--------------|----------------|-------|
| EX-REQ-001 | Freelancers can create, view, edit, and mark invoices by payment state. | functional | P1 | EX-SRC-001 | high | confirmed | none | EX-BL-001, EX-BL-003 | Initial scope. |
| EX-REQ-002 | Freelancers can record expenses. | functional | P1 | EX-SRC-001 | high | confirmed | none | EX-BL-002, EX-BL-004 | Initial scope. |
| EX-REQ-003 | Freelancers can identify late payments. | functional | P1 | EX-SRC-001 | high | confirmed | none | EX-BL-005 | Initial scope. |
| EX-REQ-004 | The product should be usable as a SaaS app with user accounts. | non-functional | P2 | EX-SRC-001 | medium | inferred | none | none | Inferred from SaaS wording; initial candidate. |
| EX-REQ-005 | Users should see a summary of unpaid and overdue invoices. | functional | P2 | EX-SRC-001 | medium | inferred | none | EX-BL-005 | Inferred from late-payment tracking need; initial candidate. |
| EX-REQ-006 | AI reminders should be explored later, not included in the initial build. | functional | P3 | EX-SRC-001 | high | inferred | none | EX-BL-006 | Deferred; from "Maybe add AI reminders later". |

## Not Yet Requirements

- Automated email sending.
- AI-generated reminder copy.
- Payment processing.
- Accounting system sync.
- Tax calculation.
- Multi-user team workspaces.

These may become requirements only after source evidence, approved assumptions,
or product-owner approval exists.
