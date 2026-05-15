artifact_id: ART-BACKLOG-001
title: Backlog
type: backlog
status: active
version: v1.16
created: 2026-05-09
updated: 2026-05-14
owner: AI Bootstrap Maintainers
source: Initial bootstrap scaffold, public repository publication request, ProjectGenesis PR merge, README positioning/tooling prerequisite update, BOOT-017 merge, SPEC-BOOT-003 proposal, SPEC-BOOT-003 review fixes, SPEC-BOOT-003 approval, BOOT-018 merge, BOOT-019 through BOOT-024 implementation, BOOT-019 through BOOT-024 merge, and public launch readiness packaging
linked_specs: [SPEC-BOOT-002, SPEC-BOOT-003, SPEC-BOOT-004]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Backlog

This file mirrors the current highest-level backlog. Detailed items can live
under `BACKLOG/`.

## Current Backlog

| ID | Title | Purpose | Priority | Complexity | Risk | Dependencies | Readiness | Parallelization | Suggested Role |
|----|-------|---------|----------|------------|------|--------------|-----------|-----------------|----------------|
| BOOT-001 | Validate bootstrap scaffold | Confirm required files, folders, metadata, and handoff exist. | P0 | low | low | none | ready | sequential | QA Agent |
| BOOT-002 | Initialize Git and commit baseline | Create a clean version-control baseline if desired. | P1 | low | low | BOOT-001 | ready after validation | sequential | DevOps Reviewer |
| BOOT-003 | Ingest first product input | Read idea, PRD, Excel file, or feature list and extract requirements. | P1 | medium | medium | product input | blocked | can parallelize with architecture research after intake | Product Analyst |
| BOOT-004 | Create first product spec | Convert requirements into `SPECS/SPEC-001-*.md` with acceptance criteria. | P1 | medium | medium | BOOT-003 | blocked | sequential before implementation | Spec Author |
| BOOT-005 | Create first architecture pass | Define project architecture, boundaries, security, observability, and ADR needs. | P1 | medium | high | BOOT-003 | blocked | may run beside backlog planning after intake | Architect |
| BOOT-006 | Create implementation-ready backlog | Convert specs and architecture into sequenced tasks and Linear-ready items. | P1 | medium | medium | BOOT-004, BOOT-005 | blocked | may parallelize item authoring after boundaries are stable | Backlog Planner |
| BOOT-007 | Define test strategy for first slice | Map acceptance criteria to automated and manual tests. | P1 | medium | medium | BOOT-004 | blocked | can run beside backlog planning | Test and QA Agent |
| BOOT-008 | Prepare first implementation branch | Create branch/worktree only after the first task meets Definition of Ready. | P2 | low | low | BOOT-004, BOOT-006, BOOT-007 | blocked | sequential | Implementation Agent |
| BOOT-009 | Review scaffold intake and governance spec | Review and approve or request changes on `SPEC-BOOT-002` before implementation. | P0 | medium | high | SPEC-BOOT-002 | done | sequential | Adversarial PR Reviewer |
| BOOT-010 | Implement intake migration and source registry | Add canonical intake folders and migrate `INPUT/` to a legacy alias. | P1 | medium | medium | BOOT-009 | done | sequential | Documentation Curator |
| BOOT-011 | Implement product context and requirements control | Add product context files plus requirement, assumption, and risk registers. | P1 | medium | high | BOOT-010 | done | sequential | Product Analyst, Spec Author |
| BOOT-012 | Update workflow policy, templates, and traceability | Add the narrow direct-`main` documentation exception plus evidence, assumption, readiness, and test mapping fields. | P1 | medium | high | BOOT-011 | done | sequential | Spec Author, Architect |
| BOOT-013 | Improve validator with red-check examples | Define and implement validator checks for evidence, assumptions, commands, sources, and handoff consistency. | P1 | medium | high | BOOT-012 | done | sequential | QA Reviewer |
| BOOT-014 | Add context packs and command prompt framework | Add subordinate context packs and safe command prompt scaffolding after validator rules can check authority limits. | P2 | medium | medium | BOOT-013 | done | can parallelize after validator boundaries are stable | Documentation Curator |
| BOOT-015 | Migrate onboarding RTF files | Convert useful RTF content to Markdown and register legacy lifecycle status. | P2 | medium | medium | BOOT-009 | done | can parallelize after spec approval | Documentation Curator |
| BOOT-016 | Publish ProjectGenesis public repository | Add public README, AGPLv3 license, Code Owners, GitHub branch protection guidance, and a reviewable publication PR. | P1 | low | medium | origin repository access | done | sequential | Documentation Curator, DevOps Release Reviewer |
| BOOT-017 | Improve README positioning and tooling prerequisites | Clarify ProjectGenesis capabilities, audience fit, Linear backlog storage, Linear setup, optional Spec Kit use, and other supported tooling before downstream project work starts. | P2 | low | low | BOOT-016 | done | sequential | Documentation Curator, DevOps Release Reviewer |
| BOOT-018 | Create adaptive governance routing spec | Create approved `SPEC-BOOT-003` as the governing policy-only spec for operation profiles, escalation, durable evidence, and protected-artifact routing. | P0 | medium | high | user-approved plan | done | sequential | Spec Author |
| BOOT-019 | Define operation profile policy | After `SPEC-BOOT-003` is approved or activated, update governance-facing docs with approved operation profiles, risk mapping, branch rules, validation, and review requirements. | P1 | medium | high | BOOT-018 | done | sequential | Documentation Curator |
| BOOT-020 | Define artifact impact map | After `SPEC-BOOT-003` is approved or activated and BOOT-019 is complete, add reviewed impact mapping so changed files determine required reads, writes, validation, review, and not-impacted artifacts. | P1 | medium | high | BOOT-019; SPEC-BOOT-003 approved or active | done | sequential | Documentation Curator, QA Reviewer |
| BOOT-021 | Define validation modes and evidence envelope | After `SPEC-BOOT-003` is approved or activated and BOOT-020 is complete, add approved guidance for fast, standard, and strict validation modes plus durable operation evidence records. | P1 | medium | high | BOOT-020; SPEC-BOOT-003 approved or active | done | sequential | QA Reviewer, Documentation Curator |
| BOOT-022 | Update current-state and handoff policy | After `SPEC-BOOT-003` is approved or activated and BOOT-021 is complete, add reviewed policy for compact current truth, durable evidence references, and handoff compression without losing active operational facts. | P1 | medium | high | BOOT-021; SPEC-BOOT-003 approved or active | done | sequential | Documentation Curator |
| BOOT-023 | Add structural validator support | Add path/profile structural validator checks and red-check fixtures only after `SPEC-BOOT-003` is approved or activated and impact/evidence rules are stable. | P1 | medium | high | BOOT-021, BOOT-022; SPEC-BOOT-003 approved or active | done | sequential | QA Reviewer |
| BOOT-024 | Measure governance routing performance | After `SPEC-BOOT-003` is approved or activated and BOOT-019 through BOOT-023 are complete, benchmark representative small and medium operations to confirm time and token savings without new review, traceability, or handoff regressions. | P2 | medium | medium | BOOT-019 through BOOT-023; SPEC-BOOT-003 approved or active | done | sequential | QA Reviewer, Documentation Curator |
| BOOT-025 | Package public launch readiness assets | Add additive launch checklist, release-note draft, example/demo assets, social drafts, issue templates, seed issue drafts, token-efficiency guidance, minimal CLI proposal, and required review/state records without changing product behavior or governance mechanics. | P1 | medium | medium | SPEC-BOOT-004 | done | sequential | Documentation Curator, Adversarial PR Reviewer |
| BOOT-026 | Restore validator-passing state on the PR #5 branch | Re-add the 15-line metadata block on `README.md` that was removed in `9de53e0` and update `AI_HANDOFF.md` `## Current Branch` to match the actual worktree branch so the bootstrap validator exits 0 and the Phase 0 mechanic commit can land. | P1 | low | low | SPEC-BOOT-002 | done | sequential | Implementation Agent |
| BOOT-027 | Phase 0 validator scope and AWK first-block fix | Update `SCRIPTS/validate-bootstrap.sh` find commands to `-prune` `.claude/` and `research/` so generated agent state and disposable research output are not scanned. Remove the `checked_first = 1; exit` pair in the AWK so every `## Pre-Change Classification` block in `AI_HANDOFF.md` is inspected. Add three red-check fixtures (`case_research_dir_does_not_trip_validator`, `case_claude_worktree_does_not_trip_validator`, `case_protected_planning_misclassified_in_second_block`) plus a new `expect_no_failure_mentioning` helper. | P0 | low | medium | SPEC-BOOT-003 | done | sequential | Implementation Agent, Adversarial PR Reviewer |

## External Ticket Workflow

If Linear, GitHub Issues, or another external tracker is available, use local
backlog items as drafts until tickets are actually created. Markdown remains
authoritative until ticket existence is confirmed.

Tracker availability requires all of:

- the user authorizes tracker use
- an integration, CLI, or API is installed and usable
- the agent can read or create tickets with command or tool evidence

Ticket confirmation requires one of:

- a real ticket ID or URL returned by the integration
- successful CLI or API output
- an authoritative repository artifact recording confirmed ticket evidence

Do not claim external tickets exist from draft titles, planned descriptions, or
chat claims alone.

Each Linear-ready backlog item should include:

- title
- purpose
- user or system value
- scope
- linked spec
- linked acceptance criteria
- related ADR
- dependencies
- risks
- suggested owner role
- estimated complexity
- implementation phase
- related files or modules if known
- priority
- readiness status
- test expectations
- definition of done
- parallelization status
- file ownership boundaries
