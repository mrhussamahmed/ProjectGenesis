artifact_id: ART-EXAMPLE-SIMPLE-SAAS-VALIDATION
title: Freelancer Invoice App Validation Checklist
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

# Validation Checklist

This is illustrative expected output, not a claim of live generated output.

## Intake Validation

- Confirm the raw source is registered as `EX-SRC-001`.
- Confirm every requirement links to `EX-SRC-001`, an inference, or an
  assumption.
- Confirm inferred items are not treated as approved requirements.
- Confirm AI reminder work is marked deferred.

## Product Review

- Confirm target user: freelancer.
- Confirm initial workflows: invoices, expenses, late payments.
- Confirm deferred workflows: AI reminders and automated sending.
- Resolve country, currency, tax, payment, and email-sending questions before
  spec approval.

## Readiness Checks

- No implementation starts from this example alone.
- Draft specs are created only after open questions are resolved or scoped out.
- Risks around compliance, email sending, and AI behavior remain visible.
- Backlog candidates remain candidates until linked to specs or approved
  discovery tasks.

## Repository Validation

For ProjectGenesis itself, run:

```sh
bash SCRIPTS/validate-bootstrap.sh
```

## Validation-Evidence Note Exemplar

The one-note-per-PR validation evidence record (per `OPERATION_ROUTING.md`
and `GOVERNANCE.md` End-Of-Session) for an intake PR like this example
would read:

```text
Operation profile: planning-governance
Validation run: bash SCRIPTS/validate-bootstrap.sh (passed, covers final diff)
Validation skipped: none
Review required: fresh-context adversarial review before spec activation
```
