artifact_id: ART-BACKLOG-001
title: Backlog
type: backlog
status: active
version: v1.0
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

## Linear Workflow

If Linear is available, use local backlog items as drafts until tickets are
actually created. Do not claim Linear tickets exist unless the integration
confirms them.

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

