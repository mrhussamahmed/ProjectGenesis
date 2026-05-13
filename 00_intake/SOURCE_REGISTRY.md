artifact_id: ART-INTAKE-SOURCE-REGISTRY
title: Source Registry
type: source-registry
status: active
version: v1.0
created: 2026-05-13
updated: 2026-05-13
owner: AI Bootstrap Maintainers
source: SPEC-BOOT-002
linked_specs: [SPEC-BOOT-002]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Source Registry

This registry assigns stable IDs to raw project input. Raw materials belong in
`00_intake/raw/`. Summaries belong in `00_intake/summaries/`.

## Sources

| Source ID | File Path | Type | Owner | Added | Freshness | Processing State | Sensitivity | Summary | Notes |
|-----------|-----------|------|-------|-------|-----------|------------------|-------------|---------|-------|
| none | none | none | none | none | none | none | none | none | No source files registered yet. |

## Allowed Freshness Values

- active
- stale
- superseded
- archived
- ignored
- conflicting

## Allowed Processing States

- pending
- summarized
- extracted
- blocked
- ignored

## Rules

- Assign source IDs sequentially using `SRC-001`, `SRC-002`, and so on.
- Do not remove a source row when a file becomes stale; update freshness.
- Do not summarize sensitive material beyond the minimum needed for traceability.
- Record conflicts in `OPEN_QUESTIONS.md` or `STALE_ITEMS.md` when they affect
  requirements, architecture, backlog, or implementation priority.
