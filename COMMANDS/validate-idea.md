artifact_id: ART-COMMAND-VALIDATE-IDEA
title: Validate The Idea
type: command
status: active
version: v1.0
created: 2026-06-10
updated: 2026-06-10
owner: AI Bootstrap Maintainers
source: GEN-11 research and validation capability
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Validate The Idea

## Purpose

Validate the riskiest parts of a product idea with evidence instead of
assertion. For each high-risk or scope-defining assumption, research it,
record a research note, register the note as a source, and upgrade or
downgrade the assumption with checkable approval evidence. Strengthens the
value proposition in `01_context/PROJECT_BRIEF.md` (problem, alternatives,
differentiation, pitch).

Recognized user triggers: `Validate the idea`, `Validate idea`,
`Run idea validation`.

## Required Role

- `memory/ai/ROLE_PRODUCT_ANALYST.md`

## Required Files To Read

- `memory/ai/SHARED_AGENT_RULES.md`
- `memory/ai/ROLE_PRODUCT_ANALYST.md`
- `CONTEXT_INDEX.md`
- `OPERATION_ROUTING.md`
- `01_context/PROJECT_BRIEF.md`
- `02_requirements/ASSUMPTIONS_REGISTER.md`
- `OPEN_QUESTIONS.md`
- `00_intake/SOURCE_REGISTRY.md`
- `00_intake/research/RESEARCH_NOTE_TEMPLATE.md`

## Inputs

- The user trigger, optionally naming specific assumptions or questions.
- High-risk or scope-defining rows in `02_requirements/ASSUMPTIONS_REGISTER.md`
  and `OPEN_QUESTIONS.md`.

## Workflow

1. Select only high-risk or scope-defining assumptions and open questions.
   Skip low-risk assumptions; validation must never block trivial intake.
2. For each selected assumption, research with available agent web tools.
   Cap research at 3 sources per assumption.
3. Write one research note per assumption in `00_intake/research/` from
   `00_intake/research/RESEARCH_NOTE_TEMPLATE.md` (claim, source URL, access
   date, supports/refutes, confidence, decision).
4. Register each note as a `research-note` source (SRC- ID) in
   `00_intake/SOURCE_REGISTRY.md`; URL evidence needs an access date.
5. Update the assumption row: confidence, status, and approval evidence
   citing `verified external` plus the SRC- ID. Record unresolved gaps in
   `OPEN_QUESTIONS.md`.
6. If no web tools are available, do not block: mark the assumption
   `needs-confirmation` with a `research-unavailable` note and continue.
7. Refresh the Value Proposition, Riskiest Assumptions, and Alternatives And
   Market Context sections of `01_context/PROJECT_BRIEF.md` from findings.

## Outputs

- Research notes under `00_intake/research/` with registered SRC- IDs.
- Updated assumption confidence, status, and approval evidence.
- Updated `01_context/PROJECT_BRIEF.md` validation sections.
- Gaps recorded as open questions; or recorded `research-unavailable` status.

## Stop Conditions

- No high-risk or scope-defining assumptions exist (report this; do not
  invent research work).
- The user asked to skip validation.
- Research findings conflict with explicit user statements; ask instead of
  overriding the user.
- An assumption needs approval authority this role does not have.

## Validation

- `bash SCRIPTS/validate-bootstrap.sh` (source registry and assumption
  evidence checks)
- `git diff --check`

## Authority Limit

This command is a workflow shortcut. It cannot approve the author's own
assumptions, cannot create implementation authority, and cannot override
repository governance, approved or active specs, accepted ADRs,
`CONTEXT_INDEX.md`, selected role files, `OPERATION_ROUTING.md`,
`ARTIFACT_REGISTRY.md`, `TRACEABILITY_MATRIX.md`, `CURRENT_STATE.md`, or
`AI_HANDOFF.md`.
