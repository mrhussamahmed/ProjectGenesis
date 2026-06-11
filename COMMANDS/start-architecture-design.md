artifact_id: ART-COMMAND-START-ARCHITECTURE-DESIGN
title: Start Architecture Design
type: command
status: active
version: v1.1
created: 2026-06-10
updated: 2026-06-11
owner: AI Bootstrap Maintainers
source: GEN-12 architecture path; BOOT-RESEARCH-001 research-brief consumption
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Start Architecture Design

## Purpose

Move the project from validated product intent to a concrete technical
architecture before implementation. Produces a filled solution design from
`SPECS/templates/TECH_DESIGN_TEMPLATE.md` plus slim ADRs for the decisions
that meet the trigger list in `DECISIONS.md` — nothing more.

Recognized user triggers: `Start architecture design`,
`Design the architecture`, `Run architecture design`.

## Required Role

- `memory/ai/ROLE_ARCHITECT.md`

## Required Files To Read

- `memory/ai/SHARED_AGENT_RULES.md`
- `memory/ai/ROLE_ARCHITECT.md`
- `CONTEXT_PACKS/architecture.md` (authoritative read list for this command)
- `01_context/PROJECT_BRIEF.md`
- `01_context/CONSTRAINTS.md`
- `02_requirements/REQUIREMENTS_INDEX.md`
- `SPECS/SPEC_INDEX.md` and relevant draft or approved specs
- `DECISIONS.md`
- `SPECS/templates/TECH_DESIGN_TEMPLATE.md`
- the accepted `00_intake/research/RESEARCH_BRIEF-*.md` (`status: accepted`),
  when one exists — especially its Technical Feasibility And Constraints and
  Regulatory And Compliance Constraints sections

## Inputs

- The user trigger, optionally naming the spec or scope to design for.
- Approved or draft specs, requirements, constraints, and assumptions.

## Workflow

1. Confirm requirements and constraints exist; if the project has not run
   intake, stop and request `Start requirement breakdown` first.
2. Fill `SPECS/templates/TECH_DESIGN_TEMPLATE.md` as
   `SPECS/TECH_DESIGN-<project-or-spec-id>.md`: context, stack decision,
   components, data model, API and integration contracts, scalability and
   operational readiness, security and observability hooks, failure modes.
3. Label every high-impact option with feasibility: known-tech, needs-spike,
   or unproven. Convert needs-spike items into spike backlog candidates.
   When an accepted research brief exists, feasibility labels must not
   contradict its evidence without recording the contradiction as an open
   question in `OPEN_QUESTIONS.md`.
4. For each decision matching the `DECISIONS.md` trigger list, write one slim
   ADR from `ADR/templates/ADR_TEMPLATE.md` (core sections only unless the
   change routes strict-protected) and register it in `ADR/ADR_INDEX.md`.
5. List remaining ADR candidates and open architecture questions in the tech
   design; do not silently decide them.

## Outputs

- `SPECS/TECH_DESIGN-<id>.md` (filled, evidence-linked).
- Slim ADRs in `ADR/` with index rows, only for trigger-list decisions.
- Architecture-blocking open questions recorded in `OPEN_QUESTIONS.md`.

## Stop Conditions

- Requirements or constraints are missing or contradictory; record the gap
  and stop.
- A decision requires user authority (cost, vendor, compliance commitments).
- Research is needed that the agent cannot perform; record a spike candidate.

## Validation

- `bash SCRIPTS/validate-bootstrap.sh`
- `git diff --check`

## Authority Limit

This command is a workflow shortcut. It cannot approve specs, cannot create
implementation authority, and cannot override repository governance, approved
or active specs, accepted ADRs, `CONTEXT_INDEX.md`, selected role files,
`OPERATION_ROUTING.md`, `ARTIFACT_REGISTRY.md`, `TRACEABILITY_MATRIX.md`,
`CURRENT_STATE.md`, or `AI_HANDOFF.md`.
