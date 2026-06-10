artifact_id: ART-CI-001
title: CI/CD Guide
type: ci-guide
status: authoritative
version: v1.2
created: 2026-05-09
updated: 2026-06-10
owner: AI Bootstrap Maintainers
source: User request and SPEC-BOOT-003
linked_specs: [SPEC-BOOT-003]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# CI/CD Guide

This bootstrap includes an optional GitHub Actions workflow at
`.github/workflows/bootstrap-validation.yml`. Adapt it for other CI systems.

## Tiered CI Model

The workflow runs in two tiers so docs-only changes stay fast while
strict-gate changes always get the full suite:

- triggers: `pull_request`, `push` to `main` only, and `workflow_dispatch`;
  one concurrent run per ref (`cancel-in-progress: true`), so each PR
  commit gets exactly one run
- always: `bash SCRIPTS/validate-bootstrap.sh` plus a `git diff --check`
  whitespace-hygiene pass against the merge-base
- conditionally: `bash SCRIPTS/validate-bootstrap-red-checks.sh` and shell
  syntax checks run only when the PR diff (merge-base vs HEAD) touches a
  strict-gate path, decided by `SCRIPTS/strict-gate-paths.sh --match`
- always full suite: pushes to `main` and `workflow_dispatch` runs; the
  scope decision also fails closed to the full suite when the changed-file
  diff cannot be computed

`SCRIPTS/strict-gate-paths.sh` is the single source of the strict-gate
pattern; the same helper drives `.githooks/pre-commit` and
`.githooks/pre-push`, so local hooks and CI cannot drift apart.

## Baseline CI Checks

- checkout repository
- run `bash SCRIPTS/validate-bootstrap.sh`
- run `bash SCRIPTS/validate-bootstrap-red-checks.sh` per the tiered model
  above (strict-gate diffs, `main` pushes, manual dispatch)
- run shell syntax checks for scripts and hooks per the tiered model above
- run formatting checks when stack is selected
- run lint checks when stack is selected
- run type checks when stack is selected
- run unit, integration, contract, and end-to-end tests as applicable
- run dependency audit as applicable
- run secret scan as applicable
- run build verification as applicable
- run migration checks as applicable
- validate documentation, traceability, and PR review package
- validate operation classification and final evidence envelope for meaningful
  protected changes

## Environment Validation

Project-specific CI should verify:

- required environment variables are documented
- no real secrets are committed
- deployment environment names are clear
- migrations are safe and reversible or recoverable
- rollback procedure is documented

## Release Pipeline

Before release:

- specs implemented
- tests passing
- security review complete if required
- observability adequate
- rollback possible
- documentation updated
- stale artifacts marked
- traceability complete
- handoff complete
