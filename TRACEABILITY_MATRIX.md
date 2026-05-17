artifact_id: ART-TRACE-001
title: Traceability Matrix
type: traceability
status: authoritative
version: v4.3
created: 2026-05-09
updated: 2026-05-17
owner: AI Bootstrap Maintainers
source: ProjectGenesis bootstrap scaffold; slice 3 required-reading shrink (full prior history preserved at MAINTAINER_ARCHIVE/snapshots/TRACEABILITY_MATRIX.md-2026-05-16-pre-slice-3.md); BOOT-GREEN-MERGE-001
linked_specs: []
linked_tickets: [BOOT-STATE-001, BOOT-GREEN-MERGE-001]
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
| TRACE-SPLIT-STATE-HANDOFF-PLAN-001 | Split canonical state, PR state, and local session state without recreating merge drift | none; recurring bootstrap-governance exception in `PR_MERGE_POLICY.md` | `BACKLOG/BOOT-STATE-001-split-state-handoff.md` | none | `.gitignore`; `AGENTS.md`; `CLAUDE.md`; `BRANCH_AND_WORKTREE_GUIDE.md`; `memory/ai/SHARED_AGENT_RULES.md`; `memory/ai/ROLE_*.md`; `SCRIPTS/operation-profile.sh`; `SCRIPTS/validate-bootstrap.sh`; `SCRIPTS/validate-bootstrap-red-checks.sh`; `REVIEWS/templates/PR_REVIEW_PACKAGE_TEMPLATE.md`; `REVIEWS/templates/ADVERSARIAL_PR_REVIEW_TEMPLATE.md`; `AI_HANDOFF.md`; `CURRENT_STATE.md` | `git check-ignore .ai/SESSION.md`; `bash SCRIPTS/validate-bootstrap.sh`; `bash SCRIPTS/validate-bootstrap-red-checks.sh`; shell syntax loop; `git diff --check`; PR #21 CI runs 26001652968 and 26001653803 | `REVIEWS/REVIEW-2026-05-17-split-state-handoff-plan.md`; `REVIEWS/PR_REVIEW_PACKAGE-split-state-handoff.md`; `REVIEWS/REVIEW-2026-05-17-split-state-handoff-implementation.md`; PR #21 comment 4472356122 | verified | Split-state handoff merged through PR #21 (commit `d4b5161`). |
| TRACE-AI-GREEN-MERGE-001 | Remove low-value ceremony and human-approval merge gates while preserving objective safety gates (CI, validation, blocker resolution, clean scope) so the bootstrap scaffold is usable for new projects | none; recurring bootstrap-governance exception in `PR_MERGE_POLICY.md` | `BACKLOG/BOOT-GREEN-MERGE-001-ai-green-merge-scaffold-usability.md` | none | `PR_MERGE_POLICY.md`; `PR_REVIEW_POLICY.md`; `GOVERNANCE.md`; `GITHUB_REPOSITORY_SETUP.md`; `.github/CODEOWNERS`; `memory/ai/ROLE_IMPLEMENTATION_AGENT.md`; `memory/ai/ROLE_ADVERSARIAL_PR_REVIEWER.md`; `SCRIPTS/validate-bootstrap.sh`; `SCRIPTS/validate-bootstrap-red-checks.sh`; GitHub branch protection for `main` | `bash SCRIPTS/validate-bootstrap.sh`; `bash SCRIPTS/validate-bootstrap-red-checks.sh`; `bash -n SCRIPTS/validate-bootstrap.sh`; `bash -n SCRIPTS/validate-bootstrap-red-checks.sh`; `git diff --check`; `rg` policy scan; `gh api repos/mrhussamahmed/ProjectGenesis/branches/main/protection`; PR CI `Bootstrap Validation` | `REVIEWS/REVIEW-2026-05-17-ai-green-merge-scaffold-usability-implementation.md` (Codex fresh-context adversarial review) | in-progress | Removes human/maintainer/Code Owner approval as merge gates; AI may merge after objective gates pass; validator regression guard prevents reintroduction. |

## Conventions

- Add a row whenever a spec, backlog item, ADR, implementation, test, or
  review is created or changed.
- Status values: proposed, in-progress, implemented, verified, released,
  superseded.
- Keep rows concise. Detailed evidence lives in the linked artifacts.
