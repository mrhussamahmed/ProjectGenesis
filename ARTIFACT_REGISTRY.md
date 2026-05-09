artifact_id: ART-REG-001
title: Artifact Registry
type: registry
status: authoritative
version: v1.2
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

# Artifact Registry

The registry identifies current, authoritative, active, draft, generated,
temporary, superseded, deprecated, cancelled, and archived artifacts. Do not
use superseded, deprecated, cancelled, or archived artifacts as current truth.

Common fields for all entries below unless stated otherwise:

- created: 2026-05-09
- updated: 2026-05-09
- created by: Codex
- owner: AI Bootstrap Maintainers
- linked tickets: none
- replaces: none
- replaced by: none

## Current Authoritative Artifacts

| Artifact ID | Type | Title | File Path | Status | Version | Source Input | Linked Specs | Linked ADRs | Authoritative | Notes |
|-------------|------|-------|-----------|--------|---------|--------------|--------------|-------------|---------------|-------|
| ART-AGENT-CLAUDE | agent-instructions | Claude Instructions | `CLAUDE.md` | authoritative | v1.2 | scaffold, shared role update, review fix | none | none | true | Short Claude entrypoint; shared role files in `memory/ai/` are the behavior source of truth. |
| ART-AGENT-GENERIC | agent-instructions | Codex And Generic Agent Instructions | `AGENTS.md` | authoritative | v1.1 | scaffold, shared role update | none | none | true | Short Codex and generic agent entrypoint; shared role files in `memory/ai/` are the behavior source of truth. |
| ART-AI-SHARED-RULES | agent-rules | Shared Agent Rules | `memory/ai/SHARED_AGENT_RULES.md` | authoritative | v1.1 | user request, review fix | none | none | true | Shared behavior rules for Claude, Codex, and other coding agents. |
| ART-AI-ROLE-PRODUCT-ANALYST | agent-role | Product Analyst Role | `memory/ai/ROLE_PRODUCT_ANALYST.md` | authoritative | v1.0 | user request | none | none | true | Product discovery role definition. |
| ART-AI-ROLE-SPEC-AUTHOR | agent-role | Spec Author Role | `memory/ai/ROLE_SPEC_AUTHOR.md` | authoritative | v1.0 | user request | none | none | true | Spec creation and maintenance role definition. |
| ART-AI-ROLE-ARCHITECT | agent-role | Architect Role | `memory/ai/ROLE_ARCHITECT.md` | authoritative | v1.0 | user request | none | none | true | Architecture role definition. |
| ART-AI-ROLE-BACKLOG-PLANNER | agent-role | Backlog Planner Role | `memory/ai/ROLE_BACKLOG_PLANNER.md` | authoritative | v1.0 | user request | none | none | true | Backlog planning role definition. |
| ART-AI-ROLE-IMPLEMENTATION-AGENT | agent-role | Implementation Agent Role | `memory/ai/ROLE_IMPLEMENTATION_AGENT.md` | authoritative | v1.0 | user request | none | none | true | Ready-task implementation role definition. |
| ART-AI-ROLE-QA-REVIEWER | agent-role | QA Reviewer Role | `memory/ai/ROLE_QA_REVIEWER.md` | authoritative | v1.0 | user request | none | none | true | Test and acceptance coverage review role definition. |
| ART-AI-ROLE-SECURITY-REVIEWER | agent-role | Security Reviewer Role | `memory/ai/ROLE_SECURITY_REVIEWER.md` | authoritative | v1.0 | user request | none | none | true | Security and privacy review role definition. |
| ART-AI-ROLE-DEVOPS-RELEASE-REVIEWER | agent-role | DevOps Release Reviewer Role | `memory/ai/ROLE_DEVOPS_RELEASE_REVIEWER.md` | authoritative | v1.0 | user request | none | none | true | CI/CD, release, rollback, and observability review role definition. |
| ART-AI-ROLE-DOCUMENTATION-CURATOR | agent-role | Documentation Curator Role | `memory/ai/ROLE_DOCUMENTATION_CURATOR.md` | authoritative | v1.0 | user request | none | none | true | Shared state and documentation alignment role definition. |
| ART-AI-ROLE-ADVERSARIAL-PR-REVIEWER | agent-role | Adversarial PR Reviewer Role | `memory/ai/ROLE_ADVERSARIAL_PR_REVIEWER.md` | authoritative | v1.0 | user request | none | none | true | Fresh-context PR review role definition. |
| ART-AI-ROLE-DIAGRAM-ARCHITECT | agent-role | Diagram Architect Role | `memory/ai/ROLE_DIAGRAM_ARCHITECT.md` | authoritative | v1.0 | user request | none | none | true | Mermaid diagram creation and review role definition. |
| ART-BOOT-001 | governance | AI Project Bootstrap Operating System | `AI_PROJECT_BOOTSTRAP.md` | authoritative | v1.2 | user request, audit, shared role update, review fix | none | none | true | Primary entrypoint. |
| ART-BOOT-002 | guide | Bootstrap Usage Guide | `BOOTSTRAP_USAGE.md` | authoritative | v1.2 | user request, audit, shared role update, review fix | none | none | true | How to use the package. |
| ART-BOOT-003 | audit | Bootstrap Repository Audit | `BOOTSTRAP_AUDIT.md` | authoritative | v1.0 | target and reference audit | none | none | true | Audit record. |
| ART-GOV-001 | governance | Governance | `GOVERNANCE.md` | authoritative | v1.1 | user request, audit, review follow-up | none | none | true | Core rules, including agent entrypoint metadata exception. |
| ART-CTX-001 | guide | Context Index | `CONTEXT_INDEX.md` | authoritative | v1.1 | user request, audit, shared role update | none | none | true | Required reading map. |
| ART-ARCH-001 | architecture | Bootstrap Architecture | `ARCHITECTURE.md` | authoritative | v1.1 | user request, audit, shared role update | none | none | true | Process architecture. |
| ART-ADR-001 | adr-guide | Decision Governance | `DECISIONS.md` | authoritative | v1.0 | user request, audit | none | none | true | ADR rules. |
| ART-GIT-001 | guide | Branch And Worktree Guide | `BRANCH_AND_WORKTREE_GUIDE.md` | authoritative | v1.0 | user request, audit | none | none | true | Git and worktree rules. |
| ART-PAR-001 | execution-plan | Parallel Execution Plan | `PARALLEL_EXECUTION_PLAN.md` | authoritative | v1.0 | user request, audit | none | none | true | Parallel work gate. |
| ART-REG-001 | registry | Artifact Registry | `ARTIFACT_REGISTRY.md` | authoritative | v1.2 | scaffold, shared role update, review fix | none | none | true | Current artifact inventory. |
| ART-TRACE-001 | traceability | Traceability Matrix | `TRACEABILITY_MATRIX.md` | authoritative | v1.2 | scaffold, shared role update, review fix | none | none | true | Requirement-to-evidence map. |
| ART-TEST-001 | test-strategy | Test Strategy | `TEST_STRATEGY.md` | authoritative | v1.0 | user request | none | none | true | Testing principles. |
| ART-TEST-002 | test-plan | Test Plan | `TEST_PLAN.md` | authoritative | v1.0 | scaffold | none | none | true | Current test plan. |
| ART-REVIEW-001 | review-policy | PR Review Policy | `PR_REVIEW_POLICY.md` | authoritative | v1.0 | user request | none | none | true | Adversarial review rules. |
| ART-REVIEW-002 | merge-policy | PR Merge Policy | `PR_MERGE_POLICY.md` | authoritative | v1.0 | user request | none | none | true | Merge gate. |
| ART-REVIEW-003 | prompt-library | AI Review Prompts | `AI_REVIEW_PROMPTS.md` | authoritative | v1.0 | user request | none | none | true | Reviewer prompt library. |
| ART-RISK-001 | risk-model | Risk Model | `RISK_MODEL.md` | authoritative | v1.0 | user request | none | none | true | Review effort selection. |
| ART-HOOKS-001 | guide | Hooks And Guardrails | `HOOKS_AND_GUARDRAILS.md` | authoritative | v1.0 | user request | none | none | true | Local hook and CI guardrail guidance. |
| ART-SEC-001 | security | Security And Privacy | `SECURITY_AND_PRIVACY.md` | authoritative | v1.0 | user request | none | none | true | Security rules. |
| ART-OBS-001 | observability | Observability | `OBSERVABILITY.md` | authoritative | v1.0 | user request | none | none | true | Observability rules. |
| ART-CI-001 | ci-guide | CI/CD Guide | `CI_CD_GUIDE.md` | authoritative | v1.0 | user request | none | none | true | CI guidance. |
| ART-REL-001 | release | Release Readiness | `RELEASE_READINESS.md` | authoritative | v1.0 | user request | none | none | true | Release checklist. |
| ART-CONTRIB-001 | contribution-guide | Contributing | `CONTRIBUTING.md` | authoritative | v1.0 | user request | none | none | true | Contributor workflow. |

