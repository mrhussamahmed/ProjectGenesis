artifact_id: ART-REG-001
title: Artifact Registry
type: registry
status: authoritative
version: v4.0
created: 2026-05-09
updated: 2026-05-16
owner: AI Bootstrap Maintainers
source: ProjectGenesis bootstrap scaffold; slice 3 required-reading shrink (full prior history preserved at MAINTAINER_ARCHIVE/snapshots/ARTIFACT_REGISTRY.md-2026-05-16-pre-slice-3.md)
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

Common fields for all entries below unless stated otherwise: created
2026-05-09; updated 2026-05-16; owner AI Bootstrap Maintainers; source
ProjectGenesis bootstrap scaffold.

## Operating Model And Required-Reading

| Artifact ID | Type | Title | File | Status | Version | Authoritative | Notes |
|---|---|---|---|---|---|---|---|
| ART-REG-001 | registry | Artifact Registry | `ARTIFACT_REGISTRY.md` | authoritative | v4.0 | true | This registry (self-entry). |
| ART-BOOT-001 | governance | AI Project Bootstrap | `AI_PROJECT_BOOTSTRAP.md` | active | v4.0 | true | Operating-model description. |
| ART-BOOT-002 | usage | Bootstrap Usage | `BOOTSTRAP_USAGE.md` | active | v4.0 | false | Practical usage guide. |
| ART-GETTING-STARTED | guide | Getting Started | `GETTING_STARTED.md` | active | v4.0 | false | First-use guide. |
| ART-NEW-PROJECT-INIT | guide | New Project Initialization | `NEW_PROJECT_INITIALIZATION.md` | active | v4.0 | false | New project init steps. |
| ART-AGENTS-MD | governance | Codex/Other Agent Entry | `AGENTS.md` | active | v4.0 | true | Required reading for Codex and other agents. |
| ART-CLAUDE-MD | governance | Claude Entry | `CLAUDE.md` | active | v4.0 | true | Required reading for Claude. |
| ART-GOVERNANCE | governance | Governance | `GOVERNANCE.md` | active | v4.0 | true | Governance hierarchy and rules. |
| ART-OPS-ROUTING-001 | governance | Operation Routing | `OPERATION_ROUTING.md` | active | v4.0 | true | Adaptive governance control plane. |
| ART-STATE-001 | shared-state | Project Memory | `PROJECT_MEMORY.md` | active | v4.0 | false | Durable project context. |
| ART-STATE-002 | shared-state | Current State | `CURRENT_STATE.md` | active | v4.0 | false | Current source-of-truth state. |
| ART-STATE-003 | shared-state | AI Handoff | `AI_HANDOFF.md` | active | v4.0 | false | Active handoff envelope. |
| ART-STATE-004 | shared-state | Open Questions | `OPEN_QUESTIONS.md` | active | v4.0 | false | Open questions register. |
| ART-CONTEXT-INDEX | governance | Context Index | `CONTEXT_INDEX.md` | active | v4.0 | true | Required-reading index. |
| ART-ARCH-001 | architecture | Architecture | `ARCHITECTURE.md` | active | v4.0 | true | Stack-neutral architecture. |
| ART-ADR-001 | governance | Decisions | `DECISIONS.md` | active | v4.0 | true | ADR governance. |
| ART-BACKLOG-001 | backlog | Backlog | `BACKLOG.md` | active | v4.0 | true | Current backlog summary. |
| ART-IMPL-PLAN-001 | implementation-plan | Implementation Plan | `IMPLEMENTATION_PLAN.md` | active | v4.0 | false | Current implementation phase. |
| ART-BRANCH-GUIDE | governance | Branch And Worktree Guide | `BRANCH_AND_WORKTREE_GUIDE.md` | active | v4.0 | true | Git workflow. |
| ART-TRACE-001 | traceability | Traceability Matrix | `TRACEABILITY_MATRIX.md` | authoritative | v4.0 | true | Requirements-to-tests trace. |
| ART-TEST-STRATEGY | test-strategy | Test Strategy | `TEST_STRATEGY.md` | active | v4.0 | false | Test strategy. |
| ART-TEST-PLAN | test-plan | Test Plan | `TEST_PLAN.md` | active | v4.0 | false | Test plan. |
| ART-TEST-003 | test-results | Test Results | `TEST_RESULTS.md` | active | v4.0 | false | Recent test runs. |
| ART-PR-REVIEW-POLICY | governance | PR Review Policy | `PR_REVIEW_POLICY.md` | active | v4.0 | true | Review policy. |
| ART-PR-MERGE-POLICY | governance | PR Merge Policy | `PR_MERGE_POLICY.md` | active | v4.0 | true | Merge policy. |
| ART-REVIEW-PROMPTS | reference | AI Review Prompts | `AI_REVIEW_PROMPTS.md` | active | v4.0 | false | Review prompt library. |
| ART-RISK-MODEL | governance | Risk Model | `RISK_MODEL.md` | active | v4.0 | false | Risk classification. |
| ART-HOOKS-GUARDRAILS | governance | Hooks And Guardrails | `HOOKS_AND_GUARDRAILS.md` | active | v4.0 | false | Pre-commit/pre-push hooks. |
| ART-RELEASE-READINESS | governance | Release Readiness | `RELEASE_READINESS.md` | active | v4.0 | false | Release gates. |
| ART-SECURITY-PRIVACY | governance | Security And Privacy | `SECURITY_AND_PRIVACY.md` | active | v4.0 | false | Security/privacy guidance. |
| ART-OBSERVABILITY | governance | Observability | `OBSERVABILITY.md` | active | v4.0 | false | Observability guidance. |
| ART-CI-CD-GUIDE | governance | CI/CD Guide | `CI_CD_GUIDE.md` | active | v4.0 | false | CI/CD guidance. |
| ART-CONTRIBUTING | governance | Contributing | `CONTRIBUTING.md` | active | v4.0 | false | Contributing guide. |
| ART-INPUT-README | placeholder | Input README | `INPUT/README.md` | active | v4.0 | false | Input directory placeholder. |
| ART-INPUT-GITKEEP | placeholder | Input gitkeep | `INPUT/.gitkeep` | active | v4.0 | false | Directory keeper. |

