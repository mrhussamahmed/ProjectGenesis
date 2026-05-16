artifact_id: ART-PR-PACKAGE-BOOT-035-BRANCH-AWARE-HANDOFF
title: BOOT-035 Branch-Aware Handoff Review Package
type: pr-review-package
status: active
version: v1.1
created: 2026-05-16
updated: 2026-05-16
owner: AI Bootstrap Maintainers
source: BOOT-035 implementation of branch-aware handoff validation and fresh-context review approval
linked_specs: [SPEC-BOOT-003]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# PR Review Package

## PR Title

BOOT-035 fix branch-aware handoff validation

## PR Purpose

Fix the repeated `main` merge-commit CI failure caused by the singular
`AI_HANDOFF.md` `## Current Branch` field still naming the feature branch that
was just merged. The change keeps ordinary branch mismatch validation strict
and adds a narrow exception only for GitHub-style merge commits on `main` where
the merge subject's source branch exactly matches the branch recorded in
`AI_HANDOFF.md`.

## Linked Specs

- `SPECS/SPEC-BOOT-003-adaptive-governance-routing.md`

## Linked Backlog Items Or Tickets

- `BACKLOG.md` row `BOOT-035` (in-review)
- `BACKLOG/BOOT-035-branch-aware-handoff-model.md` (in-review at v1.2)

## Linked ADRs

- None. This slice does not introduce per-stream handoff files or a new
  artifact family.

## Operation Classification

- Operation profile: `strict-protected`
- Branch: `codex/boot-035-branch-aware-handoff`
- Base: `main` at `36738a870cc210eb033d9456fd1b6b3bffec8e62`
- Risk: high (validator mechanics change)
- Validation mode: strict
- Reviewers: fresh-context design reviewer completed before validator changes;
  fresh-context adversarial implementation review required before merge

## Operation Routing Evidence

- `OPERATION_ROUTING.md` was read to confirm scope:
  - `strict-protected` applies because the branch changes validator behavior
    and red-check fixtures.
  - Source-of-truth artifacts update to reflect BOOT-035 in-review state and
    local validation evidence.
  - Out of scope: hooks, CI workflow, role files, command files, context packs,
    templates, ADRs, PR/merge policy, risk model, branch/worktree guide policy
    changes, security/release docs, scaffold extraction scripts, metric
    scripts, and runtime product mechanics.

## Chosen Design

The reviewed near-term design is a validator-only exception:

- normal branch contexts still require exact equality between
  `git branch --show-current` and `AI_HANDOFF.md` `## Current Branch`;
- the exception is considered only when the current branch is `main`;
- `HEAD` must be exactly a two-parent merge commit;
- `git log -1 --format=%s` must match GitHub's
  `Merge pull request #... from owner/branch-name` form; and
- the parsed `branch-name` must exactly match `AI_HANDOFF.md`
  `## Current Branch`.

The fresh-context design reviewer agreed this is the safest near-term path and
flagged one important constraint: Git commit parents do not preserve branch
names after branch deletion, so the implementation correctly parses the GitHub
merge subject rather than relying on a second-parent branch name.

## Changed Files

- `SCRIPTS/validate-bootstrap.sh` — adds
  `handoff_branch_matches_github_main_merge` and uses it only to suppress the
  branch-field mismatch failure for exact GitHub merge-source matches on
  `main`.
- `SCRIPTS/validate-bootstrap-red-checks.sh` — adds `expect_success`,
  fixture-history helpers, and six focused branch-drift red checks.
- `BACKLOG/BOOT-035-branch-aware-handoff-model.md` — records the chosen
  design, acceptance criteria, and in-review status.
- `BACKLOG.md` and `BACKLOG/BACKLOG_INDEX.md` — move BOOT-035 to in-review.
- `CURRENT_STATE.md` and `AI_HANDOFF.md` — record active BOOT-035 state,
  validation, and evidence.
- `ARTIFACT_REGISTRY.md`, `TRACEABILITY_MATRIX.md`, `TEST_RESULTS.md`,
  `WORKLOG/WORKLOG_INDEX.md`, and `REVIEWS/REVIEW_INDEX.md` — update durable
  registry, traceability, validation, worklog, and review-package evidence.
- `REVIEWS/PR_REVIEW_PACKAGE-2026-05-16-boot-035-branch-aware-handoff.md`
  (new) — this review package.

## Risk

high

