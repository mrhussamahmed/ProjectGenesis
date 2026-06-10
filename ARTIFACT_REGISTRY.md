artifact_id: ART-REG-001
title: Artifact Registry
type: registry
status: authoritative
version: v5.0
created: 2026-05-09
updated: 2026-06-10
owner: AI Bootstrap Maintainers
source: ProjectGenesis bootstrap scaffold; slice 3 required-reading shrink (full prior history preserved at MAINTAINER_ARCHIVE/snapshots/ARTIFACT_REGISTRY.md-2026-05-16-pre-slice-3.md); BOOT-GREEN-MERGE-001; GEN-01..16 improvement program
linked_specs: []
linked_tickets: [BOOT-STATE-001, BOOT-GREEN-MERGE-001]
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Artifact Registry

The registry identifies current, authoritative, active, draft, generated,
temporary, superseded, deprecated, cancelled, and archived artifacts. Do not
use superseded, deprecated, cancelled, or archived artifacts as current truth.

Common fields for all entries below unless stated otherwise: created
2026-05-09; updated 2026-06-10; owner AI Bootstrap Maintainers; source
ProjectGenesis bootstrap scaffold.

## Operating Model And Required-Reading

| Artifact ID | Type | Title | File | Status | Version | Authoritative | Notes |
|---|---|---|---|---|---|---|---|
| ART-REG-001 | registry | Artifact Registry | `ARTIFACT_REGISTRY.md` | authoritative | v5.0 | true | This registry (self-entry). |
| ART-BOOT-001 | governance | AI Project Bootstrap | `AI_PROJECT_BOOTSTRAP.md` | active | v4.0 | true | Operating-model description. |
| ART-BOOT-002 | usage | Bootstrap Usage | `BOOTSTRAP_USAGE.md` | active | v4.0 | false | Practical usage guide. |
| ART-NEW-PROJECT-INIT | guide | New Project Initialization | `NEW_PROJECT_INITIALIZATION.md` | active | v4.0 | false | New project init steps. |
| ART-AGENTS-MD | governance | Codex/Other Agent Entry | `AGENTS.md` | active | v4.0 | true | Required reading for Codex and other agents. |
| ART-CLAUDE-MD | governance | Claude Entry | `CLAUDE.md` | active | v4.0 | true | Required reading for Claude. |
| ART-GOVERNANCE | governance | Governance | `GOVERNANCE.md` | active | v1.5 | true | Governance hierarchy and rules; includes split-state end-of-session boundary and AI green-merge role-separation language. |
| ART-OPS-ROUTING-001 | governance | Operation Routing | `OPERATION_ROUTING.md` | active | v1.1 | true | Adaptive governance control plane; defines local session hints and durable evidence locations. |
| ART-STATE-002 | shared-state | Current State | `CURRENT_STATE.md` | active | v4.0 | false | Current source-of-truth state. |
| ART-STATE-003 | shared-state | AI Handoff | `AI_HANDOFF.md` | active | v4.0 | false | Active handoff envelope. |
| ART-STATE-004 | shared-state | Open Questions | `OPEN_QUESTIONS.md` | active | v4.0 | false | Open questions register. |
| ART-CONTEXT-INDEX | governance | Context Index | `CONTEXT_INDEX.md` | active | v4.0 | true | Required-reading index. |
| ART-ARCH-001 | architecture | Architecture | `ARCHITECTURE.md` | active | v4.0 | true | Stack-neutral architecture. |
| ART-ADR-001 | governance | Decisions | `DECISIONS.md` | active | v4.0 | true | ADR governance. |
| ART-BACKLOG-001 | backlog | Backlog | `BACKLOG.md` | active | v4.0 | true | Current backlog summary. |
| ART-IMPL-PLAN-001 | implementation-plan | Implementation Plan | `IMPLEMENTATION_PLAN.md` | active | v4.0 | false | Current implementation phase. |
| ART-BRANCH-GUIDE | governance | Branch And Worktree Guide | `BRANCH_AND_WORKTREE_GUIDE.md` | active | v1.3 | true | Git workflow and local session handoff boundary. |
| ART-TRACE-001 | traceability | Traceability Matrix | `TRACEABILITY_MATRIX.md` | authoritative | v4.0 | true | Requirements-to-tests trace. |
| ART-TEST-STRATEGY | test-strategy | Test Strategy | `TEST_STRATEGY.md` | active | v4.0 | false | Test strategy. |
| ART-TEST-PLAN | test-plan | Test Plan | `TEST_PLAN.md` | active | v4.0 | false | Test plan. |
| ART-TEST-003 | test-results | Test Results | `TEST_RESULTS.md` | active | v4.0 | false | Recent test runs. |
| ART-PR-REVIEW-POLICY | governance | PR Review Policy | `PR_REVIEW_POLICY.md` | active | v1.4 | true | Review policy; frames adversarial review as defect detection, not authorization; P0/P1/blocking P2 must not be accepted with rationale. |
| ART-PR-MERGE-POLICY | governance | PR Merge Policy | `PR_MERGE_POLICY.md` | active | v1.4 | true | Merge policy; encodes the AI green-merge contract; P0/P1/blocking P2 must be resolved (not accepted with rationale); human/maintainer/Code Owner approval are not required as merge gates. |
| ART-REVIEW-PROMPTS | reference | AI Review Prompts | `AI_REVIEW_PROMPTS.md` | active | v4.0 | false | Review prompt library. |
| ART-RISK-MODEL | governance | Risk Model | `RISK_MODEL.md` | active | v4.0 | false | Risk classification. |
| ART-HOOKS-GUARDRAILS | governance | Hooks And Guardrails | `HOOKS_AND_GUARDRAILS.md` | active | v4.0 | false | Pre-commit/pre-push hooks. |
| ART-RELEASE-READINESS | governance | Release Readiness | `RELEASE_READINESS.md` | active | v4.0 | false | Release gates. |
| ART-RELEASE-NOTES | release-notes | Release Notes | `RELEASE_NOTES.md` | active | v1.0 | true | Public release history. |
| ART-SECURITY-PRIVACY | governance | Security And Privacy | `SECURITY_AND_PRIVACY.md` | active | v4.0 | false | Security/privacy guidance. |
| ART-OBSERVABILITY | governance | Observability | `OBSERVABILITY.md` | active | v4.0 | false | Observability guidance. |
| ART-CI-CD-GUIDE | governance | CI/CD Guide | `CI_CD_GUIDE.md` | active | v4.0 | false | CI/CD guidance. |
| ART-CONTRIBUTING | governance | Contributing | `CONTRIBUTING.md` | active | v4.0 | false | Contributing guide. |

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
| ART-ROLE-SHARED | governance | Shared Agent Rules | `memory/ai/SHARED_AGENT_RULES.md` | active | v1.3 | true | Shared role rules; defines split-state boundary. |
| ART-ROLE-PRODUCT | role | Product Analyst | `memory/ai/ROLE_PRODUCT_ANALYST.md` | active | v1.2 | true | Role doc with split-state stopping rule. |
| ART-ROLE-SPEC | role | Spec Author | `memory/ai/ROLE_SPEC_AUTHOR.md` | active | v1.1 | true | Role doc with split-state stopping rule. |
| ART-ROLE-ARCH | role | Architect | `memory/ai/ROLE_ARCHITECT.md` | active | v2.1 | true | Role doc with split-state stopping rule; absorbed the former Diagram Architect role (GEN-17). |
| ART-ROLE-BACKLOG | role | Backlog Planner | `memory/ai/ROLE_BACKLOG_PLANNER.md` | active | v1.1 | true | Role doc with split-state stopping and parallel-branch coordination guidance. |
| ART-ROLE-IMPL | role | Implementation Agent | `memory/ai/ROLE_IMPLEMENTATION_AGENT.md` | active | v1.2 | true | Role doc with split-state stopping rule and AI green-merge forbidden-actions language. |
| ART-ROLE-QA | role | QA Reviewer | `memory/ai/ROLE_QA_REVIEWER.md` | active | v1.1 | true | Role doc with split-state stopping rule. |
| ART-ROLE-SECURITY | role | Security Reviewer | `memory/ai/ROLE_SECURITY_REVIEWER.md` | active | v1.1 | true | Role doc with split-state stopping rule. |
| ART-ROLE-DEVOPS | role | DevOps Release Reviewer | `memory/ai/ROLE_DEVOPS_RELEASE_REVIEWER.md` | active | v1.1 | true | Role doc with split-state stopping rule. |
| ART-ROLE-DOCS | role | Documentation Curator | `memory/ai/ROLE_DOCUMENTATION_CURATOR.md` | active | v1.2 | true | Role doc with canonical snapshot/history guidance. |
| ART-ROLE-ADV-REVIEW | role | Adversarial PR Reviewer | `memory/ai/ROLE_ADVERSARIAL_PR_REVIEWER.md` | active | v1.3 | true | Role doc with split-state review check and AI green-merge defect-detection framing. |

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
| ART-REVIEW-ADV-TEMPLATE | template | Adversarial PR Review Template | `REVIEWS/templates/ADVERSARIAL_PR_REVIEW_TEMPLATE.md` | active | v4.1 | false | Template with split-state review checks. |
| ART-REVIEW-PR-TEMPLATE | template | PR Review Package Template | `REVIEWS/templates/PR_REVIEW_PACKAGE_TEMPLATE.md` | active | v4.1 | false | Template with branch-specific state fields. |
| ART-REVIEW-SPLIT-STATE-HANDOFF-PLAN-001 | pr-review | Split-State Handoff Boundary Plan Adversarial Review | `REVIEWS/REVIEW-2026-05-17-split-state-handoff-plan.md` | active | v1.2 | false | Codex adversarial review and re-review of the split-state handoff implementation plan; latest outcome approve with minor comments. |
| ART-PR-REVIEW-PACKAGE-SPLIT-STATE-HANDOFF-001 | pr-review-package | Split-State Handoff Boundary PR Review Package | `REVIEWS/PR_REVIEW_PACKAGE-split-state-handoff.md` | draft | v1.0 | false | Durable branch-specific review package for BOOT-STATE-001 implementation. |
| ART-REVIEW-SPLIT-STATE-HANDOFF-IMPL-001 | pr-review | Split-State Handoff Boundary Implementation Review | `REVIEWS/REVIEW-2026-05-17-split-state-handoff-implementation.md` | active | v1.2 | false | Fresh implementation adversarial review; latest outcome approve with minor comments, with merge gated on explicit authority and CI. |
| ART-REVIEW-AI-GREEN-MERGE-IMPL-001 | pr-review | AI Green-Merge For Bootstrap Scaffold Usability Implementation Review | `REVIEWS/REVIEW-2026-05-18-ai-green-merge-scaffold-usability-implementation.md` | active | v1.0 | false | Fresh-context Codex adversarial review (6 iterations) for BOOT-GREEN-MERGE-001; final outcome no blocking findings. |
| ART-TEST-MANUAL | checklist | Manual Test Checklist | `TESTS/MANUAL_TEST_CHECKLIST.md` | active | v4.0 | false | Manual tests. |
| ART-WORKLOG-INDEX | worklog | Worklog Index | `WORKLOG/WORKLOG_INDEX.md` | active | v4.0 | false | Worklog registry. Prior sessions archived. |