## Intake And Context

| Artifact ID | Type | Title | File | Status | Version | Authoritative | Notes |
|---|---|---|---|---|---|---|---|
| ART-INTAKE-INDEX | intake-index | Intake Index | `00_intake/INTAKE_INDEX.md` | active | v4.0 | true | Intake registry. |
| ART-INTAKE-SOURCE-REGISTRY | source-registry | Source Registry | `00_intake/SOURCE_REGISTRY.md` | active | v4.0 | true | Sources. |
| ART-CONTEXT-PROJECT-BRIEF | product-context | Project Brief | `01_context/PROJECT_BRIEF.md` | active | v4.0 | true | Brief. |
| ART-CONTEXT-PROJECT-CHARTER | product-context | Project Charter | `01_context/PROJECT_CHARTER.md` | active | v4.0 | true | Charter. |
| ART-CONTEXT-GLOSSARY | glossary | Glossary | `01_context/GLOSSARY.md` | active | v4.0 | true | Terms. |
| ART-CONTEXT-CONSTRAINTS | product-context | Constraints | `01_context/CONSTRAINTS.md` | active | v4.0 | true | Constraints. |
| ART-REQ-INDEX | requirements-registry | Requirements Index | `02_requirements/REQUIREMENTS_INDEX.md` | active | v4.0 | true | Requirements. |
| ART-REQ-ASSUMPTIONS | assumptions-registry | Assumptions Register | `02_requirements/ASSUMPTIONS_REGISTER.md` | active | v4.0 | true | Assumptions. |
| ART-REQ-RISK-REGISTER | risk-register | Risk Register | `02_requirements/RISK_REGISTER.md` | active | v4.0 | true | Risks. |

