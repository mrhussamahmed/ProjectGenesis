artifact_id: ART-ROADMAP-MINIMAL-CLI-001
title: Minimal CLI Bootstrap Proposal
type: roadmap-proposal
status: draft
version: v1.0
created: 2026-05-14
updated: 2026-05-14
owner: ProjectGenesis Maintainers
source: Public launch readiness and adoption packaging task
linked_specs: [SPEC-BOOT-004]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Minimal CLI Bootstrap Proposal

ProjectGenesis does not currently include a product CLI. Existing automation is
shell-based and centered on validation scripts. This proposal describes a small
future CLI surface without building it now.

## Design Constraints

- Markdown remains the source of truth.
- The CLI must not replace agent rules, specs, ADRs, backlog, traceability, or
  governance.
- The CLI must not silently overwrite project files.
- The CLI must not hide validation failures.
- The CLI must be optional.

## Proposed Commands

### `projectgenesis init`

What it would do:

- Copy the scaffold into a target repository.
- Preserve required folders and metadata files.
- Prompt before overwriting existing files.
- Optionally create initial intake placeholders.

Files it would touch:

- ProjectGenesis scaffold files in the target repository.
- `.github/`, `.githooks/`, `SCRIPTS/`, `memory/ai/`, and Markdown governance
  files only with explicit confirmation.

What it must not do:

- It must not choose a product stack.
- It must not create fake specs or requirements.
- It must not configure remote GitHub settings without explicit authenticated
  user action.

Markdown-first preservation:

- The command copies and checks Markdown artifacts; it does not move truth into
  a hidden local database.

Out of scope:

- Package publishing, cloud setup, ticket creation, and product code
  generation.

### `projectgenesis validate`

What it would do:

- Run `bash SCRIPTS/validate-bootstrap.sh`.
- Optionally run red checks when requested.
- Return clear pass or fail output.

Files it would touch:

- None by default.

What it must not do:

- It must not edit files to make validation pass.
- It must not suppress failures.

Markdown-first preservation:

- It validates the repository files already used by agents.

Out of scope:

- Stack-specific app tests unless explicitly delegated to project scripts.

### `projectgenesis doctor`

What it would do:

- Inspect required files, branch status, hook configuration, and GitHub workflow
  presence.
- Report likely setup gaps.
- Suggest the next validation command.

Files it would touch:

- None by default.

What it must not do:

- It must not change branch protection.
- It must not modify governance files.

Markdown-first preservation:

- It reads repository artifacts and reports findings with file paths.

Out of scope:

- Authenticated GitHub mutation, dependency installation, and external tracker
  setup.

### `projectgenesis example`

What it would do:

- List examples under `examples/`.
- Copy an example into a temporary or user-selected location on request.
- Print the matching demo command.

Files it would touch:

- None by default.
- A selected destination only after explicit confirmation.

What it must not do:

- It must not claim illustrative outputs are live generated outputs.
- It must not modify canonical `00_intake/` without confirmation.

Markdown-first preservation:

- Examples remain plain files that users and agents can inspect.

Out of scope:

- Live agent orchestration and generated product implementation.
