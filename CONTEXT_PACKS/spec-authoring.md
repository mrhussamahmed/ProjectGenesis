artifact_id: ART-CONTEXT-PACK-SPEC-AUTHORING
title: Spec Authoring Context Pack
type: context-pack
status: active
version: v1.2
created: 2026-05-13
updated: 2026-05-14
owner: AI Bootstrap Maintainers
source: SPEC-BOOT-002 and SPEC-BOOT-003
linked_specs: [SPEC-BOOT-002, SPEC-BOOT-003]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Spec Authoring Context Pack

## Files To Read First

- `memory/ai/SHARED_AGENT_RULES.md`
- `memory/ai/ROLE_SPEC_AUTHOR.md`
- `CONTEXT_INDEX.md`
- `OPERATION_ROUTING.md`
- `SPECS/SPEC_INDEX.md`
- `02_requirements/REQUIREMENTS_INDEX.md`
- `02_requirements/ASSUMPTIONS_REGISTER.md`
- `OPEN_QUESTIONS.md`
- `TRACEABILITY_MATRIX.md`

## Files To Read If Relevant

- relevant source summaries under `00_intake/summaries/`
- `01_context/PROJECT_BRIEF.md`
- `01_context/CONSTRAINTS.md`
- `ADR/ADR_INDEX.md`

## Files Not To Scan Unless Needed

- unrelated specs
- implementation source code
- archived artifacts

## Expected Outputs

- draft, proposed, approved, or active specs
- acceptance criteria
- source evidence links
- assumption and open-question links
- traceability updates

## Stop Conditions

- important requirements lack source evidence or approved assumptions
- architecture impact needs an ADR
- acceptance criteria are too weak to validate

## Authority Limit

This pack cannot approve specs without the readiness evidence required by
`GOVERNANCE.md` and `AI_PROJECT_BOOTSTRAP.md`. It cannot override
`CONTEXT_INDEX.md`, `OPERATION_ROUTING.md`, shared agent rules, selected role files, approved or active
specs, accepted ADRs, `ARTIFACT_REGISTRY.md`, `TRACEABILITY_MATRIX.md`,
`CURRENT_STATE.md`, or `AI_HANDOFF.md`.
