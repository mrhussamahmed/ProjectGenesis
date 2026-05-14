artifact_id: ART-EXAMPLE-SIMPLE-SAAS-BACKLOG
title: Freelancer Invoice App Backlog Candidates
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

# Backlog Candidates

This is illustrative expected output, not a claim of live generated output.

| ID | Title | Purpose | Source | Readiness | Validation Expectation |
|----|-------|---------|--------|-----------|------------------------|
| EX-BL-001 | Define MVP invoice model | Decide fields for invoice number, client, due date, amount, status, and notes. | EX-REQ-001, EX-Q-001 | discovery | Product-owner review of required fields. |
| EX-BL-002 | Define simple expense model | Decide fields for expense date, category, amount, description, and receipt handling. | EX-REQ-002, EX-Q-003 | discovery | Product-owner review of required fields. |
| EX-BL-003 | Draft invoice tracking spec | Specify invoice CRUD, states, overdue calculation, and acceptance criteria. | EX-REQ-001, EX-REQ-003 | blocked by EX-BL-001 | Spec review and acceptance criteria mapping. |
| EX-BL-004 | Draft expense tracking spec | Specify expense entry, list, edit, delete, and summaries. | EX-REQ-002 | blocked by EX-BL-002 | Spec review and acceptance criteria mapping. |
| EX-BL-005 | Draft late payment dashboard spec | Define dashboard metrics and overdue invoice views. | EX-REQ-003, EX-REQ-005 | blocked by EX-BL-003 | Manual validation checklist for overdue states. |
| EX-BL-006 | Explore AI reminder concepts | Clarify whether AI means draft copy, timing suggestions, or automated sending. | EX-REQ-006, EX-Q-004 | deferred discovery | Safety, privacy, and user-control review before any implementation. |

## Initial Scope Candidates

- `EX-BL-001`
- `EX-BL-002`
- `EX-BL-003`
- `EX-BL-004`
- `EX-BL-005`

## Deferred Candidate

- `EX-BL-006` remains deferred until the AI reminder requirement is confirmed
  and governed by a specific spec.
