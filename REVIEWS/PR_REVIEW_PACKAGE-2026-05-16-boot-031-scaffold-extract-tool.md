artifact_id: ART-PR-PACKAGE-BOOT-031-SCAFFOLD-EXTRACT-TOOL
title: BOOT-031 Scaffold Extraction Tool Review Package
type: pr-review-package
status: active
version: v1.0
created: 2026-05-16
updated: 2026-05-16
owner: AI Bootstrap Maintainers
source: BOOT-031 implementation of the dry-run-first scaffold extraction tool defined by `SCAFFOLD_FORK_CHECKLIST.md`
linked_specs: [SPEC-BOOT-002, SPEC-BOOT-003]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# PR Review Package

## PR Title

BOOT-031 add dry-run-first scaffold extraction tool

## PR Purpose

Implement the BOOT-031 backlog item by adding a dry-run-first scaffold
extraction tool that follows the `SCAFFOLD_FORK_CHECKLIST.md` policy
merged in BOOT-030 (PR #7). The tool produces a clean downstream
scaffold from a ProjectGenesis source repository without requiring
manual file pruning, and the extracted scaffold passes
`bash SCRIPTS/validate-bootstrap.sh` end-to-end.

## Linked Specs

- `SPECS/SPEC-BOOT-002-scaffold-intake-and-governance.md`
- `SPECS/SPEC-BOOT-003-adaptive-governance-routing.md`

## Linked Backlog Items Or Tickets

- `BACKLOG.md` row `BOOT-031` (in-review)
- `BACKLOG/BOOT-031-scaffold-extract-tool.md` (in-review at v1.2)

## Linked ADRs

- None.

## Operation Classification

- Operation profile: `strict-protected`
- Branch: `claude/boot-031-scaffold-extract-tool`
- Base: `origin/main` at `9e21ce9` (latest green main)
- Risk: high (validator and script mechanics change; the extracted
  scaffold must pass `bash SCRIPTS/validate-bootstrap.sh` end-to-end)
- Validation mode: strict
- Reviewers: fresh-context Codex adversarial review through the
  installed plugin once GitHub `validate` is green

## Operation Routing Evidence

- `OPERATION_ROUTING.md` was read to confirm scope:
  - `strict-protected` profile applies because the change adds a new
    script (`SCRIPTS/scaffold-extract.sh`), adds a required-file entry
    to `SCRIPTS/validate-bootstrap.sh`, and adds four new red-check
    fixtures.
  - Source-of-truth artifacts (`ARTIFACT_REGISTRY.md`,
    `TRACEABILITY_MATRIX.md`, `CURRENT_STATE.md`, `AI_HANDOFF.md`,
    `BACKLOG.md`, `BACKLOG/BACKLOG_INDEX.md`, `BACKLOG/BOOT-031-*.md`,
    `TEST_RESULTS.md`, `WORKLOG/WORKLOG_INDEX.md`,
    `REVIEWS/REVIEW_INDEX.md`) update to reflect BOOT-031 in-review
    state.
  - Out of scope: validator core rules, hooks, CI workflow, role
    files, command files, context packs, templates, ADRs,
    `OPERATION_ROUTING.md`, `GOVERNANCE.md`,
    `BRANCH_AND_WORKTREE_GUIDE.md`, `PR_REVIEW_POLICY.md`,
    `PR_MERGE_POLICY.md`, `RISK_MODEL.md`,
    `SCAFFOLD_FORK_CHECKLIST.md`, `IMPLEMENTATION_PLAN.md`,
    `PARALLEL_EXECUTION_PLAN.md`, and any runtime product mechanics.

## Changed Files

- `SCRIPTS/scaffold-extract.sh` (new) — dry-run-first scaffold
  extraction tool. Mirrors framework files via rsync with broad
  exclusions, enforces BOOT-009+ backlog cleanup, resets shared state
  files to `SCAFFOLD_FORK_CHECKLIST.md` clean-state expectations, and
  optionally runs `bash SCRIPTS/validate-bootstrap.sh` in the extracted
  target. Safety: source repository is never modified; explicit target
  required; non-empty target refused without `--force`; source-as-target
  and nested-target refused; default behavior is dry-run.
- `SCRIPTS/validate-bootstrap.sh` — adds
  `SCRIPTS/scaffold-extract.sh` to `required_files`.
- `SCRIPTS/validate-bootstrap-red-checks.sh` — adds four new fixtures:
  - `case_scaffold_extract_golden_validates` — apply +
    `bash SCRIPTS/validate-bootstrap.sh` in the extracted target must
    exit 0.
  - `case_scaffold_extract_dry_run_writes_nothing` — default behavior
    creates no target directory.
  - `case_scaffold_extract_refuses_source_as_target` — safety check
    refuses `target == source_root`.
  - `case_scaffold_extract_refuses_nonempty_without_force` — safety
    check refuses non-empty target unless `--force`; pre-existing
    files are preserved when the script refuses.
- `ARTIFACT_REGISTRY.md` — registers
  `ART-SCAFFOLD-EXTRACT-SCRIPT`, adds the
  `ART-PR-PACKAGE-BOOT-031-SCAFFOLD-EXTRACT-TOOL` row, bumps versions
  for impacted source-of-truth artifacts (registry, validator,
  red-check validator, traceability, current state, handoff, backlog,
  backlog index, BOOT-031 backlog item, test results, worklog, review
  index).
- `TRACEABILITY_MATRIX.md` — adds the BOOT-031 implementation row and
  links the PR review package, validation evidence, and current
  status.
- `CURRENT_STATE.md` — records active BOOT-031 branch, in-progress
  task, blockers, new source-of-truth file, next safe action, and
  latest local validation.
- `AI_HANDOFF.md` — records BOOT-031 Pre-Change Classification, Final
  Evidence Envelope, files changed, tests run, dirty worktree status,
  and next safe action.
- `BACKLOG.md` — moves BOOT-031 from blocked to in-review.
- `BACKLOG/BACKLOG_INDEX.md` — moves BOOT-031 from blocked to
  in-review.
- `BACKLOG/BOOT-031-scaffold-extract-tool.md` — refreshes readiness
  evidence, status, and Definition of Done to reflect the
  implementation.
- `TEST_RESULTS.md` — records BOOT-031 local validation evidence.
- `WORKLOG/WORKLOG_INDEX.md` — adds BOOT-031 implementation session.
- `REVIEWS/REVIEW_INDEX.md` — registers this PR review package.
- `REVIEWS/PR_REVIEW_PACKAGE-2026-05-16-boot-031-scaffold-extract-tool.md`
  (new) — this review package.

## Risk

high

## Acceptance Criteria Mapping

- BOOT-031 acceptance: dry-run-first script that follows
  `SCAFFOLD_FORK_CHECKLIST.md` clean-state policy, validates an
  extracted target with `bash SCRIPTS/validate-bootstrap.sh`, includes
  golden/fixture validation, includes rollback/safety notes, includes
  overwrite safeguards, and reports phase log output.
- Golden validation: `case_scaffold_extract_golden_validates` confirms
  the extracted target validates end-to-end.
- Dry-run safety: `case_scaffold_extract_dry_run_writes_nothing`
  confirms default behavior writes no files.
- Source-as-target safety:
  `case_scaffold_extract_refuses_source_as_target` confirms the
  script refuses when the target equals the source repository.
- Non-empty-target safety:
  `case_scaffold_extract_refuses_nonempty_without_force` confirms the
  script refuses to overwrite a non-empty target without `--force` and
  does not modify pre-existing target contents before refusing.
- Shell syntax: `bash -n SCRIPTS/scaffold-extract.sh` and
  `bash -n SCRIPTS/validate-bootstrap-red-checks.sh` pass.

## Tests Added Or Updated

- Four new red-check fixtures in
  `SCRIPTS/validate-bootstrap-red-checks.sh` (see above).
- Existing 19 red checks remain unchanged and continue to pass.

## Tests Run

- `bash -n SCRIPTS/scaffold-extract.sh` — passes.
- `bash -n SCRIPTS/validate-bootstrap-red-checks.sh` — passes.
- `bash SCRIPTS/validate-bootstrap.sh` — passes.
- `bash SCRIPTS/validate-bootstrap-red-checks.sh` — all 23 cases pass.
- Manual dry-run: `bash SCRIPTS/scaffold-extract.sh
  /tmp/scaffold-dry-run` — prints phase log and writes no files.
- Manual apply: `bash SCRIPTS/scaffold-extract.sh --apply
  /tmp/scaffold-test` — writes the extracted scaffold and Phase 4
  runs `bash SCRIPTS/validate-bootstrap.sh` in the target, which
  passes.
- `git diff --check origin/main...HEAD` — clean.

## Rollout And Rollback

- Rollout: merge the PR after fresh-context Codex review approves and
  GitHub `validate` is green. After merge, follow the established
  post-merge state-sync cleanup pattern (PR #5 `0dc5109`, PR #6
  `22c79f8`, PR #7 `9e21ce9`) if `AI_HANDOFF.md` ## Current Branch
  still names the feature branch.
- Rollback: revert the PR (the script is additive). The new
  `SCRIPTS/scaffold-extract.sh` is the only new functional file; the
  red-check fixtures remove cleanly with the revert; required-file
  validator entry reverts cleanly.

## Traceability Evidence

- New `TRACEABILITY_MATRIX.md` row for BOOT-031 maps source evidence,
  spec linkage, validation, review record, and current status.
- `ARTIFACT_REGISTRY.md` row `ART-SCAFFOLD-EXTRACT-SCRIPT` registers
  the script. `ART-SCRIPT-VALIDATE` is bumped to v1.8 to record the
  required-files addition. `ART-SCRIPT-VALIDATE-RED` is bumped to v1.4
  to record the four new fixtures. Other source-of-truth artifacts
  are bumped to reflect the in-review state.

## Assumptions

- None for this BOOT-031 PR.

## Open Questions

- None for this BOOT-031 PR.

## Operation Profile Decision

`strict-protected`. The change adds a new script and adds a
required-file entry to the bootstrap validator. Even though those are
narrow changes, they change validator and script mechanics, which fall
under `strict-protected` per `OPERATION_ROUTING.md` and `RISK_MODEL.md`.

## Branch Strategy

`claude/boot-031-scaffold-extract-tool` cut from latest green `main`
(`9e21ce9`). PR will target `main`.

## Dirty Worktree Status

Clean against `origin/main` (`9e21ce9`) before BOOT-031 edits. The
only changes in the worktree are the BOOT-031 implementation files
listed above.

## Review Notes

This is the BOOT-031 PR. Please review:

1. Whether `SCRIPTS/scaffold-extract.sh` correctly implements every
   clean-state expectation in `SCAFFOLD_FORK_CHECKLIST.md`.
2. Whether the four new red-check fixtures cover the BOOT-031
   acceptance criteria.
3. Whether source-of-truth records (registry, traceability, current
   state, handoff, backlog, test results, worklog, review index)
   accurately reflect the in-review state.
4. Whether the validator's `required_files` addition is consistent
   with the script's existence in source repos and extracted targets.
5. Whether the script's safety checks (dry-run default,
   source-as-target refusal, nested-target refusal, non-empty target
   refusal without `--force`) are sufficient to prevent destructive
   misuse.

## Out Of Scope For This PR

- BOOT-032 seeded-defect benchmark and coverage metrics work.
- BOOT-033 SRC/SPEC cross-validation.
- Changes to `SCAFFOLD_FORK_CHECKLIST.md` (policy), governance,
  operation routing, branch/worktree guide, PR review policy, PR merge
  policy, risk model, hooks, CI workflow, role files, command files,
  context packs, templates, ADRs, or runtime product mechanics.
