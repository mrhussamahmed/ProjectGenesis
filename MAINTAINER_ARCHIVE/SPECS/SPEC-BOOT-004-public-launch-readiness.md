artifact_id: ART-SPEC-BOOT-004
title: Public Launch Readiness
type: spec
status: approved
version: v1.0
created: 2026-05-14
updated: 2026-05-14
owner: ProjectGenesis Maintainers
source: User request for public launch readiness and adoption packaging, 2026-05-14
linked_specs: [SPEC-BOOT-004]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# SPEC-BOOT-004: Public Launch Readiness

## Purpose

Prepare ProjectGenesis for public discovery, reuse, and sharing by adding
launch packaging around examples, demo material, GitHub launch steps, issue
templates, release notes, token-efficiency guidance, seed contribution issues,
and a minimal CLI proposal.

This spec authorizes only additive Markdown-first launch packaging. It does not
authorize product redesign, README rewrite, governance weakening, validator
changes, hook changes, role changes, command-framework changes, or product
implementation.

## Source

- `USER-2026-05-14-LAUNCH`: user request for public launch readiness and
  adoption packaging.
- `README.md`: current public positioning baseline.
- `GITHUB_REPOSITORY_SETUP.md`: existing GitHub setup guidance.
- `RELEASE_READINESS.md`: existing general release readiness guidance.
- `OPERATION_ROUTING.md`: operation profile, validation, and evidence rules.

## Functional Requirements

| ID | Requirement | Requirement IDs | Source IDs | Confidence | Status | Priority |
|----|-------------|-----------------|------------|------------|--------|----------|
| BOOT4-FR-001 | Provide a public launch checklist with GitHub About description, topics, template repository steps, release checklist, issue checklist, demo checklist, social checklist, feedback checklist, and manual UI steps. | BOOT4-REQ-001 | USER-2026-05-14-LAUNCH | high | confirmed | P1 |
| BOOT4-FR-002 | Provide public alpha release notes draft for suggested tag `v0.1.0-public-alpha`. | BOOT4-REQ-002 | USER-2026-05-14-LAUNCH | high | confirmed | P1 |
| BOOT4-FR-003 | Provide an illustrative simple SaaS demo example with raw input and expected outputs that separate confirmed, inferred, assumed, open-question, risk, backlog, validation, initial-scope, and deferred AI-reminder content. | BOOT4-REQ-003 | USER-2026-05-14-LAUNCH | high | confirmed | P1 |
| BOOT4-FR-004 | Provide a 60-second demo script with screen plan, spoken script, agent instruction, before/after shots, terminal commands, and final repo-truth message. | BOOT4-REQ-004 | USER-2026-05-14-LAUNCH | high | confirmed | P1 |
| BOOT4-FR-005 | Provide low-hype social launch drafts, GitHub tagline options, and quoteable one-liners. | BOOT4-REQ-005 | USER-2026-05-14-LAUNCH | high | confirmed | P2 |
| BOOT4-FR-006 | Provide GitHub issue templates for bug reports, feature requests, example requests, documentation improvements, and issue-template config. | BOOT4-REQ-006 | USER-2026-05-14-LAUNCH | high | confirmed | P1 |
| BOOT4-FR-007 | Provide ready-to-copy seed GitHub issue drafts for launch follow-up work without claiming external issues exist. | BOOT4-REQ-007 | USER-2026-05-14-LAUNCH | high | confirmed | P2 |
| BOOT4-FR-008 | Provide token-efficiency guidance specific to ProjectGenesis mechanics without allowing token saving to bypass safety. | BOOT4-REQ-008 | USER-2026-05-14-LAUNCH; SPEC-BOOT-003 | high | confirmed | P1 |
| BOOT4-FR-009 | Provide a minimal CLI/bootstrap proposal without implementing a CLI. | BOOT4-REQ-009 | USER-2026-05-14-LAUNCH | high | confirmed | P2 |
| BOOT4-FR-010 | Add only a tiny README link section if useful for discoverability and avoid rewriting existing README positioning. | BOOT4-REQ-010 | USER-2026-05-14-LAUNCH; README.md | high | confirmed | P2 |

## Non-Functional Requirements

| ID | Requirement | Requirement IDs | Source IDs | Confidence | Status | Priority |
|----|-------------|-----------------|------------|------------|--------|----------|
| BOOT4-NFR-001 | Preserve existing governance, validation, traceability, review policy, hooks, command framework, context-pack authority, and agent operating rules. | BOOT4-NFR-REQ-001 | USER-2026-05-14-LAUNCH | high | confirmed | P0 |
| BOOT4-NFR-002 | Keep launch assets Markdown-first unless an existing repository pattern requires a small non-Markdown config file. | BOOT4-NFR-REQ-002 | USER-2026-05-14-LAUNCH | high | confirmed | P1 |
| BOOT4-NFR-003 | Do not claim GitHub settings, releases, seed issues, or demo video publication unless completed through authenticated tooling or manual confirmation. | BOOT4-NFR-REQ-003 | USER-2026-05-14-LAUNCH | high | confirmed | P1 |
| BOOT4-NFR-004 | Label illustrative example outputs clearly and avoid fake generated-output claims. | BOOT4-NFR-REQ-004 | USER-2026-05-14-LAUNCH | high | confirmed | P1 |

## Acceptance Criteria

- Launch checklist exists and includes the requested GitHub launch items.
- Public alpha release notes draft exists.
- Simple SaaS demo example exists with raw input and illustrative expected
  outputs.
- Demo script exists and ends with:
  `Project truth lives in the repo, not in chat memory.`
- Social launch drafts avoid banned marketing language from the user request.
- GitHub issue templates exist and ask for context, expected behavior, actual
  behavior when relevant, files involved, agent/tool used, validation evidence,
  reproduction steps where applicable, and governance impact.
- Seed issue drafts include title, purpose, acceptance criteria, suggested
  labels, files likely affected, and validation expectations.
- Token-efficiency guidance explains fast path, strict path, context packs,
  stale context handling, validation boundaries, and safety bypass prevention.
- Minimal CLI proposal describes `projectgenesis init`, `validate`, `doctor`,
  and `example` without implementing a CLI.
- Registry, traceability, current state, handoff, test results, worklog, and PR
  review records are updated.

## Out Of Scope

- Product redesign.
- README rewrite.
- Runtime implementation.
- CLI implementation.
- Validator, hook, CI, role, command-framework, context-pack, or governance
  mechanics changes.
- External GitHub release, issue, topic, template, or video publication.

## Validation

- `bash SCRIPTS/validate-bootstrap.sh`
- `bash SCRIPTS/validate-bootstrap-red-checks.sh`
- `git diff --check`
- Placeholder and overclaim scans where practical.

## Review

Fresh-context adversarial review is required before merge.
