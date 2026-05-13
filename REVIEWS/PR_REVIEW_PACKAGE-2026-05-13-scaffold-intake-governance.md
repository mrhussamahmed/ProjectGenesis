artifact_id: ART-PR-PACKAGE-SCAFFOLD-INTAKE-GOVERNANCE
title: Scaffold Intake And Governance PR Review Package
type: pr-review-package
status: active
version: v1.0
created: 2026-05-13
updated: 2026-05-13
owner: AI Bootstrap Maintainers
source: SPEC-BOOT-002 implementation
linked_specs: [SPEC-BOOT-002]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Scaffold Intake And Governance PR Review Package

## Purpose

Implement `SPEC-BOOT-002` by adding source-backed intake, product context,
requirements control, workflow policy updates, evidence-aware templates,
validator red checks, context packs, command prompt framework, and Markdown
onboarding replacements.

## Branch And Worktree

- Branch: `codex/adversarial-plan-review`
- Worktree: `/Users/ahmedabd/Desktop/AI Projects/New Poject bootstrap`

## Linked Artifacts

- Spec: `SPECS/SPEC-BOOT-002-scaffold-intake-and-governance.md`
- Backlog: BOOT-009 through BOOT-015 in `BACKLOG.md`
- Reviews:
  - `REVIEWS/REVIEW-2026-05-13-scaffold-improvement-plan.md`
  - `REVIEWS/REVIEW-2026-05-13-spec-boot-002-v0.2.md`
  - `REVIEWS/REVIEW-2026-05-13-spec-boot-002-v0.4.md`

## Summary Of Changes

- Added canonical intake folders and registries under `00_intake/`.
- Kept `INPUT/` as a registered legacy alias.
- Added reusable product context artifacts under `01_context/`.
- Added requirements, assumptions, and risk registers under `02_requirements/`.
- Updated workflow policy for the narrow direct-`main` documentation exception.
- Updated spec, ADR, and backlog templates with source evidence fields.
- Expanded traceability and acceptance-criteria mapping.
- Added validator checks and non-destructive red-check fixtures.
- Added subordinate context packs and command prompt framework.
- Migrated RTF onboarding guidance into Markdown guides.

## Acceptance Criteria

Acceptance criteria are mapped in `TESTS/ACCEPTANCE_CRITERIA_MAP.md`.

## Validation

- `bash SCRIPTS/validate-bootstrap.sh` passed.
- `bash SCRIPTS/validate-bootstrap-red-checks.sh` passed.
- `git diff --check` passed.

## Risks And Mitigations

- Risk: governance becomes too heavy.
  Mitigation: direct-main docs exception and risk-based review remain explicit.
- Risk: command prompts or context packs become shadow governance.
  Mitigation: authority limits are required and validator checks command
  sections.
- Risk: validator parsing becomes brittle.
  Mitigation: red-check fixtures are temporary, targeted, and non-destructive.

## Review Request

Perform fresh-context adversarial review against `SPEC-BOOT-002`, this review
package, the local diff, validation output, traceability, artifact registry,
test results, current state, and handoff. Classify findings as P0, P1, P2, or
P3.
