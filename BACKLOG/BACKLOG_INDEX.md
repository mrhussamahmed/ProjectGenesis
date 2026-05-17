artifact_id: ART-BACKLOG-INDEX
title: Backlog Index
type: backlog-index
status: active
version: v4.1
created: 2026-05-09
updated: 2026-05-17
owner: AI Bootstrap Maintainers
source: ProjectGenesis bootstrap scaffold; slice 3 required-reading shrink (full prior history preserved at MAINTAINER_ARCHIVE/snapshots/BACKLOG_INDEX-2026-05-16-pre-slice-3.md)
linked_specs: []
linked_tickets: [BOOT-STATE-001]
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Backlog Index

Detailed backlog items can be stored in this folder. The bootstrap
upstream's legacy backlog items are archived under
`MAINTAINER_ARCHIVE/BACKLOG/` (see also
`MAINTAINER_ARCHIVE/snapshots/BACKLOG_INDEX-2026-05-16-pre-slice-3.md`).

## Items

| Item ID | Title | File | Status | Priority | Complexity | Risk | Linked Spec | Parallelization |
|---------|-------|------|--------|----------|------------|------|-------------|-----------------|
| BOOT-STATE-001 | Split-State Handoff Boundary | `BACKLOG/BOOT-STATE-001-split-state-handoff.md` | in-review | P1 | high | high | none; recurring bootstrap-governance exception in `PR_MERGE_POLICY.md` | not-allowed |

## Rules

- Every backlog item must link to a spec, explicitly be a discovery task that
  creates one, or cite a named bootstrap-governance exception permitted by
  `PR_MERGE_POLICY.md`.
- Sequence by dependency and implementation order.
- Mark items as Linear-ready drafts unless a real ticket has been created.
