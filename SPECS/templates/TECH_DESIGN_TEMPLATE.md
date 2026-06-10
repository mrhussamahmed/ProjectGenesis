artifact_id:
title:
type: tech-design
status: draft
version: v0.1
created:
updated:
owner:
source:
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# TECH_DESIGN-<project>: Solution Design

Save as `SPECS/TECH_DESIGN-<project>.md`. One page; link, do not restate.

## Context And Constraints

Goal in one sentence; binding constraints from `01_context/CONSTRAINTS.md`
and the requirement IDs this design serves.

## Stack Decision Summary

Chosen language, framework, persistence, hosting; one line each with the
decisive reason. ADR-worthy choices go to the ADR Candidates table below.

## Component Map

List each component: name - responsibility - talks to. Diagram optional.

## Data Model Sketch

Core entities, key fields, and relationships; note ownership and lifecycle.

## API And Integration Contracts

Endpoints/events (verb, path, payload shape); integrations and their failure assumptions.

## Scalability And Operational Readiness

Expected load, scaling unit, and the first bottleneck; deploy and rollback
path in one line each.

## Security And Privacy Hooks

Which `SECURITY_AND_PRIVACY.md` mandatory review triggers does this design
hit? List each hit and its handling; do not restate the checklist.

## Observability Hooks

Logs, metrics, and alerts this design must emit per `OBSERVABILITY.md`
expectations; name the signal proving each critical path healthy.

## Failure Modes

Top failure modes: what breaks, blast radius, detection, recovery.

## ADR Candidates

| Decision | Trigger (per DECISIONS.md) | Status |
|----------|----------------------------|--------|
|  |  |  |

## Implementation Phases

Ordered, independently shippable slices; each maps to backlog items.
