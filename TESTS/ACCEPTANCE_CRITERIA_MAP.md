artifact_id: ART-TEST-AC-MAP
title: Acceptance Criteria Map
type: traceability
status: active
version: v1.5
created: 2026-05-09
updated: 2026-05-14
owner: AI Bootstrap Maintainers
source: Initial bootstrap scaffold, SPEC-BOOT-002 activation, SPEC-BOOT-003 implementation, and BOOT-019 through BOOT-024 review
linked_specs: [SPEC-BOOT-002, SPEC-BOOT-003]
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
| SPEC-BOOT-003 | AGR-AC-001 | Validator and review | `SCRIPTS/validate-bootstrap.sh`; `REVIEWS/REVIEW-2026-05-14-adaptive-governance-implementation.md` | passed | `OPERATION_ROUTING.md` defines profile precedence and escalation targets. |
| SPEC-BOOT-003 | AGR-AC-002 | Handoff inspection and review | `AI_HANDOFF.md`; `REVIEWS/REVIEW-2026-05-14-adaptive-governance-implementation.md` | passed | BOOT-019 through BOOT-024 started with durable pre-change classification before substantive target edits. |
| SPEC-BOOT-003 | AGR-AC-003 | Handoff inspection and review | `AI_HANDOFF.md`; `TEST_RESULTS.md`; `REVIEWS/REVIEW-2026-05-14-adaptive-governance-implementation.md` | passed | BOOT-019 through BOOT-024 final evidence envelope is recorded in `AI_HANDOFF.md`; review approved with minor comments. |
| SPEC-BOOT-003 | AGR-AC-004 | Validator and review | `SCRIPTS/validate-bootstrap.sh`; `OPERATION_ROUTING.md` | passed | Protected artifact families and profile escalation are defined structurally. |
| SPEC-BOOT-003 | AGR-AC-005 | Review and git status evidence | `AI_HANDOFF.md`; `git status --short --branch` | passed | Dirty worktree blocking rule is recorded in operation routing and branch policy. |
| SPEC-BOOT-003 | AGR-AC-006 | Review | `OPERATION_ROUTING.md`; `REVIEWS/REVIEW-2026-05-14-adaptive-governance-implementation.md` | passed | Non-impact rules require concrete rationale in the evidence envelope. |
| SPEC-BOOT-003 | AGR-AC-007 | Review | `OPERATION_ROUTING.md`; `AI_HANDOFF.md`; `CURRENT_STATE.md` | passed | Current-state and handoff compression rules require durable section references. |
| SPEC-BOOT-003 | AGR-AC-008 | Review | `OPERATION_ROUTING.md`; `PR_REVIEW_POLICY.md` | passed | Claim evidence rules are defined with accepted evidence types. |
| SPEC-BOOT-003 | AGR-AC-009 | Red checks and CI | `SCRIPTS/validate-bootstrap-red-checks.sh`; `.github/workflows/bootstrap-validation.yml`; `TEST_RESULTS.md` | passed | Validator-rule changes require red-check and shell-syntax evidence, and CI runs red checks. |
| SPEC-BOOT-003 | AGR-AC-010 | Diff and review | `git diff --name-only`; `REVIEWS/REVIEW-2026-05-14-adaptive-governance-implementation.md` | passed | First slice remained policy-only; this follow-up slice implements the mechanics authorized by BOOT-019 through BOOT-024. |

## Rules

- Update this map when specs or tests change.
- Mark criteria unverified when no test exists.
- Do not claim a criterion is tested unless the test or checklist is listed.