## Scripts And Hooks

| Artifact ID | Type | Title | File | Status | Version | Authoritative | Notes |
|---|---|---|---|---|---|---|---|
| ART-SCRIPT-START-CLAUDE | script | Claude Role Launcher | `SCRIPTS/start-claude.sh` | active | v4.0 | false | Role launcher. |
| ART-SCRIPT-OP-PROFILE | script | Operation Profile Extractor | `SCRIPTS/operation-profile.sh` | active | v4.1 | false | Fast-path adapter: reads valid `.ai/SESSION.md` profile hints before legacy AI_HANDOFF fallback and maps to validator level. |
| ART-SCRIPT-SESSION | script | Session Helper | `SCRIPTS/session.sh` | active | v1.0 | false | Writes/refreshes `.ai/SESSION.md` so the validation fast path is reachable. |
| ART-SCRIPT-DOCTOR | script | Doctor Status Command | `SCRIPTS/doctor.sh` | active | v1.0 | false | Read-only orientation: branch, hooks, session, handoff freshness, intake queue. |
| ART-SCRIPT-STRICT-GATE | script | Strict Gate Paths | `SCRIPTS/strict-gate-paths.sh` | active | v1.0 | false | Single source of the strict-gate path pattern for hooks and CI. |
| ART-STARTER-SESSION | template-starter | Session Starter | `TEMPLATE_STARTERS/SESSION.md` | active | v1.0 | false | Format reference for gitignored `.ai/SESSION.md`. |
| ART-STARTER-AC-MAP | template-starter | Acceptance Criteria Map Starter | `TEMPLATE_STARTERS/ACCEPTANCE_CRITERIA_MAP.md` | active | v1.0 | false | Clean AC map for downstream projects. |
| ART-TEMPLATE-TECH-DESIGN | template | Tech Design Template | `SPECS/templates/TECH_DESIGN_TEMPLATE.md` | active | v1.0 | false | One-page solution design skeleton. |
| ART-TEMPLATE-RESEARCH-NOTE | template | Research Note Template | `00_intake/research/RESEARCH_NOTE_TEMPLATE.md` | active | v1.0 | false | Assumption-to-evidence research note. |
| ART-TEMPLATE-SUMMARY | template | Source Summary Template | `00_intake/summaries/SUMMARY_TEMPLATE.md` | active | v1.0 | false | Compact source summary schema. |
| ART-COMMAND-VALIDATE-IDEA | command | Validate The Idea | `COMMANDS/validate-idea.md` | active | v1.0 | false | Evidence-backed idea validation workflow. |
| ART-COMMAND-START-ARCH | command | Start Architecture Design | `COMMANDS/start-architecture-design.md` | active | v1.0 | false | Intent-to-architecture workflow. |
| ART-COMMAND-IMPLEMENT-NEXT | command | Implement Next Story | `COMMANDS/implement-next-story.md` | active | v1.0 | false | Scoped-validation story execution workflow. |
| ART-COMMAND-RESUME-WORK | command | Resume Work | `COMMANDS/resume-work.md` | active | v1.0 | false | Minimum-read session resume workflow. |
| ART-COMMAND-EXPORT-LINEAR | command | Export Backlog To Linear | `COMMANDS/export-backlog-to-linear.md` | active | v1.0 | false | Deterministic, dedupe-safe Linear export. |
| ART-SCRIPT-VALIDATE | script | Bootstrap Validator | `SCRIPTS/validate-bootstrap.sh` | active | v4.2 | false | Shape and structure validator; enforces split-state active-section guard and the BOOT-GREEN-MERGE-001 regression guard against required human/maintainer/Code Owner approval. |
| ART-SCRIPT-RED-CHECKS | script | Red-Check Harness | `SCRIPTS/validate-bootstrap-red-checks.sh` | active | v4.2 | false | Red-check harness with split-state local-session and canonical-state fixtures and BOOT-GREEN-MERGE-001 green-merge fixtures. |
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

