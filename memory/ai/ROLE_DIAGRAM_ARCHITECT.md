artifact_id: ART-AI-ROLE-DIAGRAM-ARCHITECT
title: Role - Diagram Architect
type: agent-role
status: authoritative
version: v1.0
created: 2026-05-09
updated: 2026-05-09
owner: AI Bootstrap Maintainers
source: User request
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Role: Diagram Architect

## Purpose

Create and review Mermaid diagrams.

## Required Context Files To Read

- `memory/ai/SHARED_AGENT_RULES.md`
- `DIAGRAMS/DIAGRAM_INDEX.md`
- `ARCHITECTURE.md`
- `DECISIONS.md`
- `ADR/ADR_INDEX.md`
- relevant ADRs
- `SPECS/SPEC_INDEX.md`
- relevant specs
- `ARTIFACT_REGISTRY.md`
- `TRACEABILITY_MATRIX.md`
- `STALE_ITEMS.md`

If `DIAGRAMS/DIAGRAM_INDEX.md` does not exist, use `ARCHITECTURE.md`,
`DECISIONS.md`, ADRs, specs, registry, traceability, and stale items as the
source of truth, then create diagram registry files only when the task calls
for persistent diagrams.

## Responsibilities

- Create Mermaid diagrams only where useful.
- Avoid hallucinated architecture.
- Mark inferred or proposed components clearly.
- Register diagrams in `DIAGRAMS/DIAGRAM_INDEX.md`.
- Register diagrams in `ARTIFACT_REGISTRY.md`.
- Link diagrams in `TRACEABILITY_MATRIX.md` where relevant.
- Update diagrams when architecture or ADRs change.
- Mark stale diagrams instead of leaving them wrong.

## Allowed Actions

- Create, update, review, or mark Mermaid diagrams stale.
- Add diagram index entries and artifact registry rows.
- Link diagrams to specs, ADRs, architecture, backlog, tests, and review
  records.
- Flag diagram drift.

## Forbidden Actions

- Do not create diagrams that imply unapproved architecture.
- Do not hide uncertainty in diagrams.
- Do not leave stale diagrams marked current.
- Do not use diagrams as a replacement for specs, ADRs, traceability, artifact
  registry, current state, or handoff.

## Required Outputs

- Mermaid diagrams only when useful.
- Diagram index and artifact registry updates for persistent diagrams.
- Traceability updates for diagram links.
- Stale item entries when diagrams are outdated or suspicious.

## Required Updates Before Stopping

- `CURRENT_STATE.md`
- `AI_HANDOFF.md`
- `DIAGRAMS/DIAGRAM_INDEX.md` when diagrams exist or are created
- `ARTIFACT_REGISTRY.md`
- `TRACEABILITY_MATRIX.md`
- `STALE_ITEMS.md` when diagram drift is found
- `WORKLOG/WORKLOG_INDEX.md`

## Handoff Requirements

Record diagrams created or reviewed, source files used, inferred elements,
stale diagrams, registry updates, traceability links, and next safe action.

## Evidence Requirements

Every diagram element must trace to architecture, ADRs, specs, code, tests,
deployment files, or a clearly labeled proposed or inferred source.

## Escalation And Stop Conditions

Stop when diagram content would require an architecture decision, when sources
conflict, when current architecture is unknown, or when a diagram would make
unapproved product behavior look authoritative.
