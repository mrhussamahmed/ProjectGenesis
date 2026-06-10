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

This table uses the canonical `02_requirements/ASSUMPTIONS_REGISTER.md`
schema. Status `proposed` reflects that no approval evidence exists yet;
agents must not approve their own assumptions.

| Assumption ID | Statement | Risk | Owner | Status | Expiry | Approval Evidence | Linked Requirement | Linked Spec | Notes |
|---------------|-----------|------|-------|--------|--------|-------------------|--------------------|-------------|-------|
| EX-ASM-001 | The first version can focus on a single freelancer account. | medium | product owner | proposed | before spec approval | none | EX-REQ-004 | none | Team and agency workflows are not in the source. |
| EX-ASM-002 | Manual invoice and expense entry is acceptable for the first version. | medium | product owner | proposed | before spec approval | none | EX-REQ-001, EX-REQ-002 | none | Imports and integrations are not in the source. |
| EX-ASM-003 | Late payment status can be calculated from due date and paid state. | medium | product owner | proposed | before implementation | none | EX-REQ-003 | none | Needs product approval and edge-case review. |

## Open Questions

| ID | Question | Blocks | Why It Matters |
|----|----------|--------|----------------|
| EX-Q-001 | Which countries, currencies, and tax formats must the first version support? | spec approval | Invoice fields and compliance expectations vary. |
| EX-Q-002 | Should the app send emails, or only track reminders manually? | implementation | Sending email creates deliverability, consent, and abuse concerns. |
| EX-Q-003 | What expense fields are required for the first version? | spec approval | Receipt files, categories, taxes, and reimbursements affect data model. |
| EX-Q-004 | What does "AI reminders later" mean: draft text, suggested timing, or automated sending? | AI reminder scope | AI behavior requires safety, privacy, and review criteria. |
| EX-Q-005 | Is payment processing in scope? | architecture | Payment providers create security, privacy, and operational obligations. |

## Risks

This table uses the canonical `02_requirements/RISK_REGISTER.md` schema.

| Risk ID | Risk | Category | Severity | Source IDs | Owner | Mitigation | Status | Linked Specs |
|---------|------|----------|----------|------------|-------|------------|--------|--------------|
| EX-RISK-001 | Building AI reminders too early could add unclear safety and privacy requirements. | product | medium | EX-SRC-001 | product owner | Defer AI reminders until requirements are confirmed. | open | none |
| EX-RISK-002 | Invoice compliance assumptions may be wrong for target markets. | product | high | EX-SRC-001 | product owner | Confirm geography and invoice fields before implementation. | open | none |
| EX-RISK-003 | Expense tracking can expand into accounting scope. | delivery | medium | EX-SRC-001 | product owner | Keep first version to simple records unless sources require more. | open | none |
