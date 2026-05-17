artifact_id: ART-TRACE-001
title: Traceability Matrix
type: traceability
status: authoritative
version: v4.2
created: 2026-05-09
updated: 2026-05-17
owner: AI Bootstrap Maintainers
source: ProjectGenesis bootstrap scaffold; slice 3 required-reading shrink (full prior history preserved at MAINTAINER_ARCHIVE/snapshots/TRACEABILITY_MATRIX.md-2026-05-16-pre-slice-3.md)
linked_specs: []
linked_tickets: [BOOT-STATE-001]
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Traceability Matrix

The traceability matrix links requirements to specs, backlog items, ADRs,
implementation, tests, and reviews.

The bootstrap upstream's legacy traceability rows are preserved in the
slice 3 pre-trim snapshot under
`MAINTAINER_ARCHIVE/snapshots/TRACEABILITY_MATRIX.md-2026-05-16-pre-slice-3.md`.

## Rows

| Trace ID | Requirement | Spec | Backlog Item | ADR | Implementation | Test | Review | Status | Notes |
|----------|-------------|------|--------------|-----|----------------|------|--------|--------|-------|
| TRACE-SPLIT-STATE-HANDOFF-PLAN-001 | Split canonical state, PR state, and local session state without recreating merge drift | none; recurring bootstrap-governance exception in `PR_MERGE_POLICY.md` | `BACKLOG/BOOT-STATE-001-split-state-handoff.md` | none | `.gitignore`; `AGENTS.md`; `CLAUDE.md`; `BRANCH_AND_WORKTREE_GUIDE.md`; `memory/ai/SHARED_AGENT_RULES.md`; `memory/ai/ROLE_*.md`; `SCRIPTS/operation-profile.sh`; `SCRIPTS/validate-bootstrap.sh`; `SCRIPTS/validate-bootstrap-red-checks.sh`; `REVIEWS/templates/PR_REVIEW_PACKAGE_TEMPLATE.md`; `REVIEWS/templates/ADVERSARIAL_PR_REVIEW_TEMPLATE.md`; `AI_HANDOFF.md`; `CURRENT_STATE.md` | `git check-ignore .ai/SESSION.md`; `bash SCRIPTS/validate-bootstrap.sh`; `bash SCRIPTS/validate-bootstrap-red-checks.sh`; shell syntax loop; `git diff --check` | `REVIEWS/REVIEW-2026-05-17-split-state-handoff-plan.md`; `REVIEWS/PR_REVIEW_PACKAGE-split-state-handoff.md`; `REVIEWS/REVIEW-2026-05-17-split-state-handoff-implementation.md` | in-progress | Local implementation checks pass and implementation review is approved with minor comments. CI and explicit merge authority remain pending before merge. |

## Conventions

- Add a row whenever a spec, backlog item, ADR, implementation, test, or
  review is created or changed.
- Status values: proposed, in-progress, implemented, verified, released,
  superseded.
- Keep rows concise. Detailed evidence lives in the linked artifacts.