## Acceptance Criteria Mapping

- Feature branch where `AI_HANDOFF.md` names another branch still fails:
  `case_handoff_branch_mismatch`.
- `main` non-merge commit where `AI_HANDOFF.md` names a feature branch still
  fails: `case_main_non_merge_handoff_branch_mismatch`.
- GitHub-style merge commit on `main` where `AI_HANDOFF.md` names the exact
  merge source branch passes:
  `case_main_github_merge_source_handoff_branch_passes`.
- GitHub-style merge commit with a different handoff branch fails:
  `case_main_github_merge_mismatched_handoff_branch_fails`.
- Merge commit with non-GitHub or unparsable subject fails closed:
  `case_main_unparseable_merge_handoff_branch_fails`.
- Octopus merge commit fails closed:
  `case_main_octopus_merge_handoff_branch_fails`.
- The exception affects only the branch-field mismatch; other handoff
  validation failures still fail:
  `case_main_github_merge_other_handoff_failures_still_fail`.

## Tests Added Or Updated

- Six new branch-aware handoff red-check fixtures.
- Existing branch mismatch fixture now uses the shared `set_handoff_branch`
  helper but keeps the same failure expectation.

## Tests Run

- `bash -n SCRIPTS/validate-bootstrap.sh` — passes.
- `bash -n SCRIPTS/validate-bootstrap-red-checks.sh` — passes.
- `bash SCRIPTS/validate-bootstrap.sh` — passes.
- Pre-implementation red-check run failed as expected on
  `case_main_github_merge_source_handoff_branch_passes`, proving the old
  validator rejected the desired merge-source case.
- `bash SCRIPTS/validate-bootstrap-red-checks.sh` — passes all 36 cases
  after the validator change.
- `git diff --check` — clean.

## Rollout And Rollback

- Rollout: merge after fresh-context adversarial review approves and GitHub
  `validate` is green. The merge commit itself should pass the branch-field
  validator if `AI_HANDOFF.md` still names this feature branch and the GitHub
  merge subject uses the expected source branch form.
- Rollback: revert the PR. The helper and red-check fixtures revert cleanly;
  no new artifact family or policy model is introduced.

## Traceability Evidence

- `TRACEABILITY_MATRIX.md` row for BOOT-035 maps the branch-aware handoff
  requirement to the new validator helper, six red checks, design review, and
  local validation.
- `ARTIFACT_REGISTRY.md` bumps validator and red-check rows and registers this
  review package.

## Assumptions

- GitHub merge commits keep the source branch in the first-line subject using
  the observed `Merge pull request #... from owner/branch-name` form.
- Branches are deleted after merge, so source branch detection must not depend
  on local or remote refs.

## Open Questions

- Per-stream handoff files may be the better long-term model, but they require
  a separate design because they introduce precedence, lifecycle, cleanup, and
  duplicate-source-of-truth concerns.

## Operation Profile Decision

`strict-protected`. Validator behavior changes and red-check fixture changes
fall under the strict-protected profile.

## Branch Strategy

`codex/boot-035-branch-aware-handoff` cut from latest green `main`
(`36738a870cc210eb033d9456fd1b6b3bffec8e62`). PR will target `main`.

## Dirty Worktree Status

Before edits, `git status --short --branch` showed only
`## codex/boot-035-branch-aware-handoff` and `?? research/`. The untracked
`research/` directory is intentionally untouched and pruned by validators.

## Review Notes

Please review:

1. Whether the helper is sufficiently fail-closed.
2. Whether the exception is limited to the observed GitHub merge-commit drift.
3. Whether the red checks prove both the allowed merge-source case and the
   ordinary drift guardrails.
4. Whether source-of-truth records accurately show BOOT-035 as in-review.

## Review Status

Fresh-context implementation review initially requested changes for one P2
source-of-truth coherence issue in `CURRENT_STATE.md`. The review-fix updated
the stale PR #11 historical paragraph, reran bootstrap validation, red checks,
and `git diff --check`, and narrow re-review approved with no P0, P1, or P2
findings.

## Out Of Scope For This PR

- Making `AI_HANDOFF.md` branch-neutral.
- Creating per-stream handoff files.
- Changing branch/worktree policy, PR/merge policy, hooks, CI workflow, role
  files, command files, context packs, templates, ADRs, security/release docs,
  scaffold extraction scripts, metric scripts, or runtime product mechanics.
