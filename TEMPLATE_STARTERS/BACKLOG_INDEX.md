---
artifact_id: ART-BACKLOG-INDEX
title: Backlog Index
type: backlog-index
status: active
version: v0.2
created: YYYY-MM-DD
updated: YYYY-MM-DD
owner: <Project Name> Maintainers
source: Initial bootstrap scaffold
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true
---

# Backlog Index

This index lists detailed backlog items kept under `BACKLOG/`. The top-level
`BACKLOG.md` is a pointer file with no item statuses.

## Items

| Item ID | Title | File | Status | Priority | Complexity | Risk | Linked Spec | Parallelization |
|---------|-------|------|--------|----------|------------|------|-------------|-----------------|
| none | none | none | none | none | none | none | none | No backlog items registered yet. |

## Rules

- Every backlog item must link to a spec or explicitly be a discovery task
  that creates one.
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

## Notes

This file was created from `TEMPLATE_STARTERS/BACKLOG_INDEX.md`. It contains
no prior project history.
