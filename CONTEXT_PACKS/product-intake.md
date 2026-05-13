artifact_id: ART-CONTEXT-PACK-PRODUCT-INTAKE
title: Product Intake Context Pack
type: context-pack
status: active
version: v1.1
created: 2026-05-13
updated: 2026-05-13
owner: AI Bootstrap Maintainers
source: SPEC-BOOT-002
linked_specs: [SPEC-BOOT-002]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Product Intake Context Pack

## Files To Read First

- `memory/ai/SHARED_AGENT_RULES.md`
- `memory/ai/ROLE_PRODUCT_ANALYST.md`
- `CONTEXT_INDEX.md`
- `00_intake/INTAKE_INDEX.md`
- `00_intake/SOURCE_REGISTRY.md`
- `OPEN_QUESTIONS.md`
- `PROJECT_MEMORY.md`

## Files To Read If Relevant

- files under `00_intake/raw/`
- files under `INPUT/`
- `01_context/PROJECT_BRIEF.md`
- `02_requirements/REQUIREMENTS_INDEX.md`

## Files Not To Scan Unless Needed

- implementation source code
- generated artifacts
- archived artifacts

## Expected Outputs

- registered sources
- source summaries
- product context updates
- requirement candidates
- assumptions, risks, and open questions

## Stop Conditions

- source conflict changes project scope
- missing facts change security, architecture, data model, release safety, or
  implementation priority
- sensitive input needs handling guidance

## Authority Limit

This pack cannot waive mandatory context from `CONTEXT_INDEX.md`, shared agent
rules, or selected role files. It cannot override approved or active specs,
accepted ADRs, `ARTIFACT_REGISTRY.md`, `TRACEABILITY_MATRIX.md`,
`CURRENT_STATE.md`, or `AI_HANDOFF.md`.
