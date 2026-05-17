artifact_id: ART-BACKLOG-001
title: Backlog
type: backlog
status: active
version: v4.1
created: 2026-05-09
updated: 2026-05-17
owner: AI Bootstrap Maintainers
source: ProjectGenesis bootstrap scaffold; slice 3 required-reading shrink (full prior history preserved at MAINTAINER_ARCHIVE/snapshots/BACKLOG.md-2026-05-16-pre-slice-3.md)
linked_specs: []
linked_tickets: [BOOT-STATE-001]
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Backlog

This file mirrors the current highest-level backlog. Detailed items can live
under `BACKLOG/`. ProjectGenesis legacy `BOOT-*` items are archived under
`MAINTAINER_ARCHIVE/BACKLOG/`.

## Current Backlog

| Item | Status | Priority | Notes |
|------|--------|----------|-------|
| `BOOT-STATE-001` | in-review | P1 | Split canonical, PR, and local session state so branch/session-specific AI handoff data does not drift into committed project truth. Local implementation checks pass; CI and fresh adversarial review are pending. |

## Conventions

- Use a short, stable ticket prefix chosen by the product owner.
- Register every backlog item in `BACKLOG/BACKLOG_INDEX.md`.
- Use `BACKLOG/templates/BACKLOG_ITEM_TEMPLATE.md` to draft new items.
- Link backlog items to specs, ADRs, traceability rows, tests, and reviews.

## External Ticket Workflow

Linear or another tracker may be added later. Until then, the Markdown
backlog under `BACKLOG/` is authoritative.
