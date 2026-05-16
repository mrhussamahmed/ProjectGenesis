artifact_id: ART-RELEASE-NOTES
title: Release Notes
type: release-notes
status: active
version: v1.0
created: 2026-05-17
updated: 2026-05-17
owner: ProjectGenesis Maintainers
source: GitHub releases v0.1.0-public-alpha and v0.2.0-public-alpha
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Release Notes

## ProjectGenesis v0.2.0 Public Alpha

Release: https://github.com/mrhussamahmed/ProjectGenesis/releases/tag/v0.2.0-public-alpha

Commit: `73114f1056d885a34f012447146f968f3a878d11`

This release focuses on making ProjectGenesis cleaner to copy into a new
project and faster to operate during small AI-driven changes.

### Highlights

- Added a clean scaffold boundary with `TEMPLATE_MANIFEST.md` and
  `TEMPLATE_STARTERS/`.
- Moved ProjectGenesis maintainer history out of the active project path into
  `MAINTAINER_ARCHIVE/`.
- Shrunk required-reading state files so agents no longer inherit long
  historical logs during normal startup.
- Preserved audit history through maintainer archives and pre-trim snapshots.
- Added adaptive validation routing through `SCRIPTS/operation-profile.sh`,
  `BOOTSTRAP_VALIDATE_PROFILE`, and updated git hooks.
- Kept strict validation as the default and forced strict checks for protected
  paths such as validators, CI, hooks, governance, role instructions,
  templates, security, and release mechanics.

### Operational Impact

- New downstream projects should start with a smaller, cleaner active context.
- Small docs/process-light changes can use a shape-only validation path when
  explicitly classified and when no strict-gate files are touched.
- Governance, validator, CI, security, merge/release, role, and template
  changes remain strict.

### Verification

- GitHub `Bootstrap Validation` passed on `main`:
  https://github.com/mrhussamahmed/ProjectGenesis/actions/runs/25974641141
- Local strict bootstrap validation and red-check harness passed before the
  final post-merge cleanup.

### Known Notes

- ProjectGenesis is still a bootstrap scaffold, not an app generator.
- Maintainer archive content is intentionally preserved for audit, but it is no
  longer part of the active required-reading path.
- Downstream projects should use the scaffold boundary and starter-reset
  behavior rather than treating maintainer history as project context.

## ProjectGenesis v0.1.0 Public Alpha

Release: https://github.com/mrhussamahmed/ProjectGenesis/releases/tag/v0.1.0-public-alpha

This release published the initial public alpha scaffold: Markdown-first
project governance, role files, source-of-truth state, intake folders,
requirements and backlog structure, validation scripts, GitHub Actions
validation, and public repository setup guidance.
