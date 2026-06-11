artifact_id: ART-CONTEXT-PACK-PRODUCT-INTAKE
title: Product Intake Context Pack
type: context-pack
status: active
version: v2.1
created: 2026-05-13
updated: 2026-06-11
owner: AI Bootstrap Maintainers
source: SPEC-BOOT-002, SPEC-BOOT-003, GEN-01 tiered read contract, and BOOT-RESEARCH-001 research-brief consumption
linked_specs: [SPEC-BOOT-002, SPEC-BOOT-003]
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
- `01_context/PROJECT_BRIEF.md`
- `02_requirements/REQUIREMENTS_INDEX.md`
- `02_requirements/ASSUMPTIONS_REGISTER.md`
- `OPEN_QUESTIONS.md`
- `CURRENT_STATE.md`
- non-placeholder files under `00_intake/raw/`

## Files To Read If Relevant

- the accepted `00_intake/research/RESEARCH_BRIEF-*.md`
  (`status: accepted`), when one exists — evidence-backed input for product
  context and requirements
- research notes under `00_intake/research/`, when validating assumptions
- existing summaries under `00_intake/summaries/`
- `02_requirements/RISK_REGISTER.md`
- `01_context/PROJECT_CHARTER.md`, `01_context/GLOSSARY.md`,
  `01_context/CONSTRAINTS.md`
- templates named by the workflow step that needs them

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

This pack cannot waive mandatory context from `CONTEXT_INDEX.md`,
`OPERATION_ROUTING.md`, shared agent rules, or selected role files. It cannot override approved or active specs,
accepted ADRs, `ARTIFACT_REGISTRY.md`, `TRACEABILITY_MATRIX.md`,
`CURRENT_STATE.md`, or `AI_HANDOFF.md`.
