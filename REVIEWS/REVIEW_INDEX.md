artifact_id: ART-REVIEW-INDEX
title: Review Index
type: review-index
status: active
version: v2.3
created: 2026-05-09
updated: 2026-05-13
owner: AI Bootstrap Maintainers
source: Initial bootstrap scaffold, final adversarial review, narrow re-review, start requirement breakdown plan review, public repository publication request, README positioning/tooling prerequisite update, and BOOT-017 review
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
| REVIEW-2026-05-13-scaffold-improvement-plan | scaffold improvement plan | request changes | high | Codex adversarial review | 2026-05-13 | `REVIEWS/REVIEW-2026-05-13-scaffold-improvement-plan.md` | active |
| REVIEW-2026-05-13-spec-boot-002-v0.2 | SPEC-BOOT-002 v0.2 | request changes | high | independent reviewers | 2026-05-13 | `REVIEWS/REVIEW-2026-05-13-spec-boot-002-v0.2.md` | addressed in SPEC-BOOT-002 v0.4 |
| REVIEW-2026-05-13-spec-boot-002-v0.4 | SPEC-BOOT-002 v0.4 | approve with minor comments | high | independent reviewer | 2026-05-13 | `REVIEWS/REVIEW-2026-05-13-spec-boot-002-v0.4.md` | addressed; spec activated |
| REVIEW-2026-05-13-scaffold-intake-governance-implementation | SPEC-BOOT-002 implementation | approve with minor comments | high | independent reviewer | 2026-05-13 | `REVIEWS/REVIEW-2026-05-13-scaffold-intake-governance-implementation.md` | active; P1/P2 findings addressed |
| REVIEW-2026-05-13-scaffold-intake-governance-final-adversarial | SPEC-BOOT-002 final adversarial review | request changes, addressed | high | Codex adversarial review plus narrow re-review | 2026-05-13 | `REVIEWS/REVIEW-2026-05-13-scaffold-intake-governance-final-adversarial.md` | addressed; narrow re-review found no remaining P0/P1/P2 findings |
| REVIEW-2026-05-13-start-requirement-breakdown-plan | start requirement breakdown command plan | request changes, addressed | medium | independent reviewer | 2026-05-13 | `REVIEWS/REVIEW-2026-05-13-start-requirement-breakdown-plan.md` | addressed |
| REVIEW-2026-05-13-projectgenesis-publication | ProjectGenesis public repository publication | approve | medium | scoped independent reviewer plus local repository-grounded review | 2026-05-13 | `REVIEWS/REVIEW-2026-05-13-projectgenesis-publication.md` | active |
| REVIEW-2026-05-13-readme-tooling-prereqs | README positioning and tooling prerequisites | request changes, addressed; narrow re-review approved | medium | independent fresh-context reviewer | 2026-05-13 | `REVIEWS/REVIEW-2026-05-13-readme-tooling-prereqs.md` | active |

## Review Packages

| Package ID | PR Or Branch | Purpose | File | Status |
|------------|--------------|---------|------|--------|
| PR-PACKAGE-2026-05-09-shared-role-system | shared role system update | Durable review package for shared `memory/ai/` role system change | `REVIEWS/PR_REVIEW_PACKAGE-2026-05-09-shared-role-system.md` | active |
| PR-PACKAGE-2026-05-13-scaffold-intake-governance | scaffold intake and governance implementation | Review package for `SPEC-BOOT-002` implementation | `REVIEWS/PR_REVIEW_PACKAGE-2026-05-13-scaffold-intake-governance.md` | active |
| PR-PACKAGE-2026-05-13-projectgenesis-publication | ProjectGenesis public repository publication | Review package for public README, AGPLv3 license, GitHub Code Owners, branch protection guidance, and publication PR | `REVIEWS/PR_REVIEW_PACKAGE-2026-05-13-projectgenesis-publication.md` | active |
| PR-PACKAGE-2026-05-13-readme-tooling-prereqs | README positioning and tooling prerequisites | Review package for public positioning, capability explanation, Linear backlog storage, Linear setup, optional Spec Kit use, and supported tooling README updates | `REVIEWS/PR_REVIEW_PACKAGE-2026-05-13-readme-tooling-prereqs.md` | active |

## Rules

- Every PR needs a review package and fresh-context adversarial review.
- Review findings use P0, P1, P2, and P3.
- Update this index after review.
