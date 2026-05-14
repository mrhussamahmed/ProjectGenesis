artifact_id: ART-LAUNCH-SEED-ISSUES-001
title: Seed GitHub Issues
type: launch-issue-drafts
status: active
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

# Seed GitHub Issues

These are ready-to-copy drafts. They are not real GitHub issues until created
through GitHub and assigned issue URLs.

## 1. Add More Example Projects

Title: Add more example projects

Purpose: Provide small, concrete examples for different product shapes so new
users can see how ProjectGenesis handles rough input, requirements, assumptions,
backlog candidates, and validation.

Acceptance criteria:

- Add at least two examples under `examples/`.
- Label outputs as illustrative unless generated in a recorded run.
- Include raw input, expected outputs, assumptions, risks, backlog candidates,
  and validation checklist.
- Avoid duplicating README quick start content.

Suggested labels: `type:documentation`, `type:example`, `good first issue`

Files likely affected: `examples/`, `docs/demo/`

Validation expectations: `bash SCRIPTS/validate-bootstrap.sh`; `git diff --check`

## 2. Improve Codex Setup Instructions

Title: Improve Codex setup instructions

Purpose: Make the Codex path clearer for users adopting ProjectGenesis without
duplicating agent rules already stored in `AGENTS.md` and `memory/ai/`.

Acceptance criteria:

- Identify the smallest docs location for Codex-specific setup notes.
- Link to existing rules instead of repeating them.
- Include how Codex should invoke `Start requirement breakdown`.
- Keep governance and source-of-truth rules unchanged.

Suggested labels: `type:documentation`, `agent:codex`

Files likely affected: `docs/`, `AGENTS.md` only if a tiny link is required

Validation expectations: `bash SCRIPTS/validate-bootstrap.sh`; `git diff --check`

## 3. Add Claude Code Quickstart

Title: Add Claude Code quickstart

Purpose: Provide a concise Claude Code entry path that points to existing shared
role files and avoids creating a second source of truth.

Acceptance criteria:

- Explain the role of `CLAUDE.md` and `SCRIPTS/start-claude.sh`.
- Link to shared rules and role files.
- Include the intake command.
- Do not weaken shared role or handoff requirements.

Suggested labels: `type:documentation`, `agent:claude`

Files likely affected: `docs/`, `CLAUDE.md` only if a tiny link is required

Validation expectations: `bash SCRIPTS/validate-bootstrap.sh`; `git diff --check`

## 4. Create One-Command Bootstrap Flow

Title: Create one-command bootstrap flow

Purpose: Explore a small script or command that initializes a downstream copy of
ProjectGenesis while preserving Markdown-first design.

Acceptance criteria:

- Propose exact command behavior before implementation.
- State which files it can touch.
- Preserve existing validation, governance, and source-of-truth rules.
- Include rollback or dry-run behavior if a script is added.

Suggested labels: `type:enhancement`, `area:bootstrap`

Files likely affected: `docs/roadmap/`, maybe `SCRIPTS/` after separate approval

Validation expectations: `bash SCRIPTS/validate-bootstrap.sh`;
`bash SCRIPTS/validate-bootstrap-red-checks.sh` if scripts change;
`git diff --check`

## 5. Add Minimal Mode For Small Projects

Title: Add minimal mode for small projects

Purpose: Define a lower-overhead workflow for tiny experiments without making
token saving or speed a governance bypass.

Acceptance criteria:

- Define when minimal mode is allowed.
- Define when full validation remains mandatory.
- Reference `OPERATION_ROUTING.md` and `docs/token_efficiency_guidance.md`.
- Include examples of allowed and disallowed shortcuts.

Suggested labels: `type:documentation`, `area:governance`

Files likely affected: `docs/`, possibly `CONTEXT_PACKS/` after review

Validation expectations: `bash SCRIPTS/validate-bootstrap.sh`; `git diff --check`

## 6. Add Token-Efficient Context Pack Strategy

Title: Add token-efficient context pack strategy

Purpose: Convert token-efficiency guidance into concrete context-pack patterns
for common tasks.

Acceptance criteria:

- Identify task-specific read sets.
- Define stale-context refresh rules.
- Preserve source-of-truth hierarchy.
- Include examples for intake, docs-only changes, review, and implementation.

Suggested labels: `type:documentation`, `area:context-packs`

Files likely affected: `CONTEXT_PACKS/`, `docs/token_efficiency_guidance.md`

Validation expectations: `bash SCRIPTS/validate-bootstrap.sh`; `git diff --check`

## 7. Add GitHub Actions Validation Workflow

Title: Add GitHub Actions validation workflow improvements

Purpose: Review whether the existing bootstrap validation workflow needs clearer
labels, branch behavior, or public contributor guidance.

Acceptance criteria:

- Inspect `.github/workflows/bootstrap-validation.yml`.
- Document any proposed changes before editing CI.
- Keep required `validate` status check compatible with branch protection.
- Run red checks if validation behavior changes.

Suggested labels: `type:ci`, `area:validation`

Files likely affected: `.github/workflows/`, `GITHUB_REPOSITORY_SETUP.md`

Validation expectations: `bash SCRIPTS/validate-bootstrap.sh`;
`bash SCRIPTS/validate-bootstrap-red-checks.sh`; `git diff --check`

## 8. Create ProjectGenesis Demo Video

Title: Create ProjectGenesis demo video

Purpose: Record a short demo that shows the raw-input to governed-output flow
without overstating automation.

Acceptance criteria:

- Use `docs/demo/60-second-demo-script.md`.
- Show the example project and validation command.
- State clearly when outputs are illustrative.
- Link the final video from launch docs or README only after the URL exists.

Suggested labels: `type:documentation`, `type:demo`

Files likely affected: `docs/demo/`, `README.md` only after real video URL exists

Validation expectations: `bash SCRIPTS/validate-bootstrap.sh`; `git diff --check`

## 9. Add Real-World Migration Example From An Existing Project

Title: Add real-world migration example from an existing project

Purpose: Show how an existing project can adopt ProjectGenesis without deleting
its current docs or losing history.

Acceptance criteria:

- Use a real or anonymized project with explicit source labeling.
- Show before and after artifact mapping.
- Identify which files were authoritative before migration.
- Include risks and validation expectations.

Suggested labels: `type:example`, `area:migration`

Files likely affected: `examples/`, `docs/`

Validation expectations: `bash SCRIPTS/validate-bootstrap.sh`; `git diff --check`

## 10. Add Comparison Guide: ProjectGenesis vs Ad-Hoc Vibe Coding

Title: Add comparison guide: ProjectGenesis vs ad-hoc vibe coding

Purpose: Explain the tradeoffs between lightweight ad-hoc AI use and governed
ProjectGenesis use without dismissing small experiments.

Acceptance criteria:

- Compare source of truth, requirements, assumptions, reviews, validation, and
  handoffs.
- Include when ProjectGenesis may be more process than needed.
- Avoid marketing language and unsupported performance claims.
- Link to README and token-efficiency guidance.

Suggested labels: `type:documentation`, `area:positioning`

Files likely affected: `docs/`

Validation expectations: `bash SCRIPTS/validate-bootstrap.sh`; `git diff --check`
