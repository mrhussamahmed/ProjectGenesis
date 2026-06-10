artifact_id: ART-COMMAND-EXPORT-BACKLOG-TO-LINEAR
title: Export Backlog To Linear
type: command
status: active
version: v1.0
created: 2026-06-10
updated: 2026-06-10
owner: AI Bootstrap Maintainers
source: GEN-16 pipeline commands; GEN-10 Linear contract
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Export Backlog To Linear

## Purpose

Turn Linear-ready backlog items into real Linear issues deterministically:
map item frontmatter to Linear fields, never create duplicates, and write
back exactly one evidence field per item. Markdown remains authoritative
until a real issue URL exists.

Recognized user triggers: `Export backlog to Linear`, `Create Linear
tickets`, `Sync backlog to Linear`.

## Required Role

- `memory/ai/ROLE_BACKLOG_PLANNER.md`

## Required Files To Read

- `memory/ai/SHARED_AGENT_RULES.md`
- `memory/ai/ROLE_BACKLOG_PLANNER.md`
- `BACKLOG/BACKLOG_INDEX.md` (Rules section holds the field mapping table)
- The backlog item files selected for export

## Inputs

- The user trigger, optionally scoping to specific item IDs or an epic.
- A configured Linear integration (MCP, CLI, or API) with team and project.
- Items whose frontmatter is complete per the Linear contract (item_type,
  priority, estimate, readiness, acceptance criteria).

## Workflow

1. Verify a Linear integration is available. If none exists, stop and offer
   the export-ready text blocks instead; never claim tickets exist.
2. Select items: requested scope, else all `readiness: ready` items without
   `tracker.id_or_url`.
3. Map fields per the `BACKLOG/BACKLOG_INDEX.md` mapping table: priority
   P0-P3 to Urgent/High/Medium/Low; readiness to Linear status; estimate to
   points; item_type and risk to labels. Epics become parent issues;
   features, stories, spikes, and validation items become issues under their
   `parent`. Description = Purpose + inline Acceptance Criteria + Test
   Expectations. Dependencies map to blocked-by relations.
4. Dedupe: any item with `tracker.id_or_url` set is updated, never recreated;
   search the target project by title before creating.
5. Write back per item: set `tracker: {name: linear, id_or_url, evidence}` in
   the item frontmatter and mirror the index row. No other file updates per
   issue.

## Outputs

- Linear issues with recorded URLs, or export-ready text when no integration.
- Updated item frontmatter `tracker` fields and matching index rows.

## Stop Conditions

- No Linear integration and the user wants real tickets; report, do not fake.
- An item lacks required frontmatter or acceptance criteria; report it as
  not Linear-ready instead of exporting noise.
- The target team or project is ambiguous; ask once, then proceed.

## Validation

- `bash SCRIPTS/validate-bootstrap.sh` (backlog consistency checks)
- `git diff --check`

## Authority Limit

This command is a workflow shortcut. It cannot claim external tickets exist
without recorded URL evidence, cannot change item scope or priority during
export, and cannot override repository governance, approved or active specs,
accepted ADRs, `CONTEXT_INDEX.md`, selected role files,
`OPERATION_ROUTING.md`, `ARTIFACT_REGISTRY.md`, `TRACEABILITY_MATRIX.md`,
`CURRENT_STATE.md`, or `AI_HANDOFF.md`.
