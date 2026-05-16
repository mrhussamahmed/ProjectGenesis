artifact_id: ART-IMPL-PLAN-001
title: Implementation Plan
type: implementation-plan
status: active
version: v4.0
created: 2026-05-09
updated: 2026-05-16
owner: AI Bootstrap Maintainers
source: ProjectGenesis bootstrap scaffold; slice 3 required-reading shrink (full prior history preserved at MAINTAINER_ARCHIVE/snapshots/IMPLEMENTATION_PLAN.md-2026-05-16-pre-slice-3.md)
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Implementation Plan

Current implementation phase: Clean Scaffold Boundary follow-on slices.

## Current Phase

| Slice | Status | Branch | PR | Description |
|-------|--------|--------|----|-------------|
| 1 | done (merged) | claude/hungry-cannon-369742 | #14 (merged `02d4d85`) | TEMPLATE_MANIFEST.md + TEMPLATE_STARTERS/. |
| 2 | in-review | claude/slice-2-clean-raw-root | #15 | Relocate ProjectGenesis maintainer history to `MAINTAINER_ARCHIVE/`. |
| 3 | in-progress | claude/slice-3-shrink-required-reading | (this slice) | Shrink required-reading files; archive accumulated history. |
| 4 | proposed | claude/slice-4-fast-path-validation | (later) | Codify adaptive governance routing fast-path discipline. |

## Phase Backlog

| Item | Status | Notes |
|------|--------|-------|
| Slice 4 fast-path validation discipline | proposed | Codify the small-change exemption from full bootstrap validation as a real routing rule referenced by `OPERATION_ROUTING.md`. |

## Phase Plan

After slice 4 merges, the bootstrap scaffold's clean-scaffold-boundary plan is
fully delivered. Further phases (downstream product implementation, parallel
work enablement, etc.) are out of scope for the bootstrap-cleanup arc.

The bootstrap upstream's legacy Phase 1 implementation plan is archived
under `MAINTAINER_ARCHIVE/snapshots/IMPLEMENTATION_PLAN.md-2026-05-16-pre-slice-3.md`.
