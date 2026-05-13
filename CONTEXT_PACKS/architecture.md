artifact_id: ART-CONTEXT-PACK-ARCHITECTURE
title: Architecture Context Pack
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

# Architecture Context Pack

## Files To Read First

- `memory/ai/SHARED_AGENT_RULES.md`
- `memory/ai/ROLE_ARCHITECT.md`
- `CONTEXT_INDEX.md`
- `OPERATION_ROUTING.md`
- `ARCHITECTURE.md`
- `DECISIONS.md`
- `ADR/ADR_INDEX.md`
- relevant specs
- `RISK_MODEL.md`

## Files To Read If Relevant

- `01_context/CONSTRAINTS.md`
- `02_requirements/RISK_REGISTER.md`
- `SECURITY_AND_PRIVACY.md`
- `OBSERVABILITY.md`

## Files Not To Scan Unless Needed

- unrelated implementation files
- archived decisions
- generated artifacts

## Expected Outputs

- architecture updates
- ADRs for high-impact decisions
- risks and open questions
- traceability updates

## Stop Conditions

- irreversible or high-impact decision lacks alternatives
- security, privacy, deployment, API, persistence, data, or dependency impact is
  unclear
- specs do not authorize the architecture change

## Authority Limit

This pack cannot create architecture authority without approved or active specs,
accepted ADRs, or explicit governance authorization. It cannot override
`CONTEXT_INDEX.md`, `OPERATION_ROUTING.md`, shared agent rules, selected role files,
`ARTIFACT_REGISTRY.md`, `TRACEABILITY_MATRIX.md`, `CURRENT_STATE.md`, or
`AI_HANDOFF.md`.
