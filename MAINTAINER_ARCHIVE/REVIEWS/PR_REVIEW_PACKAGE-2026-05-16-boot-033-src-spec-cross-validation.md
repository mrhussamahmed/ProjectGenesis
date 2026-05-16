artifact_id: ART-PR-PACKAGE-BOOT-033-SRC-SPEC-CROSS-VALIDATION
title: BOOT-033 SRC And SPEC Cross-Validation Review Package
type: pr-review-package
status: active
version: v1.0
created: 2026-05-16
updated: 2026-05-16
owner: AI Bootstrap Maintainers
source: BOOT-033 implementation of SRC and SPEC ID cross-validation in the bootstrap validator
linked_specs: [SPEC-BOOT-002, SPEC-BOOT-003]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# PR Review Package

## PR Title

BOOT-033 add SRC and SPEC cross-validation

## PR Purpose

Implement BOOT-033 by extending `SCRIPTS/validate-bootstrap.sh` so that
cited `SRC-*` and `SPEC-*` identifiers in `BACKLOG/BOOT-*.md` files
must exist in their respective registers, with an explicit
`provisional:` / `pending:` escape hatch for placeholders. Adds five
red-check fixtures covering unregistered, registered, and provisional
cases.

## Linked Specs

- `SPECS/SPEC-BOOT-002-scaffold-intake-and-governance.md`
- `SPECS/SPEC-BOOT-003-adaptive-governance-routing.md`

## Linked Backlog Items Or Tickets

- `BACKLOG.md` row `BOOT-033` (in-review)
- `BACKLOG/BOOT-033-src-spec-cross-validation.md` (in-review at v1.3)

## Linked ADRs

- None.

## Operation Classification

- Operation profile: `strict-protected`
- Branch: `claude/boot-033-src-spec-cross-validation`
- Base: `origin/main` at `08260d4` (latest green main after PR #9
  merge and post-merge cleanup)
- Risk: high (validator mechanics change)
- Validation mode: strict
- Reviewers: fresh-context Codex adversarial review through the
  installed plugin once GitHub `validate` is green

## Operation Routing Evidence

- `OPERATION_ROUTING.md` was read to confirm scope:
  - `strict-protected` profile applies because the PR adds new
    validator rules and red-check fixtures.
  - Source-of-truth artifacts (`ARTIFACT_REGISTRY.md`,
    `TRACEABILITY_MATRIX.md`, `CURRENT_STATE.md`, `AI_HANDOFF.md`,
    `BACKLOG.md`, `BACKLOG/BACKLOG_INDEX.md`, `BACKLOG/BOOT-033-*.md`,
    `TEST_RESULTS.md`, `WORKLOG/WORKLOG_INDEX.md`,
    `REVIEWS/REVIEW_INDEX.md`) update to reflect in-review state.
  - Out of scope: governance, operation routing, branch/worktree
    guide, PR review/merge policy, risk model, hooks, CI workflow,
    role files, command files, context packs, templates, ADRs, spec
    or backlog template changes, and runtime product mechanics.

## Changed Files

- `SCRIPTS/validate-bootstrap.sh` — adds SRC/SPEC cross-validation
  for `BACKLOG/BOOT-*.md` citations. Defines `src_registered`,
  `spec_registered`, and `extract_ids` helpers. Strips
  `provisional:` and `pending:` prefixes so those tokens never
  require registration.
- `SCRIPTS/validate-bootstrap-red-checks.sh` — adds five fixtures:
  - `case_unregistered_src_id_fails`
  - `case_unregistered_spec_id_fails`
  - `case_registered_src_id_passes`
  - `case_provisional_src_id_passes`
  - `case_provisional_spec_id_passes`
- `ARTIFACT_REGISTRY.md` — bumps `ART-SCRIPT-VALIDATE` to v1.10 and
  `ART-SCRIPT-VALIDATE-RED` to v1.6; bumps `ART-BACKLOG-BOOT-033` to
  v1.3; registers the new PR review package.
- `TRACEABILITY_MATRIX.md` — adds the BOOT-033 implementation row.
- `CURRENT_STATE.md` — records active BOOT-033 branch, in-progress
  task, blockers, source-of-truth files, next safe action, and
  latest local validation.
- `AI_HANDOFF.md` — records BOOT-033 Pre-Change Classification and
  Final Evidence Envelope.
- `BACKLOG.md` and `BACKLOG/BACKLOG_INDEX.md` — moves BOOT-033 from
  queued to in-review.
