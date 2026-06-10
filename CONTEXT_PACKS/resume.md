artifact_id: ART-CONTEXT-PACK-RESUME
title: Resume Context Pack
type: context-pack
status: active
version: v2.0
created: 2026-05-13
updated: 2026-06-10
owner: AI Bootstrap Maintainers
source: SPEC-BOOT-002, SPEC-BOOT-003, and GEN-01 single read contract
linked_specs: [SPEC-BOOT-002, SPEC-BOOT-003]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Resume Context Pack

## Files To Read First

- `.ai/SESSION.md`, when present: the first resume read for local unmerged work
- the Resume section of `CONTEXT_INDEX.md`, which enumerates the remaining
  resume reads (minimum context plus the artifacts named in the handoff's next
  recommended action)

## Files To Read If Relevant

- relevant specs
- relevant ADRs
- relevant backlog items
- `STALE_ITEMS.md`
- `OPEN_QUESTIONS.md`
- `WORKLOG/WORKLOG_INDEX.md` and `TEST_RESULTS.md`, when reconstructing stale
  state

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
