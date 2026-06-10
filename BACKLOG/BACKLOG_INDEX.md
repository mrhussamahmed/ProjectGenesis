artifact_id: ART-BACKLOG-INDEX
title: Backlog Index
type: backlog-index
status: active
version: v5.0
created: 2026-05-09
updated: 2026-06-10
owner: AI Bootstrap Maintainers
source: ProjectGenesis bootstrap scaffold; slice 3 required-reading shrink (full prior history preserved at MAINTAINER_ARCHIVE/snapshots/BACKLOG_INDEX-2026-05-16-pre-slice-3.md); BOOT-GREEN-MERGE-001; GEN-10 Linear contract and granularity rules
linked_specs: []
linked_tickets: [BOOT-STATE-001, BOOT-GREEN-MERGE-001]
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
| BOOT-STATE-001 | Split-State Handoff Boundary | `BACKLOG/BOOT-STATE-001-split-state-handoff.md` | done | P1 | high | high | none; recurring bootstrap-governance exception in `PR_MERGE_POLICY.md` | not-allowed |
| BOOT-GREEN-MERGE-001 | AI Green-Merge For Bootstrap Scaffold Usability | `BACKLOG/BOOT-GREEN-MERGE-001-ai-green-merge-scaffold-usability.md` | done | P1 | medium | medium | none; recurring bootstrap-governance exception in `PR_MERGE_POLICY.md` | not-allowed |

## Rules

- Every backlog item must link to a spec, explicitly be a discovery task that
  creates one, or cite a named bootstrap-governance exception permitted by
  `PR_MERGE_POLICY.md`.
- Sequence by dependency and implementation order.
- Item frontmatter readiness is the single status authority; index rows mirror it.
- Granularity rules:
  1. Tests and validation expectations live inside the story (Test
     Expectations + Definition of Done), never as sibling tickets.
  2. At most one validation ticket per slice or spec, scoped to cross-story
     integration validation no single story owns.
  3. Re-running checks after a change is evidence in the PR body or
     TEST_RESULTS.md baseline, never a new ticket.
  4. Before creating any candidate, search the backlog index for an existing
     item covering the same requirement and extend it instead of duplicating.
- An item is Linear-ready when every field in the mapping table below derives
  from its frontmatter. `COMMANDS/export-backlog-to-linear.md` performs the
  export. Markdown stays authoritative until `tracker.id_or_url` records a
  real ticket URL with evidence.

## Linear Mapping

| Frontmatter Field | Linear Mapping |
|-------------------|----------------|
| priority | P0=Urgent, P1=High, P2=Medium, P3=Low |
| readiness not-ready | Backlog |
| readiness ready | Todo |
| readiness in-progress | In Progress |
| readiness in-review | In Review |
| readiness done | Done |
| readiness blocked | label `status:blocked` |
| estimate (1, 2, 3, 5, 8) | Linear points |
| item_type, risk | labels `type:<item_type>`, `risk:high` |
