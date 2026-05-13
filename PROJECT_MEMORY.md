artifact_id: ART-STATE-001
title: Project Memory
type: shared-state
status: active
version: v1.0
created: 2026-05-09
updated: 2026-05-09
owner: AI Bootstrap Maintainers
source: Initial bootstrap scaffold
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Project Memory

This file summarizes durable project context for AI agents. It is not the
highest source of truth. When this file conflicts with specs, architecture,
ADRs, backlog, code, tests, `CURRENT_STATE.md`, or `AI_HANDOFF.md`, follow the
higher-priority source and update this summary later.

## Project Purpose

This repository contains a reusable AI autonomous development bootstrap package.
It prepares future projects for spec-driven, test-driven, traceable,
reviewable, multi-agent development.

## Durable Decisions

- Neutral files, not agent-specific files, hold shared project state.
- `CLAUDE.md` and `AGENTS.md` remain short and point to canonical docs.
- Implementation requires an approved or active spec unless provisional risk is
  recorded.
- Every PR requires fresh-context adversarial review.
- Parallel AI work is disabled by default until specs, file ownership, and
  contracts prove it is safe.

## Current Scope

The bootstrap is stack-neutral. It does not select a frontend, backend,
database, hosting provider, Linear workspace, or CI tool beyond optional
GitHub Actions templates.

## Known Non-Goals

- Do not copy reference project product domain logic.
- Do not hardcode a Linear workspace or issue prefix.
- Do not install heavy local hooks by default.
- Do not use chat history as a durable source of truth.

## Maintenance Notes

Keep this file concise. Move detailed current status to `CURRENT_STATE.md`,
handoff details to `AI_HANDOFF.md`, artifact lifecycle to
`ARTIFACT_REGISTRY.md`, and requirements to specs.

