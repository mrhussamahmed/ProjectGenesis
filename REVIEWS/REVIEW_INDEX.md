artifact_id: ART-REVIEW-INDEX
title: Review Index
type: review-index
status: active
version: v1.1
created: 2026-05-09
updated: 2026-05-09
owner: AI Bootstrap Maintainers
source: Initial bootstrap scaffold
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Review Index

Review records and review packages live in this folder.

## Reviews

| Review ID | PR Or Branch | Decision | Risk | Reviewer | Date | File | Status |
|-----------|--------------|----------|------|----------|------|------|--------|
| REVIEW-2026-05-09-bootstrap-baseline | bootstrap baseline | request changes, addressed | medium | user adversarial review | 2026-05-09 | `REVIEWS/REVIEW-2026-05-09-bootstrap-baseline.md` | addressed |
| REVIEW-2026-05-09-shared-role-system | shared role system update | request changes | medium | Codex adversarial review | 2026-05-09 | `REVIEWS/REVIEW-2026-05-09-shared-role-system.md` | ready for re-review |

## Review Packages

| Package ID | PR Or Branch | Purpose | File | Status |
|------------|--------------|---------|------|--------|
| PR-PACKAGE-2026-05-09-shared-role-system | shared role system update | Durable review package for shared `memory/ai/` role system change | `REVIEWS/PR_REVIEW_PACKAGE-2026-05-09-shared-role-system.md` | active |

## Rules

- Every PR needs a review package and fresh-context adversarial review.
- Review findings use P0, P1, P2, and P3.
- Update this index after review.
