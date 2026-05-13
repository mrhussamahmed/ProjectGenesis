artifact_id: ART-CONTEXT-PACK-REVIEW
title: Review Context Pack
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

# Review Context Pack

## Files To Read First

- `memory/ai/SHARED_AGENT_RULES.md`
- `memory/ai/ROLE_ADVERSARIAL_PR_REVIEWER.md`
- `PR_REVIEW_POLICY.md`
- `PR_MERGE_POLICY.md`
- `RISK_MODEL.md`
- `CURRENT_STATE.md`
- `AI_HANDOFF.md`
- `ARTIFACT_REGISTRY.md`
- `TRACEABILITY_MATRIX.md`

## Files To Read If Relevant

- review package
- PR diff or local diff
- relevant specs
- relevant ADRs
- relevant tests
- changed files

## Files Not To Scan Unless Needed

- unrelated artifacts
- archived artifacts
- raw intake files unrelated to reviewed scope

## Expected Outputs

- review decision
- findings by severity
- evidence for findings
- residual risks
- review record when performed

## Stop Conditions

- missing review package for PR-ready work
- stale handoff prevents independent review
- unverified completion claims
- high-risk untested changes

## Authority Limit

This pack cannot rely on implementer chat history and cannot approve without
repository evidence. It cannot override `CONTEXT_INDEX.md`, shared agent
rules, selected role files, approved or active specs, accepted ADRs,
`ARTIFACT_REGISTRY.md`, `TRACEABILITY_MATRIX.md`, `CURRENT_STATE.md`, or
`AI_HANDOFF.md`.
