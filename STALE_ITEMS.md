artifact_id: ART-STATE-005
title: Stale Items
type: shared-state
status: active
version: v1.2
created: 2026-05-09
updated: 2026-05-13
owner: AI Bootstrap Maintainers
source: Initial bootstrap scaffold, final adversarial review, and stale status fix
linked_specs: [SPEC-BOOT-002]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Stale Items

This file tracks stale documents, stale code areas, obsolete generated
artifacts, abandoned branches, outdated specs, outdated diagrams, outdated
backlog items, and files that need review before reuse.

## Current Stale Items

- No current stale items.

## Stale Item Log

| ID | Item | Type | Why Stale Or Suspicious | Current Source Of Truth | Required Action | Owner | Status |
|----|------|------|-------------------------|-------------------------|-----------------|-------|--------|
| STALE-2026-05-13-001 | `SPECS/SPEC_INDEX.md` `SPEC-BOOT-002` current-status cell | spec-index status drift | It said final review findings were "under correction" while `CURRENT_STATE.md`, `AI_HANDOFF.md`, and `REVIEWS/REVIEW-2026-05-13-scaffold-intake-governance-implementation.md` said P1/P2 findings were addressed. | `SPECS/SPEC_INDEX.md`; `CURRENT_STATE.md`; `AI_HANDOFF.md`; `REVIEWS/REVIEW-2026-05-13-scaffold-intake-governance-implementation.md`; `REVIEWS/REVIEW-2026-05-13-scaffold-intake-governance-final-adversarial.md` | Updated `SPECS/SPEC_INDEX.md` to match the final review state; validation passed and narrow re-review approved the correction. | AI Bootstrap Maintainers | resolved |

## Rules

- Do not use stale, superseded, deprecated, archived, or cancelled artifacts as
  current truth.
- If an old file conflicts with a current spec, architecture, ADR, or handoff,
  record the conflict here or in `OPEN_QUESTIONS.md`.
- If code appears abandoned or inconsistent with current specs, do not build on
  it blindly.
- Resolve drift by updating specs, architecture, ADRs, tests, backlog,
  traceability, and artifact registry together.
