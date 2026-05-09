artifact_id: ART-TRACE-001
title: Traceability Matrix
type: traceability
status: authoritative
version: v1.2
created: 2026-05-09
updated: 2026-05-09
owner: AI Bootstrap Maintainers
source: User request and initial scaffold
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Traceability Matrix

Traceability maps requirements to specs, backlog items, ADRs, architecture,
implementation branches, changed files, tests, review records, release status,
and current status.

## Bootstrap Requirements

Bootstrap baseline requirements use `BOOT-001` as the governing backlog item
instead of a product spec. Product implementation must not use this exception.

| Product Requirement | Spec ID | Backlog Item | Linear Ticket | ADR | Architecture Doc | Implementation Branch | Changed Files | Tests | Review Record | Release Status | Current Status |
|---------------------|---------|--------------|---------------|-----|------------------|-----------------------|---------------|-------|---------------|----------------|----------------|
| REQ-BOOT-001: Spec-driven development | none | BOOT-001 | none | none | `ARCHITECTURE.md` | none | `AI_PROJECT_BOOTSTRAP.md`, `GOVERNANCE.md`, `SPECS/templates/SPEC_TEMPLATE.md` | `SCRIPTS/validate-bootstrap.sh` existence checks | pending | not released | initialized |
| REQ-BOOT-002: Test-driven development | none | BOOT-001 | none | none | `ARCHITECTURE.md` | none | `TEST_STRATEGY.md`, `TEST_PLAN.md`, `TESTS/ACCEPTANCE_CRITERIA_MAP.md` | validator plus future stack tests | pending | not released | initialized |
| REQ-BOOT-003: Artifact lifecycle control | none | BOOT-001 | none | none | `ARCHITECTURE.md` | none | `ARTIFACT_REGISTRY.md`, `GOVERNANCE.md` | metadata checks with documented `AGENTS.md` and `CLAUDE.md` exception | pending | not released | initialized |
| REQ-BOOT-004: Branch and worktree hygiene | none | BOOT-001 | none | none | `ARCHITECTURE.md` | none | `BRANCH_AND_WORKTREE_GUIDE.md`, `.githooks/` | hook templates and validator | pending | not released | initialized |
| REQ-BOOT-005: Anti-hallucination and source-of-truth rules | none | BOOT-001 | none | none | `ARCHITECTURE.md` | none | `AI_PROJECT_BOOTSTRAP.md`, `GOVERNANCE.md`, `CONTEXT_INDEX.md` | validator required files | pending | not released | initialized |
| REQ-BOOT-006: Autonomous backlog creation | none | BOOT-001 | none | none | `ARCHITECTURE.md` | none | `BACKLOG.md`, `BACKLOG/templates/BACKLOG_ITEM_TEMPLATE.md` | validator required files | pending | not released | initialized |
| REQ-BOOT-007: Architecture decision tracking | none | BOOT-001 | none | none | `ARCHITECTURE.md` | none | `DECISIONS.md`, `ADR/ADR_INDEX.md`, `ADR/templates/ADR_TEMPLATE.md` | validator required files | pending | not released | initialized |
| REQ-BOOT-008: Shared AI handoff | none | BOOT-001 | none | none | `ARCHITECTURE.md` | none | `AI_HANDOFF.md`, `HANDOFFS/HANDOFF_INDEX.md` | handoff section checks | pending | not released | initialized |
| REQ-BOOT-009: Production-readiness checks | none | BOOT-001 | none | none | `ARCHITECTURE.md` | none | `RELEASE_READINESS.md`, `CI_CD_GUIDE.md`, `SECURITY_AND_PRIVACY.md`, `OBSERVABILITY.md` | validator required files | pending | not released | initialized |
| REQ-BOOT-010: Fresh adversarial PR review | none | BOOT-001 | none | none | `ARCHITECTURE.md` | none | `PR_REVIEW_POLICY.md`, `PR_MERGE_POLICY.md`, `AI_REVIEW_PROMPTS.md`, `REVIEWS/` | validator required files | pending | not released | initialized |
| REQ-BOOT-011: Risk-based model and effort selection | none | BOOT-001 | none | none | `ARCHITECTURE.md` | none | `RISK_MODEL.md` | validator required files | pending | not released | initialized |
| REQ-BOOT-012: Safe parallel AI execution | none | BOOT-001 | none | none | `ARCHITECTURE.md` | none | `PARALLEL_EXECUTION_PLAN.md` | validator required files | pending | not released | initialized |
| REQ-BOOT-013: Shared AI role system for Claude, Codex, and other agents | none | BOOT-001 | none | none | `ARCHITECTURE.md` | none | `memory/ai/SHARED_AGENT_RULES.md`, `memory/ai/ROLE_PRODUCT_ANALYST.md`, `memory/ai/ROLE_SPEC_AUTHOR.md`, `memory/ai/ROLE_ARCHITECT.md`, `memory/ai/ROLE_BACKLOG_PLANNER.md`, `memory/ai/ROLE_IMPLEMENTATION_AGENT.md`, `memory/ai/ROLE_QA_REVIEWER.md`, `memory/ai/ROLE_SECURITY_REVIEWER.md`, `memory/ai/ROLE_DEVOPS_RELEASE_REVIEWER.md`, `memory/ai/ROLE_DOCUMENTATION_CURATOR.md`, `memory/ai/ROLE_ADVERSARIAL_PR_REVIEWER.md`, `memory/ai/ROLE_DIAGRAM_ARCHITECT.md`, `CLAUDE.md`, `AGENTS.md`, `SCRIPTS/start-claude.sh`, `CONTEXT_INDEX.md`, `BOOTSTRAP_USAGE.md`, `AI_PROJECT_BOOTSTRAP.md`, `SCRIPTS/validate-bootstrap.sh`, `REVIEWS/PR_REVIEW_PACKAGE-2026-05-09-shared-role-system.md`, `REVIEWS/REVIEW_INDEX.md` | `bash SCRIPTS/validate-bootstrap.sh`; `bash -n SCRIPTS/start-claude.sh`; `bash -n SCRIPTS/validate-bootstrap.sh` | `REVIEWS/PR_REVIEW_PACKAGE-2026-05-09-shared-role-system.md`; `REVIEWS/REVIEW-2026-05-09-shared-role-system.md` | not released | ready for re-review |

## Rules

- Update this matrix whenever specs, backlog items, tickets, code, tests,
  architecture, or reviews change.
- Do not claim traceability exists unless the mapping is here.
- Mark requirements as unimplemented or unverified when evidence is missing.
- Mark implementation without linked spec as orphaned and create a cleanup task.
