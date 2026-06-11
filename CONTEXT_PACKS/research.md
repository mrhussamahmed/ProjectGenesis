artifact_id: ART-CONTEXT-PACK-RESEARCH
title: Research Context Pack
type: context-pack
status: active
version: v1.0
created: 2026-06-11
updated: 2026-06-11
owner: AI Bootstrap Maintainers
source: BOOT-RESEARCH-001 research orchestration layer (GEN-18)
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Research Context Pack

## Files To Read First

- `memory/ai/SHARED_AGENT_RULES.md`
- `memory/ai/ROLE_RESEARCH_PLANNER.md`
- `CONTEXT_INDEX.md`
- `OPERATION_ROUTING.md`
- `COMMANDS/start-research.md`
- `00_intake/INTAKE_INDEX.md`
- `00_intake/SOURCE_REGISTRY.md`
- `01_context/PROJECT_BRIEF.md`
- `02_requirements/ASSUMPTIONS_REGISTER.md`
- `OPEN_QUESTIONS.md`
- non-placeholder files under `00_intake/raw/`

## Files To Read If Relevant

- the four research templates under `00_intake/research/`, at the step that
  instantiates them
- existing `RESEARCH_PLAN-*.md`, `RR-*.md`, `RCR-*.md`, and
  `RESEARCH_BRIEF-*.md` instances when resuming a run
- spawned-role files at their step: `memory/ai/ROLE_RESEARCHER.md`,
  `memory/ai/ROLE_RESEARCH_CRITIC.md`,
  `memory/ai/ROLE_RESEARCH_SYNTHESIZER.md`
- `02_requirements/RISK_REGISTER.md`
- `01_context/CONSTRAINTS.md`

## Files Not To Scan Unless Needed

- implementation source code
- specs, backlog items, and ADRs (research precedes them)
- archived artifacts

## Expected Outputs

- a research plan with depth decision, tracks, caps, and gate records
- one research report per executed track
- a critic review with findings and verdicts
- a draft or accepted research brief
- registered SRC- rows and assumption, risk, and open-question candidates

## Stop Conditions

- no input idea exists
- agent web research tools are unavailable
- the user rejects the research plan or the brief
- spawning caps would be exceeded

## Authority Limit

This pack cannot waive mandatory context from `CONTEXT_INDEX.md`,
`OPERATION_ROUTING.md`, shared agent rules, or selected role files. It
cannot accept a research brief without recorded explicit user approval, and
it cannot override approved or active specs, accepted ADRs,
`ARTIFACT_REGISTRY.md`, `TRACEABILITY_MATRIX.md`, `CURRENT_STATE.md`, or
`AI_HANDOFF.md`.
