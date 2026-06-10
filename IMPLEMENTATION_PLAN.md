artifact_id: ART-IMPL-PLAN-001
title: Implementation Plan
type: implementation-plan
status: active
version: v6.0
created: 2026-05-09
updated: 2026-06-11
owner: AI Bootstrap Maintainers
source: ProjectGenesis bootstrap scaffold; reset to current truth for the GEN-01..16 improvement program (prior history in git and MAINTAINER_ARCHIVE/snapshots/)
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Implementation Plan

Scaffold baseline is complete: clean scaffold boundary slices 1-5,
split-state handoff (BOOT-STATE-001), and AI green-merge
(BOOT-GREEN-MERGE-001) are merged to `main`.

## Current Phase

| Phase | Status | Notes |
|-------|--------|-------|
| Clean scaffold boundary (slices 1-5) | done | Merged through PR #20; cleanup commits `05f01f2` and `2fee759`. |
| Split-state handoff (BOOT-STATE-001) | done | Merged via PR #21 at `d4b5161`. |
| AI green-merge (BOOT-GREEN-MERGE-001) | done | Merged via PRs #22/#23. |
| GEN-01..16 improvement program (Linear HUS-219..235) | done | Merged via PR #24. Single read contract, risk-tiered review, evidence diet, CI tiering, session fast path, handoff compaction, backlog truth, manifest truth and deletions, Linear contract, research and architecture paths, pipeline commands. |

## Next

| Item | Status | Notes |
|------|--------|-------|
| GEN-17 / HUS-235 P2 batch | done | Delivered via PR #25: example schema alignment with tech-design/ADR exemplars, diagram-role consolidation, TEST_PLAN merge plus benchmark baseline refresh (77/77), pre-commit secret-scan hygiene, prune-history rotation tool, registry column de-dup, and the validator bundle (vocabulary, floor split, scoped scan, state-sync level, state injection, link integrity). |

## Conventions

- This file is a replace-in-place snapshot of current implementation truth.
- Per-branch progress lives in PR evidence and `.ai/SESSION.md`, never here.
- Prior plan history lives in git and
  `MAINTAINER_ARCHIVE/snapshots/IMPLEMENTATION_PLAN.md-2026-05-16-pre-slice-3.md`.
