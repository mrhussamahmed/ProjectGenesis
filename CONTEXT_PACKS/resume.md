artifact_id: ART-CONTEXT-PACK-RESUME
title: Resume Context Pack
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

# Resume Context Pack

## Files To Read First

- `memory/ai/SHARED_AGENT_RULES.md`
- selected role file
- `CONTEXT_INDEX.md`
- `OPERATION_ROUTING.md`
- `CURRENT_STATE.md`
- `AI_HANDOFF.md`
- `ARTIFACT_REGISTRY.md`
- `TRACEABILITY_MATRIX.md`
- `WORKLOG/WORKLOG_INDEX.md`
- `TEST_RESULTS.md`

## Files To Read If Relevant

- relevant specs
- relevant ADRs
- relevant backlog items
- `STALE_ITEMS.md`
- `OPEN_QUESTIONS.md`

## Files Not To Scan Unless Needed

- raw intake files unrelated to current task
- archived artifacts
- generated artifacts

## Expected Outputs

- reconstructed current state when stale
- updated handoff
- stale items or open questions
- next safe action

## Stop Conditions

- branch or worktree state conflicts with handoff
- dirty worktree has unexplained changes
- source-of-truth files conflict and require user or role decision

## Authority Limit

This pack helps resume safely but cannot override the source-of-truth hierarchy
or selected role requirements, including `CONTEXT_INDEX.md`,
`OPERATION_ROUTING.md`, shared agent
rules, selected role files, approved or active specs, accepted ADRs,
`ARTIFACT_REGISTRY.md`, `TRACEABILITY_MATRIX.md`, `CURRENT_STATE.md`, and
`AI_HANDOFF.md`.