## Active Planning Artifacts

| Artifact ID | Type | Title | File | Status | Version | Authoritative | Notes |
|---|---|---|---|---|---|---|---|
| ART-BACKLOG-BOOT-STATE-001 | backlog-item | Split-State Handoff Boundary | `BACKLOG/BOOT-STATE-001-split-state-handoff.md` | done | v1.0 | true | Bootstrap-governance backlog item for split-state handoff implementation; merged via PR #21 at `d4b5161`. |
| ART-PLAN-SPLIT-STATE-HANDOFF-001 | implementation-plan | Split-State Handoff Boundary Plan | `docs/superpowers/plans/2026-05-17-split-state-handoff.md` | active | v0.2 | false | Plan approved with minor comments; Task 0 selected Path B and established merge-policy authority before Task 1. |
| ART-BACKLOG-BOOT-GREEN-MERGE-001 | backlog-item | AI Green-Merge For Bootstrap Scaffold Usability | `BACKLOG/BOOT-GREEN-MERGE-001-ai-green-merge-scaffold-usability.md` | ready | v1.0 | true | Bootstrap-governance backlog item for removing human-approval merge gates while preserving objective safety gates. |

## PG-Specific Files Kept At Active Root (Slice 2 Deferred)

These files remain at active root in slice 2 because the strict red-check
harness and `SCRIPTS/scaffold-extract.sh` depend on them at their active
paths. A future slice will relocate them once the harness and the
scaffold-extract reset templates are updated.

