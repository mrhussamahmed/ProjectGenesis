artifact_id: ART-COMMAND-INDEX
title: Command Index
type: command-index
status: active
version: v2.0
created: 2026-05-13
updated: 2026-06-10
owner: AI Bootstrap Maintainers
source: SPEC-BOOT-002 and SPEC-BOOT-003
linked_specs: [SPEC-BOOT-002, SPEC-BOOT-003]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Command Index

Reusable command prompts live in this folder. Commands are shortcuts for common
workflows, not source-of-truth governance. Commands must use
`OPERATION_ROUTING.md` for classification, read tiers, impact mapping,
validation mode, and durable evidence.

## Commands

| Command | Purpose | Status |
|---------|---------|--------|
| `COMMAND_TEMPLATE.md` | Template for future workflow prompts. | active |
| `start-requirement-breakdown.md` | Runs the downstream project intake and requirement breakdown workflow from `00_intake/raw/`. Trigger: `Start requirement breakdown`. | active |
| `validate-idea.md` | Researches and validates high-risk assumptions with cited evidence; strengthens the value proposition. Trigger: `Validate the idea`. | active |
| `start-architecture-design.md` | Produces a tech design plus slim ADRs from validated intent. Trigger: `Start architecture design`. | active |
| `implement-next-story.md` | Executes the next ready story with scoped checks only. Trigger: `Implement next story`. | active |
| `resume-work.md` | Reconstructs context from session and state files with minimum reads. Trigger: `Resume work`. | active |
| `export-backlog-to-linear.md` | Exports Linear-ready items to Linear without duplicates. Trigger: `Export backlog to Linear`. | active |

## Recognized User Triggers

| Trigger | Command |
|---------|---------|
| `Start requirement breakdown` | `COMMANDS/start-requirement-breakdown.md` |
| `Start requirement breakdown.` | `COMMANDS/start-requirement-breakdown.md` |
| `Run requirement breakdown` | `COMMANDS/start-requirement-breakdown.md` |
| `Run project intake` | `COMMANDS/start-requirement-breakdown.md` |
| `Kick off project intake` | `COMMANDS/start-requirement-breakdown.md` |
| `Validate the idea` | `COMMANDS/validate-idea.md` |
| `Run idea validation` | `COMMANDS/validate-idea.md` |
| `Start architecture design` | `COMMANDS/start-architecture-design.md` |
| `Implement next story` | `COMMANDS/implement-next-story.md` |
| `Implement next item` | `COMMANDS/implement-next-story.md` |
| `Resume work` | `COMMANDS/resume-work.md` |
| `Export backlog to Linear` | `COMMANDS/export-backlog-to-linear.md` |

## Rules

- Commands must declare required role, required reads, inputs, outputs, stop
  conditions, validation, and authority limit.
- Commands cannot override `CONTEXT_INDEX.md`, `OPERATION_ROUTING.md`, shared
  agent rules, selected role files, specs, ADRs, registry, traceability,
  current state, or handoff.
- Add command files only when the workflow is stable enough to reuse.
- When a user gives a short workflow phrase, match exact or unambiguous triggers
  here before asking for clarification. If the trigger or required input is
  ambiguous, ask for clarification.