## Context Packs And Commands

| Artifact ID | Type | Title | File | Status | Version | Authoritative | Notes |
|---|---|---|---|---|---|---|---|
| ART-CONTEXT-PACK-README | reference | Context Packs README | `CONTEXT_PACKS/README.md` | active | v4.0 | false | Pack index. |
| ART-CONTEXT-PACK-INTAKE | reference | Product Intake Pack | `CONTEXT_PACKS/product-intake.md` | active | v4.0 | false | Pack. |
| ART-CONTEXT-PACK-SPEC | reference | Spec Authoring Pack | `CONTEXT_PACKS/spec-authoring.md` | active | v4.0 | false | Pack. |
| ART-CONTEXT-PACK-ARCH | reference | Architecture Pack | `CONTEXT_PACKS/architecture.md` | active | v4.0 | false | Pack. |
| ART-CONTEXT-PACK-IMPL | reference | Implementation Pack | `CONTEXT_PACKS/implementation.md` | active | v4.0 | false | Pack. |
| ART-CONTEXT-PACK-REVIEW | reference | Review Pack | `CONTEXT_PACKS/review.md` | active | v4.0 | false | Pack. |
| ART-CONTEXT-PACK-RESUME | reference | Resume Pack | `CONTEXT_PACKS/resume.md` | active | v4.0 | false | Pack. |
| ART-COMMAND-INDEX | command-registry | Command Index | `COMMANDS/COMMAND_INDEX.md` | active | v4.0 | true | Command registry. |
| ART-COMMAND-TEMPLATE | template | Command Template | `COMMANDS/COMMAND_TEMPLATE.md` | active | v4.0 | false | Template. |

## Roles

| Artifact ID | Type | Title | File | Status | Version | Authoritative | Notes |
|---|---|---|---|---|---|---|---|
| ART-ROLE-SHARED | governance | Shared Agent Rules | `memory/ai/SHARED_AGENT_RULES.md` | active | v4.0 | true | Shared role rules. |
| ART-ROLE-PRODUCT | role | Product Analyst | `memory/ai/ROLE_PRODUCT_ANALYST.md` | active | v4.0 | true | Role doc. |
| ART-ROLE-SPEC | role | Spec Author | `memory/ai/ROLE_SPEC_AUTHOR.md` | active | v4.0 | true | Role doc. |
| ART-ROLE-ARCH | role | Architect | `memory/ai/ROLE_ARCHITECT.md` | active | v4.0 | true | Role doc. |
| ART-ROLE-BACKLOG | role | Backlog Planner | `memory/ai/ROLE_BACKLOG_PLANNER.md` | active | v4.0 | true | Role doc. |
| ART-ROLE-IMPL | role | Implementation Agent | `memory/ai/ROLE_IMPLEMENTATION_AGENT.md` | active | v4.0 | true | Role doc. |
| ART-ROLE-QA | role | QA Reviewer | `memory/ai/ROLE_QA_REVIEWER.md` | active | v4.0 | true | Role doc. |
| ART-ROLE-SECURITY | role | Security Reviewer | `memory/ai/ROLE_SECURITY_REVIEWER.md` | active | v4.0 | true | Role doc. |
| ART-ROLE-DEVOPS | role | DevOps Release Reviewer | `memory/ai/ROLE_DEVOPS_RELEASE_REVIEWER.md` | active | v4.0 | true | Role doc. |
| ART-ROLE-DOCS | role | Documentation Curator | `memory/ai/ROLE_DOCUMENTATION_CURATOR.md` | active | v4.0 | true | Role doc. |
| ART-ROLE-ADV-REVIEW | role | Adversarial PR Reviewer | `memory/ai/ROLE_ADVERSARIAL_PR_REVIEWER.md` | active | v4.0 | true | Role doc. |
| ART-ROLE-DIAGRAM | role | Diagram Architect | `memory/ai/ROLE_DIAGRAM_ARCHITECT.md` | active | v4.0 | true | Role doc. |

