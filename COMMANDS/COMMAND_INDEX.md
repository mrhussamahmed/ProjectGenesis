artifact_id: ART-COMMAND-INDEX
title: Command Index
type: command-index
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

# Command Index

Reusable command prompts live in this folder. Commands are shortcuts for common
workflows, not source-of-truth governance.

## Commands

| Command | Purpose | Status |
|---------|---------|--------|
| `COMMAND_TEMPLATE.md` | Template for future workflow prompts. | active |

## Rules

- Commands must declare required role, required reads, inputs, outputs, stop
  conditions, validation, and authority limit.
- Commands cannot override `CONTEXT_INDEX.md`, shared agent rules, selected
  role files, specs, ADRs, registry, traceability, current state, or handoff.
- Add command files only when the workflow is stable enough to reuse.
