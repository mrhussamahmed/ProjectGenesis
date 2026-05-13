artifact_id: ART-COMMAND-TEMPLATE
title: Command Template
type: command-template
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

# Command Template

## Purpose

Describe the reusable workflow this command triggers.

## Required Role

Name the primary `memory/ai/ROLE_*.md` file.

## Required Files To Read

- `memory/ai/SHARED_AGENT_RULES.md`
- selected role file
- `CONTEXT_INDEX.md`
- task-specific source-of-truth files

## Inputs

- user instruction
- linked source, spec, backlog item, review, or artifact IDs

## Outputs

- changed artifacts or review output expected from this workflow

## Stop Conditions

- missing source-of-truth evidence
- conflicting authoritative files
- implementation requested without approved or active spec
- risk requires a different role or review path

## Validation

- `bash SCRIPTS/validate-bootstrap.sh`
- task-specific checks defined by the active spec or backlog item

## Authority Limit

This command is a workflow shortcut. It cannot override repository governance,
approved or active specs, accepted ADRs, `CONTEXT_INDEX.md`, selected role
files, `ARTIFACT_REGISTRY.md`, `TRACEABILITY_MATRIX.md`, `CURRENT_STATE.md`, or
`AI_HANDOFF.md`.