## Indexes And Templates

| Artifact ID | Type | Title | File | Status | Version | Authoritative | Notes |
|---|---|---|---|---|---|---|---|
| ART-SPEC-INDEX | spec-index | Spec Index | `SPECS/SPEC_INDEX.md` | active | v4.0 | true | Active specs. SPEC-BOOT-* legacy specs preserved in `MAINTAINER_ARCHIVE/SPECS/`. |
| ART-SPEC-TEMPLATE | template | Spec Template | `SPECS/templates/SPEC_TEMPLATE.md` | active | v4.0 | false | Template. |
| ART-ADR-INDEX | adr-index | ADR Index | `ADR/ADR_INDEX.md` | active | v4.0 | true | ADR registry. |
| ART-ADR-TEMPLATE | template | ADR Template | `ADR/templates/ADR_TEMPLATE.md` | active | v4.0 | false | Template. |
| ART-BACKLOG-INDEX | backlog-index | Backlog Index | `BACKLOG/BACKLOG_INDEX.md` | active | v4.0 | true | Backlog registry. BOOT-* legacy items archived. |
| ART-BACKLOG-TEMPLATE | template | Backlog Item Template | `BACKLOG/templates/BACKLOG_ITEM_TEMPLATE.md` | active | v4.0 | false | Template. |
| ART-REVIEW-INDEX | review-index | Review Index | `REVIEWS/REVIEW_INDEX.md` | active | v4.0 | true | Review registry. Prior PR_REVIEW_PACKAGE-* and REVIEW-* records archived. |
| ART-REVIEW-ADV-TEMPLATE | template | Adversarial PR Review Template | `REVIEWS/templates/ADVERSARIAL_PR_REVIEW_TEMPLATE.md` | active | v4.0 | false | Template. |
| ART-REVIEW-PR-TEMPLATE | template | PR Review Package Template | `REVIEWS/templates/PR_REVIEW_PACKAGE_TEMPLATE.md` | active | v4.0 | false | Template. |
| ART-TEST-MANUAL | checklist | Manual Test Checklist | `TESTS/MANUAL_TEST_CHECKLIST.md` | active | v4.0 | false | Manual tests. |
| ART-WORKLOG-INDEX | worklog | Worklog Index | `WORKLOG/WORKLOG_INDEX.md` | active | v4.0 | false | Worklog registry. Prior sessions archived. |
| ART-HANDOFF-INDEX | handoff-index | Handoff Index | `HANDOFFS/HANDOFF_INDEX.md` | active | v4.0 | false | Handoff registry. |

## Scripts And Hooks