| Artifact ID | Type | Title | File | Status | Version | Authoritative | Notes |
|---|---|---|---|---|---|---|---|
| ART-BOOT-003 | audit | Bootstrap Audit | `BOOTSTRAP_AUDIT.md` | active | v4.0 | false | PG audit record kept at root; relocation deferred. |
| ART-GH-SETUP | guide | GitHub Repository Setup | `GITHUB_REPOSITORY_SETUP.md` | active | v1.3 | false | PG-specific setup guide kept at root; instructs configuring branch protection with the `validate` status check only — no required PR-review, Code Owner, or conversation-resolution gates per BOOT-GREEN-MERGE-001. |
| ART-GOV-PERF | measurement | Governance Performance | `GOVERNANCE_PERFORMANCE.md` | active | v4.0 | false | PG perf measurement kept at root; relocation deferred. |
| ART-PARALLEL-PLAN | execution-plan | Parallel Execution Plan | `PARALLEL_EXECUTION_PLAN.md` | active | v4.0 | false | PG parallel plan kept at root; relocation deferred. |
| ART-FORK-CHECKLIST | guide | Scaffold Fork Checklist | `SCAFFOLD_FORK_CHECKLIST.md` | active | v4.0 | false | PG-specific fork checklist kept at root; relocation deferred. |
| ART-STALE | shared-state | Stale Items | `STALE_ITEMS.md` | active | v4.0 | false | Stale items log kept at root; relocation deferred. |
| ART-AC-MAP | traceability | Acceptance Criteria Map | `TESTS/ACCEPTANCE_CRITERIA_MAP.md` | active | v4.0 | false | AC map kept at root; relocation deferred. |
| ART-SEED-BENCH-PLAN | benchmark-plan | Seed Benchmark Plan | `TESTS/ADVERSARIAL_SEED_BENCHMARK.md` | active | v4.0 | false | PG seeded-defect plan kept at root; relocation deferred. |
| ART-SCAFFOLD-EXTRACT | script | Scaffold Extract Script | `SCRIPTS/scaffold-extract.sh` | active | v4.0 | false | PG scaffold extractor kept at root; relocation deferred. |
| ART-SEED-BENCH-RUNNER | script | Seed Benchmark Runner | `SCRIPTS/run-seeded-defect-bench.sh` | active | v4.0 | false | PG benchmark runner kept at root; relocation deferred. |

## Maintainer Archive References

| Artifact ID | Type | Title | File | Status | Version | Authoritative | Notes |
|---|---|---|---|---|---|---|---|
| ART-MAINTAINER-ARCHIVE | maintainer-archive | Maintainer Archive Root | `MAINTAINER_ARCHIVE/` | archived | v1.0 | false | Slice 2 relocation target for ProjectGenesis maintainer history (BACKLOG, REVIEWS, SPECS, .github/ISSUE_TEMPLATE, docs, ARTIFACTS). Not part of consumer first-run scaffold; safe to `rm -rf` after raw cp -R. |