## Active Shared State Artifacts

| Artifact ID | Type | Title | File Path | Status | Version | Source Input | Linked Specs | Linked ADRs | Authoritative | Notes |
|-------------|------|-------|-----------|--------|---------|--------------|--------------|-------------|---------------|-------|
| ART-STATE-001 | shared-state | Project Memory | `PROJECT_MEMORY.md` | active | v1.0 | scaffold | none | none | false | Summary only. |
| ART-STATE-002 | shared-state | Current State | `CURRENT_STATE.md` | active | v1.2 | scaffold, shared role update, review fix | none | none | false | Current operational view. |
| ART-STATE-003 | shared-state | AI Handoff | `AI_HANDOFF.md` | active | v1.2 | scaffold, shared role update, review fix | none | none | false | Agent transition state. |
| ART-STATE-004 | shared-state | Open Questions | `OPEN_QUESTIONS.md` | active | v1.0 | scaffold | none | none | false | Unresolved blockers. |
| ART-STATE-005 | shared-state | Stale Items | `STALE_ITEMS.md` | active | v1.0 | scaffold | none | none | false | Drift and stale items. |
| ART-BACKLOG-001 | backlog | Backlog | `BACKLOG.md` | active | v1.0 | scaffold | none | none | true | Current backlog mirror. |
| ART-PLAN-001 | implementation-plan | Implementation Plan | `IMPLEMENTATION_PLAN.md` | active | v1.0 | scaffold | none | none | true | Bootstrap implementation plan. |
| ART-TEST-003 | test-results | Test Results | `TEST_RESULTS.md` | active | v1.2 | scaffold, shared role update, review fix | none | none | false | Validation history. |

