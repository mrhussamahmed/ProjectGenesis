artifact_id: ART-INPUT-LEGACY-README
title: Input Legacy Alias
type: guide
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
authoritative: false

# Input Legacy Alias

`INPUT/` is kept as a compatibility path for older prompts and agents.

New raw project material should be placed in:

```text
00_intake/raw/
```

Agents that find files in `INPUT/` should register them in
`00_intake/SOURCE_REGISTRY.md`, summarize them under `00_intake/summaries/`,
and preserve the original file unless a reviewed migration says otherwise.