- `BACKLOG/BOOT-033-src-spec-cross-validation.md` — refreshes
  readiness, evidence, and Definition of Done.
- `TEST_RESULTS.md` — records BOOT-033 local validation evidence.
- `WORKLOG/WORKLOG_INDEX.md` — adds the BOOT-033 implementation
  session.
- `REVIEWS/REVIEW_INDEX.md` — registers this PR review package.
- `REVIEWS/PR_REVIEW_PACKAGE-2026-05-16-boot-033-src-spec-cross-validation.md`
  (new) — this review package.

## Risk

high

## Acceptance Criteria Mapping

- Validator fails on unregistered SRC/SPEC IDs: confirmed by
  `case_unregistered_src_id_fails` and
  `case_unregistered_spec_id_fails`.
- Validator passes on registered IDs:
  `case_registered_src_id_passes` adds a registered SRC and confirms
  the validator does not flag it.
- Provisional syntax allows unregistered placeholders without false
  positives:
  `case_provisional_src_id_passes` and
  `case_provisional_spec_id_passes` exercise the
  `provisional:` and `pending:` escape hatches respectively.
- No false positives on draft/proposed artifacts: scope is limited
  to `BACKLOG/BOOT-*.md` so spec drafts, ADRs, and downstream
  product registers are unaffected.

## Tests Added Or Updated

- Five new red-check fixtures (see above).
- Existing 30 red checks remain unchanged and continue to pass.

## Tests Run

- `bash -n SCRIPTS/validate-bootstrap.sh` — passes.
- `bash -n SCRIPTS/validate-bootstrap-red-checks.sh` — passes.
- `bash SCRIPTS/validate-bootstrap.sh` — passes.
- `bash SCRIPTS/validate-bootstrap-red-checks.sh` — all 30 cases pass
  (25 prior + 5 new BOOT-033 fixtures).
- `git diff --check origin/main...HEAD` — clean.

## Rollout And Rollback

- Rollout: merge after fresh-context Codex review approves and
  GitHub `validate` is green. After merge, follow the established
  post-merge state-sync cleanup pattern if `AI_HANDOFF.md`
  `## Current Branch` still names the feature branch.
- Rollback: revert the PR. The validator extension and red-check
  fixtures revert cleanly; no other repository state is touched.

## Traceability Evidence

- New `TRACEABILITY_MATRIX.md` row for BOOT-033 maps source evidence,
  spec linkage, validation chain, review record, and current status.
- `ARTIFACT_REGISTRY.md` bumps validator/red-check rows and registers
  the new PR review package.

## Assumptions

- None for this BOOT-033 PR.

## Open Questions

- The validator scope is limited to `BACKLOG/BOOT-*.md` for this
  slice. Extending to `TRACEABILITY_MATRIX.md` rows, spec metadata
  blocks, or downstream `02_requirements/` registers can be a
  separate slice once downstream product input exists.

## Operation Profile Decision

`strict-protected`. The PR changes validator mechanics. Even though
the changes are read-only and confined to existing source-of-truth
artifacts, validator mechanic changes fall under `strict-protected`
per `OPERATION_ROUTING.md` and `RISK_MODEL.md`.

## Branch Strategy

`claude/boot-033-src-spec-cross-validation` cut from latest green
`main` (`08260d4`). PR will target `main`.

## Dirty Worktree Status

Clean against `origin/main` (`08260d4`) before BOOT-033 edits. The
only changes in the worktree are the BOOT-033 implementation files
listed above. The untracked `research/` directory from prior
operations is out of scope; the validator already prunes it.

## Review Notes

This is the BOOT-033 PR. Please review:

1. Whether the validator correctly detects unregistered `SRC-*` and
   `SPEC-*` citations in `BACKLOG/BOOT-*.md`.
2. Whether the `provisional:` / `pending:` escape hatch works as
   documented.
3. Whether the red-check fixtures cover the BOOT-033 acceptance
   criteria.
4. Whether source-of-truth records (registry, traceability, current
   state, handoff, backlog, test results, worklog, review index)
   accurately reflect the in-review state.

## Out Of Scope For This PR

- Extending cross-validation to other files
  (`TRACEABILITY_MATRIX.md` rows, spec metadata blocks, downstream
  product registers).
- Requiring non-empty product source registers before downstream
  product input exists.
- Full requirement coverage metrics (BOOT-032 covers the metric
  surface).
- Any change to governance, operation routing, branch/worktree
  guide, PR review/merge policy, risk model, hooks, CI workflow,
  role files, command files, context packs, templates, ADRs, spec
  or backlog templates, or runtime product mechanics.
