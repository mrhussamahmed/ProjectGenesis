artifact_id: ART-TEMPLATE-RESEARCH-PLAN
title: Research Plan Template
type: template
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

# Research Plan: Topic

Instances are written by `memory/ai/ROLE_RESEARCH_PLANNER.md` via
`COMMANDS/start-research.md`. Copy this file to
`00_intake/research/RESEARCH_PLAN-NNN.md` (NNN = next run number from
existing plan files). Instances must carry full artifact frontmatter and must
not contain placeholder tokens; record open items as gaps or open questions
instead.

- Plan ID: RESEARCH_PLAN-000
- Date:
- Registered inputs (SRC- IDs):
- Requested by / trigger phrase:

## Depth Decision

| Criterion | Rating (low, medium, high) | Basis |
|-----------|----------------------------|-------|
| Novelty of the idea |  |  |
| Regulatory exposure |  |  |
| Data sensitivity |  |  |
| Monetary risk |  |  |
| Integration complexity |  |  |
| Competitive density |  |  |

- Resulting depth: quick | standard | deep (any high rating on regulatory
  exposure, data sensitivity, or monetary risk forces deep; all low permits
  quick; otherwise standard)
- User override: none | quoted user instruction

## Selected Tracks

Every selected track lists at least two research questions.

| Track | Rationale | Research Questions | Min/Max Sources | Status |
|-------|-----------|--------------------|-----------------|--------|
|  |  |  |  | pending |

Allowed track status values: pending, running, reported, revised, accepted,
rejected.

## Excluded Tracks

| Track | Why Not Selected |
|-------|------------------|
|  |  |

## Caps

- Initial researcher invocations (= selected tracks, max 9):
- Revision invocations (max = min(3, tracks with P0/P1 critic findings)):
- Critic invocations (1; 2 for deep):
- Synthesizer invocations (1):

## Gates

| Gate | Requirement | Status | Evidence |
|------|-------------|--------|----------|
| G1 plan approval | per depth model in `COMMANDS/start-research.md` |  |  |
| G2 brief acceptance | explicit user approval recorded in the brief |  |  |
