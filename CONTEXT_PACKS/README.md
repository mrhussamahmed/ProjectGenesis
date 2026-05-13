artifact_id: ART-CONTEXT-PACKS-README
title: Context Packs Guide
type: context-pack-index
status: active
version: v1.0
created: 2026-05-13
updated: 2026-05-13
owner: AI Bootstrap Maintainers
source: SPEC-BOOT-002
linked_specs: [SPEC-BOOT-002]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Context Packs

Context packs reduce repeated reading for common tasks. They are routing aids,
not source-of-truth governance.

## Available Packs

| Pack | Purpose |
|------|---------|
| `product-intake.md` | Read source material and extract product context. |
| `spec-authoring.md` | Create or revise specs from controlled requirements. |
| `architecture.md` | Prepare architecture updates and ADRs. |
| `implementation.md` | Implement ready backlog items. |
| `review.md` | Run fresh-context adversarial review. |
| `resume.md` | Reconstruct state after time or context loss. |

## Authority Limit

Context packs are subordinate to `CONTEXT_INDEX.md`,
`memory/ai/SHARED_AGENT_RULES.md`, selected role files, approved or active
specs, accepted ADRs, `ARTIFACT_REGISTRY.md`, `TRACEABILITY_MATRIX.md`,
`CURRENT_STATE.md`, and `AI_HANDOFF.md`.
