artifact_id: ART-STATE-005
title: Stale Items
type: shared-state
status: active
version: v1.3
created: 2026-05-09
updated: 2026-05-13
owner: AI Bootstrap Maintainers
source: Initial bootstrap scaffold, final adversarial review, stale status fix, and Phase 1 closeout coherence verification
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
| STALE-2026-05-16-001 | Phase 1 closeout active state across `CURRENT_STATE.md`, `AI_HANDOFF.md`, `IMPLEMENTATION_PLAN.md`, and `BACKLOG/BOOT-033-src-spec-cross-validation.md` | state and planning drift | After PR #10 merge, the top BOOT-033 current-state entry said Phase 1 was complete, but active branch/worktree, active backlog focus, blockers, implementation-plan readiness language, and BOOT-033 review checkbox still described BOOT-033 or Phase 1 as in flight. | PR #10 merge commit `a9c5b5954198fce9391f7c278889f29487a09c84`; follow-up `main` commit `bdc8b19e94564a4a50db8a06f5b06d75e67e2c7c`; GitHub Actions run `25952622901` succeeded on `bdc8b19`; `BACKLOG.md` and `BACKLOG/BACKLOG_INDEX.md` show BOOT-030 through BOOT-033 done. | Updated current state, handoff, implementation plan, BOOT-033 backlog item, registry, traceability, test results, and worklog; added BOOT-034 proposed follow-up for the stale next-action pattern. | AI Bootstrap Maintainers | resolved |
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
