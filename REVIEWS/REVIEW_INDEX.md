artifact_id: ART-REVIEW-INDEX
title: Review Index
type: review-index
status: active
version: v4.3
created: 2026-05-09
updated: 2026-05-17
owner: AI Bootstrap Maintainers
source: ProjectGenesis bootstrap scaffold; slice 3 required-reading shrink (full prior history preserved at MAINTAINER_ARCHIVE/snapshots/REVIEW_INDEX-2026-05-16-pre-slice-3.md); BOOT-GREEN-MERGE-001
linked_specs: []
linked_tickets: [BOOT-GREEN-MERGE-001]
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Review Index

This index lists reviews kept under `REVIEWS/`. Use
`REVIEWS/templates/PR_REVIEW_PACKAGE_TEMPLATE.md` and
`REVIEWS/templates/ADVERSARIAL_PR_REVIEW_TEMPLATE.md` for new review records.

ProjectGenesis legacy `PR_REVIEW_PACKAGE-*` and `REVIEW-*` records are
archived under `MAINTAINER_ARCHIVE/REVIEWS/`.

## Reviews

| Review ID | Date | Subject | File | Outcome | Reviewer | Notes |
|-----------|------|---------|------|---------|----------|-------|
| REVIEW-SPLIT-STATE-HANDOFF-PLAN-2026-05-17 | 2026-05-17 | Split-state handoff boundary plan | `REVIEWS/REVIEW-2026-05-17-split-state-handoff-plan.md` | approve with minor comments | Codex | Latest re-review approves the plan; implementation must begin with Task 0 and Path B is unavailable until `PR_MERGE_POLICY.md` permits it. |
| REVIEW-SPLIT-STATE-HANDOFF-IMPLEMENTATION-2026-05-17 | 2026-05-17 | Split-state handoff boundary implementation | `REVIEWS/REVIEW-2026-05-17-split-state-handoff-implementation.md` | approve with minor comments | Codex | Implementation review approved; merge still required explicit Path B maintainer approval or Path A, plus PR CI. Subsequently merged via PR #21. |
| REVIEW-AI-GREEN-MERGE-IMPLEMENTATION-2026-05-18 | 2026-05-18 | AI green-merge for bootstrap scaffold usability implementation | `REVIEWS/REVIEW-2026-05-18-ai-green-merge-scaffold-usability-implementation.md` | no blocking findings (defect detection) | Codex | Fresh-context Codex adversarial review for BOOT-GREEN-MERGE-001 across 6 iterations; final outcome no blocking findings (P0/P1/blocking P2 = 0). AI may merge per `PR_MERGE_POLICY.md` once required CI passes. |

## Conventions

- Review depth follows the operation profile per `PR_REVIEW_POLICY.md`:
  light self-checks live in the PR body; fresh-context adversarial reviews
  for planning-governance and strict-protected changes are registered here.
- Register every review record here.
- Link reviews to specs, backlog items, tickets, and traceability rows.