| Artifact ID | Type | Title | File | Status | Version | Authoritative | Notes |
|---|---|---|---|---|---|---|---|
| ART-SCRIPT-START-CLAUDE | script | Claude Role Launcher | `SCRIPTS/start-claude.sh` | active | v4.0 | false | Role launcher. |
| ART-SCRIPT-OP-PROFILE | script | Operation Profile Extractor | `SCRIPTS/operation-profile.sh` | active | v4.0 | false | Slice 4 fast-path adapter: reads AI_HANDOFF.md Operation profile and maps to validator level. |
| ART-SCRIPT-VALIDATE | script | Bootstrap Validator | `SCRIPTS/validate-bootstrap.sh` | active | v4.0 | false | Shape and structure validator. |
| ART-SCRIPT-RED-CHECKS | script | Red-Check Harness | `SCRIPTS/validate-bootstrap-red-checks.sh` | active | v4.0 | false | Red-check harness. |
| ART-METRIC-EVIDENCE | script | Evidence Coverage Metric | `SCRIPTS/metric-evidence-coverage.sh` | active | v4.0 | false | Metric script. |
| ART-METRIC-ACCEPTANCE | script | Acceptance Coverage Metric | `SCRIPTS/metric-acceptance-coverage.sh` | active | v4.0 | false | Metric script. |
| ART-METRIC-TRACE | script | Traceability Completeness Metric | `SCRIPTS/metric-traceability-completeness.sh` | active | v4.0 | false | Metric script. |
| ART-HOOK-PRE-COMMIT | hook | Pre-Commit Hook | `.githooks/pre-commit` | active | v4.0 | false | Hook. |
| ART-HOOK-COMMIT-MSG | hook | Commit-Msg Hook | `.githooks/commit-msg` | active | v4.0 | false | Hook. |
| ART-HOOK-PRE-PUSH | hook | Pre-Push Hook | `.githooks/pre-push` | active | v4.0 | false | Hook. |
| ART-CI-WORKFLOW | ci | Bootstrap Validation CI | `.github/workflows/bootstrap-validation.yml` | active | v4.0 | false | CI workflow. |

## Templates And Manifest

| Artifact ID | Type | Title | File | Status | Version | Authoritative | Notes |
|---|---|---|---|---|---|---|---|
| ART-TEMPLATE-MANIFEST | scaffold-manifest | Template Manifest | `TEMPLATE_MANIFEST.md` | active | v2.0 | true | Slice 1+2 manifest. |

## Maintainer Archive References

| Artifact ID | Type | Title | File | Status | Version | Authoritative | Notes |
|---|---|---|---|---|---|---|---|
| ART-MAINTAINER-ARCHIVE | maintainer-archive | Maintainer Archive Root | `MAINTAINER_ARCHIVE/` | archived | v1.0 | false | Slice 2 relocation target for ProjectGenesis maintainer history. Not part of consumer first-run scaffold; safe to `rm -rf` after raw cp -R. |
| ART-MA-BOOTSTRAP-AUDIT | audit | Archived Bootstrap Audit | `MAINTAINER_ARCHIVE/BOOTSTRAP_AUDIT.md` | archived | v1.0 | false | PG audit record. |
| ART-MA-GOV-PERF | measurement | Archived Governance Performance | `MAINTAINER_ARCHIVE/GOVERNANCE_PERFORMANCE.md` | archived | v1.0 | false | PG perf measurement. |
| ART-MA-PARALLEL-PLAN | execution-plan | Archived Parallel Execution Plan | `MAINTAINER_ARCHIVE/PARALLEL_EXECUTION_PLAN.md` | archived | v1.0 | false | PG parallel plan. |
| ART-MA-STALE | shared-state | Archived Stale Items | `MAINTAINER_ARCHIVE/STALE_ITEMS.md` | archived | v1.0 | false | PG stale items log. |
| ART-MA-AC-MAP | traceability | Archived AC Map | `MAINTAINER_ARCHIVE/TESTS/ACCEPTANCE_CRITERIA_MAP.md` | archived | v1.0 | false | PG AC map. |
| ART-MA-SEED-BENCH-PLAN | benchmark-plan | Archived Seed Benchmark Plan | `MAINTAINER_ARCHIVE/TESTS/ADVERSARIAL_SEED_BENCHMARK.md` | archived | v1.0 | false | PG seeded-defect plan. |
| ART-MA-SCAFFOLD-EXTRACT | script | Archived Scaffold Extract Script | `MAINTAINER_ARCHIVE/SCRIPTS/scaffold-extract.sh` | archived | v1.0 | false | PG scaffold extractor. |
| ART-MA-SEED-BENCH-RUNNER | script | Archived Seed Benchmark Runner | `MAINTAINER_ARCHIVE/SCRIPTS/run-seeded-defect-bench.sh` | archived | v1.0 | false | PG benchmark runner. |
