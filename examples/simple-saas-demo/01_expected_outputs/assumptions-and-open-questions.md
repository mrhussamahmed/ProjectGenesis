artifact_id: ART-EXAMPLE-SIMPLE-SAAS-ASSUMPTIONS
title: Freelancer Invoice App Assumptions And Open Questions
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

# Assumptions And Open Questions

This is illustrative expected output, not a claim of live generated output.

## Assumptions

| ID | Assumption | Confidence | Expiry | Related Requirement | Notes |
|----|------------|------------|--------|---------------------|-------|
| EX-ASM-001 | The first version can focus on a single freelancer account. | medium | Before spec approval | EX-REQ-004 | Team and agency workflows are not in the source. |
| EX-ASM-002 | Manual invoice and expense entry is acceptable for the first version. | medium | Before spec approval | EX-REQ-001, EX-REQ-002 | Imports and integrations are not in the source. |
| EX-ASM-003 | Late payment status can be calculated from due date and paid state. | medium | Before implementation | EX-REQ-003 | Needs product approval and edge-case review. |

## Open Questions

| ID | Question | Blocks | Why It Matters |
|----|----------|--------|----------------|
| EX-Q-001 | Which countries, currencies, and tax formats must the first version support? | spec approval | Invoice fields and compliance expectations vary. |
| EX-Q-002 | Should the app send emails, or only track reminders manually? | implementation | Sending email creates deliverability, consent, and abuse concerns. |
| EX-Q-003 | What expense fields are required for the first version? | spec approval | Receipt files, categories, taxes, and reimbursements affect data model. |
| EX-Q-004 | What does "AI reminders later" mean: draft text, suggested timing, or automated sending? | AI reminder scope | AI behavior requires safety, privacy, and review criteria. |
| EX-Q-005 | Is payment processing in scope? | architecture | Payment providers create security, privacy, and operational obligations. |

## Risks

| ID | Risk | Severity | Mitigation |
|----|------|----------|------------|
| EX-RISK-001 | Building AI reminders too early could add unclear safety and privacy requirements. | medium | Defer AI reminders until requirements are confirmed. |
| EX-RISK-002 | Invoice compliance assumptions may be wrong for target markets. | high | Confirm geography and invoice fields before implementation. |
| EX-RISK-003 | Expense tracking can expand into accounting scope. | medium | Keep first version to simple records unless sources require more. |
