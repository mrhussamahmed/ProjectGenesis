artifact_id: ART-INTAKE-SOURCE-REGISTRY
title: Source Registry
type: source-registry
status: active
version: v1.1
created: 2026-05-13
updated: 2026-06-10
owner: AI Bootstrap Maintainers
source: SPEC-BOOT-002; GEN-11 url and research-note source types
linked_specs: [SPEC-BOOT-002]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Source Registry

This registry assigns stable IDs to raw project input. Raw materials belong in
`00_intake/raw/`. Summaries belong in `00_intake/summaries/`. Research notes
belong in `00_intake/research/`.

## Source Types

- `file` — local material under `00_intake/raw/`; File Path is the repo path.
- `url` — external web evidence; File Path holds the URL.
- `research-note` — agent research output in `00_intake/research/` written
  from `00_intake/research/RESEARCH_NOTE_TEMPLATE.md`.

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
- `url` sources must record an access date in the Notes column.
- Research notes get SRC- IDs like any other source; the registered SRC-ID
  is what makes `verified external` assumption approval evidence checkable.
- Do not remove a source row when a file becomes stale; update freshness.
- Do not summarize sensitive material beyond the minimum needed for traceability.
- Record conflicts in `OPEN_QUESTIONS.md` or `STALE_ITEMS.md` when they affect
  requirements, architecture, backlog, or implementation priority.
