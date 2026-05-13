artifact_id: ART-TEST-AC-MAP
title: Acceptance Criteria Map
type: traceability
status: active
version: v1.3
created: 2026-05-09
updated: 2026-05-13
owner: AI Bootstrap Maintainers
source: Initial bootstrap scaffold and SPEC-BOOT-002 activation
linked_specs: [SPEC-BOOT-002]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Acceptance Criteria Map

Map acceptance criteria to automated and manual tests.

| Spec | Acceptance Criteria | Test Type | Test File Or Checklist | Status | Notes |
|------|---------------------|-----------|------------------------|--------|-------|
| SPEC-BOOT-002 | SBG-AC-001 | Review | `REVIEWS/REVIEW-2026-05-13-spec-boot-002-v0.4.md` | passed | Fresh reviewer confirmed implementation is based on the spec, not chat text. |
| SPEC-BOOT-002 | SBG-AC-002 | Validator and manual review | `SCRIPTS/validate-bootstrap.sh`; `REVIEWS/REVIEW-2026-05-13-scaffold-intake-governance-implementation.md` | passed | Canonical intake path and legacy alias are implemented. |
| SPEC-BOOT-002 | SBG-AC-003 | Validator and manual review | `SCRIPTS/validate-bootstrap.sh`; `SCRIPTS/validate-bootstrap-red-checks.sh`; `REVIEWS/REVIEW-2026-05-13-scaffold-intake-governance-implementation.md` | passed | Source registry structure, freshness, and processing-state validation are implemented. |
| SPEC-BOOT-002 | SBG-AC-004 | Validator and manual review | `SCRIPTS/validate-bootstrap.sh`; `REVIEWS/REVIEW-2026-05-13-scaffold-intake-governance-implementation.md` | passed | Summary directory and registry workflow are implemented; no downstream source files exist yet. |
| SPEC-BOOT-002 | SBG-AC-005 | Manual review | `REVIEWS/REVIEW-2026-05-13-scaffold-intake-governance-implementation.md` | passed | Product context artifacts require confirmed, inferred, or assumption labeling. |
| SPEC-BOOT-002 | SBG-AC-006 | Validator and review | `SCRIPTS/validate-bootstrap.sh`; `SCRIPTS/validate-bootstrap-red-checks.sh`; `REVIEWS/REVIEW-2026-05-13-scaffold-intake-governance-implementation.md` | passed | Evidence-aware templates and column-aware validator checks are implemented. |
| SPEC-BOOT-002 | SBG-AC-007 | Review gate | `REVIEWS/REVIEW-2026-05-13-scaffold-intake-governance-implementation.md` | passed | High-risk assumption blocking is defined in the active spec and assumptions register. |
| SPEC-BOOT-002 | SBG-AC-008 | Validator | `SCRIPTS/validate-bootstrap.sh`; `SCRIPTS/validate-bootstrap-red-checks.sh` | passed | Command framework section validation is implemented. |
| SPEC-BOOT-002 | SBG-AC-009 | Validator and review | `SCRIPTS/validate-bootstrap.sh`; `REVIEWS/REVIEW-2026-05-13-scaffold-intake-governance-implementation.md` | passed | Context-pack authority sections are implemented and validated. |
| SPEC-BOOT-002 | SBG-AC-010 | Review gate | `REVIEWS/REVIEW-2026-05-13-scaffold-intake-governance-implementation.md` | passed | Direct-main exception is implemented in workflow policy docs. |
| SPEC-BOOT-002 | SBG-AC-011 | Test results | `SCRIPTS/validate-bootstrap-red-checks.sh` | passed | Red-check helper fails malformed temporary fixtures and passes when validator catches them. |
| SPEC-BOOT-002 | SBG-AC-012 | Manual review and registry check | `REVIEWS/REVIEW-2026-05-13-scaffold-intake-governance-implementation.md` | passed | RTF content migrated to Markdown and legacy RTF files registered as archived. |
| SPEC-BOOT-002 | SBG-AC-013 | Validator and review | `SCRIPTS/validate-bootstrap.sh`; `SCRIPTS/validate-bootstrap-red-checks.sh`; `REVIEWS/REVIEW-2026-05-13-scaffold-intake-governance-implementation.md` | passed | Assumption expiry and allowed approval evidence checks are implemented. |
| SPEC-BOOT-002 | SBG-AC-014 | Review gate | `REVIEWS/REVIEW-2026-05-13-scaffold-intake-governance-implementation.md` | passed | Ticket evidence guidance is implemented in backlog workflow. |

## Rules

- Update this map when specs or tests change.
- Mark criteria unverified when no test exists.
- Do not claim a criterion is tested unless the test or checklist is listed.
