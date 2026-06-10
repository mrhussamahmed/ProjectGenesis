artifact_id: ART-EXAMPLE-SIMPLE-SAAS-ADR
title: Freelancer Invoice App ADR Exemplar
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

# ADR-001: Single Mainstream Web Stack For The Invoice MVP

This is illustrative expected output, not a claim of live generated output.
It follows the 35-line core of `ADR/templates/ADR_TEMPLATE.md`; a real
project saves this under `ADR/` and registers it in `ADR/ADR_INDEX.md`.

## Context
One developer must ship invoice, expense, and late-payment tracking
(EX-REQ-001..003) with no integrations. Stack choice gates every backlog
item, so it must be decided before EX-BL-003.

## Options
- Option A: one mainstream full-stack web framework plus a relational
  database - fastest path, fewest moving parts, boring and well-documented.
- Option B: separate SPA frontend and API service - more flexibility later,
  but two deployables and more operational surface for the same MVP.

## Decision
Option A. Covers the MVP CRUD-and-dashboard scope; does not cover future
multi-service needs - revisit if AI reminders (EX-BL-006) become real.

## Consequences
- Benefits: one deployable, one schema, simplest rollback story.
- Tradeoffs and required follow-up: a later service split would need a
  migration ADR; frontend interactivity is bounded by the framework.

## Links
- Spec / backlog item: EX-BL-003 (`backlog-candidates.md`)
- Requirement: EX-REQ-001, EX-REQ-002, EX-REQ-003 (`requirements.md`)
