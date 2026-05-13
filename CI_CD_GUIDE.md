artifact_id: ART-CI-001
title: CI/CD Guide
type: ci-guide
status: authoritative
version: v1.1
created: 2026-05-09
updated: 2026-05-14
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

## Baseline CI Checks

- checkout repository
- run `bash SCRIPTS/validate-bootstrap.sh`
- run `bash SCRIPTS/validate-bootstrap-red-checks.sh` for ProjectGenesis
  governance PRs or other validator-rule changes
- run shell syntax checks for changed scripts and hooks
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
