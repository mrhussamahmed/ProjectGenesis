artifact_id: ART-INTAKE-INDEX
title: Intake Index
type: intake-index
status: active
version: v1.2
created: 2026-05-13
updated: 2026-06-11
owner: AI Bootstrap Maintainers
source: SPEC-BOOT-002; GEN-11 research-note workflow step; BOOT-RESEARCH-001 research-orchestration workflow step
linked_specs: [SPEC-BOOT-002]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Intake Index

This index tracks intake processing across raw sources, summaries,
requirements, specs, backlog items, and open questions.

## Intake Status

| Source ID | Raw Source | Summary | Requirements Extracted | Open Questions | Linked Specs | Status |
|-----------|------------|---------|------------------------|----------------|--------------|--------|
| none | none | none | none | none | none | No intake sources processed yet. |

## Intake Workflow

1. Add raw material under `00_intake/raw/`.
2. Register the file in `00_intake/SOURCE_REGISTRY.md`.
3. Summarize the source under `00_intake/summaries/` using
   `00_intake/summaries/SUMMARY_TEMPLATE.md`.
4. Extract requirement candidates into `02_requirements/REQUIREMENTS_INDEX.md`.
5. Record assumptions and risks in the requirement registers.
6. For high-risk or scope-defining assumptions, write research notes under
   `00_intake/research/` (see `COMMANDS/validate-idea.md`) and register them
   as `research-note` sources.
7. For new or scope-shifting ideas, run `COMMANDS/start-research.md`: it
   plans research depth and tracks, runs focused research, critic review,
   and synthesis, and produces a research brief under `00_intake/research/`.
   Requirements and specs derived from research must cite the accepted
   brief's SRC- ID, never raw research reports.
8. Create or update specs only after evidence and readiness are clear.

## Rules

- `00_intake/raw/` is the canonical raw intake folder. It holds messy source
  material as-is and is exempt from bootstrap metadata and placeholder
  validation.
- Do not treat unprocessed raw files as confirmed requirements.
- Use open questions when intake conflicts or missing information would change
  scope, security, architecture, data model, release safety, or priority.
