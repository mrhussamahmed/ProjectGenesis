artifact_id: ART-GETTING-STARTED
title: Getting Started
type: guide
status: authoritative
version: v1.0
created: 2026-05-13
updated: 2026-05-13
owner: AI Bootstrap Maintainers
source: Migrated from legacy RTF onboarding notes under start here/
linked_specs: [SPEC-BOOT-002]
linked_tickets: []
linked_adrs: []
replaces: start here/Project starting instruction tips.rtf
replaced_by:
authoritative: true

# Getting Started

Use this scaffold as a clean reusable master, then copy it into each new
software project.

## One-Time Setup

Keep this repository as the reusable bootstrap master. Improve it only when you
are changing the operating model itself.

## New Project Flow

1. Create a new empty project folder.
2. Initialize Git in that folder.
3. Copy the bootstrap scaffold files into the new project folder.
4. Open Codex, Claude, or another agent inside the new project folder.
5. Add raw project material under `00_intake/raw/`.
6. Ask the agent to follow `NEW_PROJECT_INITIALIZATION.md`.
7. Review generated product context, specs, architecture, backlog, tests,
   traceability, and handoff before implementation.
8. Start implementation only after the first backlog item satisfies Definition
   of Ready.

## Do Not Leak Project Details Back Into The Master

Project-specific requirements, specs, ADRs, backlog items, source files, and
customer context belong in the downstream project repository. They should not
be copied back into this reusable scaffold unless they improve the generic
operating model.

## First Implementation Prompt

After reviewing generated specs and backlog in the downstream project, ask the
agent to implement the first ready backlog item. The agent must read the active
spec, backlog item, test plan, branch guide, traceability matrix, current
state, and handoff before coding.
