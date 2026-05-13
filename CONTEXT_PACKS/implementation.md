artifact_id: ART-CONTEXT-PACK-IMPLEMENTATION
title: Implementation Context Pack
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

# Implementation Context Pack

## Files To Read First

- `memory/ai/SHARED_AGENT_RULES.md`
- `memory/ai/ROLE_IMPLEMENTATION_AGENT.md`
- `CONTEXT_INDEX.md`
- `OPERATION_ROUTING.md`
- `CURRENT_STATE.md`
- `AI_HANDOFF.md`
- relevant active spec
- relevant backlog item
- `TEST_PLAN.md`
- `TRACEABILITY_MATRIX.md`

## Files To Read If Relevant

- relevant ADRs
- `BRANCH_AND_WORKTREE_GUIDE.md`
- `PARALLEL_EXECUTION_PLAN.md`
- touched source files and tests

## Files Not To Scan Unless Needed

- unrelated specs
- unrelated backlog items
- archived artifacts

## Expected Outputs

- scoped code or documentation changes
- tests before or alongside implementation where practical
- test results
- traceability and handoff updates
- review package when PR-ready

## Stop Conditions

- Definition of Ready is not satisfied
- relevant spec is not approved or active
- tests cannot be identified
- required changes cross protected ownership boundaries

## Authority Limit

This pack cannot authorize implementation from draft, proposed, or missing
specs except explicitly recorded spike work. It cannot override
`CONTEXT_INDEX.md`, `OPERATION_ROUTING.md`, shared agent rules, selected role files, accepted ADRs,
`ARTIFACT_REGISTRY.md`, `TRACEABILITY_MATRIX.md`, `CURRENT_STATE.md`, or
`AI_HANDOFF.md`.
