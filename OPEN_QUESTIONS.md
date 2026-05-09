artifact_id: ART-STATE-004
title: Open Questions
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

# Open Questions

Open questions capture missing information that would cause wrong product
direction, security risk, compliance risk, major rework, or unsafe
implementation.

| ID | Question | Blocks | Owner | Status | Resolution |
|----|----------|--------|-------|--------|------------|
| OQ-001 | Should this bootstrap package repository be initialized and committed as its own Git repo? | Repository hygiene only | User or maintainer | resolved | Git was initialized on `main`; baseline commit remains recommended. |
| OQ-002 | What product input should be used for the first downstream project scaffold? | First product spec | User | open | Pending product idea, PRD, feature list, or file. |
| OQ-003 | Will Linear be available for the downstream project? | Ticket creation only | User or maintainer | open | If unavailable, Markdown backlog remains authoritative. |

## Rules

- Do not invent answers to open questions.
- If a question blocks implementation, create a backlog item or spike.
- When resolved, move the answer into the relevant spec, architecture, ADR,
  backlog item, and traceability row.
