---
artifact_id: ART-BACKLOG-001
title: Backlog
type: backlog
status: active
version: v0.1
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

# Backlog

This file mirrors the current highest-level backlog. Detailed items can live
under `BACKLOG/`.

## Status

No active or proposed backlog items yet.

## Conventions

- Use a short, stable ticket prefix (for example `<PRJ>-001`) chosen by the
  product owner.
- Register every backlog item in `BACKLOG/BACKLOG_INDEX.md`.
- Use `BACKLOG/templates/BACKLOG_ITEM_TEMPLATE.md` to draft new items.
- Link backlog items to specs, ADRs, traceability rows, tests, and reviews.

## How To Add The First Item

1. Pick a short ticket prefix.
2. Create a new file `BACKLOG/<PRJ>-001-<short-slug>.md` from
   `BACKLOG/templates/BACKLOG_ITEM_TEMPLATE.md`.
3. Register the item in `BACKLOG/BACKLOG_INDEX.md`.
4. Update this file's status section above.

## Notes

This file was created from `TEMPLATE_STARTERS/BACKLOG.md`. It contains no
prior project history.
