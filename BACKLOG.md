artifact_id: ART-BACKLOG-001
title: Backlog
type: backlog
status: active
version: v1.8
created: 2026-05-09
updated: 2026-05-13
owner: AI Bootstrap Maintainers
source: Initial bootstrap scaffold, public repository publication request, ProjectGenesis PR merge, and README positioning/tooling prerequisite update
linked_specs: [SPEC-BOOT-002]
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
| BOOT-017 | Improve README positioning and tooling prerequisites | Clarify ProjectGenesis capabilities, audience fit, Linear backlog storage, Linear setup, optional Spec Kit use, and other supported tooling before downstream project work starts. | P2 | low | low | BOOT-016 | in-review | sequential | Documentation Curator, DevOps Release Reviewer |

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