## Template And Directory Artifacts

| Artifact ID | Type | Title | File Path | Status | Version | Source Input | Linked Specs | Linked ADRs | Authoritative | Notes |
|-------------|------|-------|-----------|--------|---------|--------------|--------------|-------------|---------------|-------|
| ART-SPEC-INDEX | spec-index | Spec Index | `SPECS/SPEC_INDEX.md` | active | v1.0 | scaffold | none | none | true | Spec inventory. |
| ART-SPEC-TEMPLATE | template | Spec Template | `SPECS/templates/SPEC_TEMPLATE.md` | active | v1.0 | scaffold | none | none | false | Template for new specs. |
| ART-ADR-INDEX | adr-index | ADR Index | `ADR/ADR_INDEX.md` | active | v1.0 | scaffold | none | none | true | ADR inventory. |
| ART-ADR-TEMPLATE | template | ADR Template | `ADR/templates/ADR_TEMPLATE.md` | active | v1.0 | scaffold | none | none | false | Template for new ADRs. |
| ART-BACKLOG-INDEX | backlog-index | Backlog Index | `BACKLOG/BACKLOG_INDEX.md` | active | v1.0 | scaffold | none | none | true | Backlog item inventory. |
| ART-BACKLOG-TEMPLATE | template | Backlog Item Template | `BACKLOG/templates/BACKLOG_ITEM_TEMPLATE.md` | active | v1.0 | scaffold | none | none | false | Template for detailed items. |
| ART-REVIEW-INDEX | review-index | Review Index | `REVIEWS/REVIEW_INDEX.md` | active | v1.1 | scaffold, shared role review fixes | none | none | true | Review inventory. |
| ART-REVIEW-BOOT-001 | pr-review | Bootstrap Baseline Adversarial Review | `REVIEWS/REVIEW-2026-05-09-bootstrap-baseline.md` | active | v1.0 | user adversarial review | none | none | false | Review findings and fix evidence before baseline commit. |
| ART-PR-PACKAGE-SHARED-ROLE-001 | pr-review-package | Shared Role System PR Review Package | `REVIEWS/PR_REVIEW_PACKAGE-2026-05-09-shared-role-system.md` | active | v1.0 | shared role system implementation | none | none | false | Durable review package for the shared `memory/ai/` role system update. |
| ART-REVIEW-SHARED-ROLE-001 | pr-review | Shared Role System Adversarial Review | `REVIEWS/REVIEW-2026-05-09-shared-role-system.md` | active | v1.1 | Codex adversarial review, review fix response | none | none | false | Review findings for the shared `memory/ai/` role system update before baseline commit, with implementer response recorded. |
| ART-REVIEW-TEMPLATE | template | Adversarial Review Template | `REVIEWS/templates/ADVERSARIAL_PR_REVIEW_TEMPLATE.md` | active | v1.0 | scaffold | none | none | false | Review output template. |
| ART-PR-PACKAGE-TEMPLATE | template | PR Review Package Template | `REVIEWS/templates/PR_REVIEW_PACKAGE_TEMPLATE.md` | active | v1.0 | scaffold | none | none | false | Implementer review package. |
| ART-TEST-MANUAL | checklist | Manual Test Checklist | `TESTS/MANUAL_TEST_CHECKLIST.md` | active | v1.0 | scaffold | none | none | false | Manual validation checklist. |
| ART-TEST-AC-MAP | traceability | Acceptance Criteria Map | `TESTS/ACCEPTANCE_CRITERIA_MAP.md` | active | v1.0 | scaffold | none | none | true | AC-to-test map. |
| ART-WORKLOG-INDEX | worklog | Worklog Index | `WORKLOG/WORKLOG_INDEX.md` | active | v1.2 | scaffold, shared role update, review fix | none | none | false | Session history. |
| ART-HANDOFF-INDEX | handoff-index | Handoff Index | `HANDOFFS/HANDOFF_INDEX.md` | active | v1.0 | scaffold | none | none | false | Historical handoffs. |
| ART-SCRIPT-CLAUDE | script | Claude Role Startup Helper | `SCRIPTS/start-claude.sh` | active | v1.1 | user request, review fix | none | none | false | Optional Claude helper that loads shared rules and one allowlisted role file through `--append-system-prompt`; default mode is orientation-only. |
| ART-SCRIPT-VALIDATE | script | Bootstrap Validator | `SCRIPTS/validate-bootstrap.sh` | active | v1.2 | scaffold, shared role update, review fix | none | none | false | Lightweight validation, including shared role file, Claude startup, and default-mode documentation checks. |
| ART-INPUT-DIR | input-directory | Product Input Directory | `INPUT/.gitkeep` | active | v1.0 | scaffold | none | none | false | Placeholder keeps the documented input directory present. |
| ART-HOOK-PRECOMMIT | hook | Pre-commit Hook Template | `.githooks/pre-commit` | active | v1.1 | scaffold, commit validation fix | none | none | false | Fast local validation and secret pattern check that avoids matching its own scanner definition. |
| ART-HOOK-COMMITMSG | hook | Commit Message Hook Template | `.githooks/commit-msg` | active | v1.0 | scaffold | none | none | false | Commit reference reminder. |
| ART-HOOK-PREPUSH | hook | Pre-push Hook Template | `.githooks/pre-push` | active | v1.0 | scaffold | none | none | false | Bootstrap validation before push. |
| ART-CI-WORKFLOW | ci-template | Bootstrap Validation Workflow | `.github/workflows/bootstrap-validation.yml` | active | v1.0 | scaffold | none | none | false | Optional GitHub Actions validation. |
| ART-GITIGNORE | config | Git Ignore | `.gitignore` | active | v1.0 | scaffold | none | none | false | Generic generated file and secret-adjacent ignores. |

## Lifecycle Rules

- Add every meaningful artifact here when it is created.
- Update status and version when an artifact changes.
- Mark replaced artifacts as superseded, deprecated, cancelled, or archived.
- Add a visible banner at the top of superseded artifacts.
- Generated artifacts must identify their source.
- Temporary artifacts must have a cleanup decision.
