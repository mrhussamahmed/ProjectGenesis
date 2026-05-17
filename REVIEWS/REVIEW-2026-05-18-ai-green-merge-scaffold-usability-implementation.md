artifact_id: ART-REVIEW-AI-GREEN-MERGE-IMPL-001
title: AI Green-Merge For Bootstrap Scaffold Usability Implementation Review
type: pr-review
status: active
version: v1.0
created: 2026-05-18
updated: 2026-05-18
owner: AI Bootstrap Maintainers
source: Codex fresh-context adversarial review across six iterations for BOOT-GREEN-MERGE-001
linked_specs: []
linked_tickets: [BOOT-GREEN-MERGE-001]
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Adversarial PR Review

## Review Decision

no blocking findings (defect detection)

This decision is a defect-detection statement per the updated
`PR_REVIEW_POLICY.md`. It is not a human-style merge authorization; merge
proceeds when the objective gates in `PR_MERGE_POLICY.md` are satisfied.

## Risk Level

high (changes protected merge/review policy and validator behavior; touches
authoritative governance, role, validator, and setup-guide artifacts)

## Model Or Effort Level Used Or Recommended

adversarial deep — six iterations of fresh-context Codex review with the
user-supplied review prompt; defect detection across prose policy, role
files, validator regression guard, GitHub branch-protection setup, and live
GitHub enforcement alignment.

## Reviewer

- Agent: Codex (via codex:codex-rescue subagent)
- Role: Fresh-context adversarial reviewer
- Date: 2026-05-18

## Inputs Reviewed

- Review package: this file; the user-supplied implementation prompt for
  BOOT-GREEN-MERGE-001; the green-merge contract in `PR_MERGE_POLICY.md`.
- PR diff or local diff: branch `codex/ai-green-merge-plan-review` vs `main`
  at commit `d4b5161`.
- Operation classification: recurring bootstrap-governance exception per
  `PR_MERGE_POLICY.md`.
- Final evidence envelope: this review plus `TEST_RESULTS.md` rows for the
  green-merge run and `TRACEABILITY_MATRIX.md` row
  `TRACE-AI-GREEN-MERGE-001`.
- Specs: none; the change is bootstrap-governance under the recurring
  exception.
- Backlog items or tickets:
  `BACKLOG/BOOT-GREEN-MERGE-001-ai-green-merge-scaffold-usability.md`.
- ADRs: none required.
- Tests: `bash SCRIPTS/validate-bootstrap.sh`,
  `bash SCRIPTS/validate-bootstrap-red-checks.sh`,
  `bash -n SCRIPTS/validate-bootstrap.sh`,
  `bash -n SCRIPTS/validate-bootstrap-red-checks.sh`, `git diff --check`,
  targeted `rg` policy scan, `gh api` branch-protection probes.
- Traceability: `TRACEABILITY_MATRIX.md` row `TRACE-AI-GREEN-MERGE-001`.
- Artifact registry: `ARTIFACT_REGISTRY.md` updated entries for
  `ART-PR-MERGE-POLICY` (v1.4), `ART-PR-REVIEW-POLICY` (v1.4),
  `ART-GOVERNANCE` (v1.5), `ART-ROLE-IMPL` (v1.2), `ART-ROLE-ADV-REVIEW`
  (v1.3), `ART-SCRIPT-VALIDATE` (v4.2), `ART-SCRIPT-RED-CHECKS` (v4.2),
  `ART-GH-SETUP` (v1.3), `ART-README` (v1.6), plus the new
  `ART-BACKLOG-BOOT-GREEN-MERGE-001` row.
- Current state and handoff: not modified in this branch — the canonical
  `CURRENT_STATE.md` and `AI_HANDOFF.md` snapshots remain merge-safe; the
  branch-specific status lives in this review and in the PR evidence per the
  split-state rules.

## Findings

Across all six iterations, the final state has:

| Severity | File | Evidence | Finding | Required Change |
|----------|------|----------|---------|-----------------|
| (none)   |      |          | No P0/P1/blocking P2 findings remain after iteration 6. |  |

Resolved findings across iterations (all closed):

| Iteration | Severity | File / Area | Finding | Resolution |
|-----------|----------|-------------|---------|------------|
| 1 | blocking P2 | `SCRIPTS/validate-bootstrap.sh`, `GITHUB_REPOSITORY_SETUP.md` | Regression guard did not scope `GITHUB_REPOSITORY_SETUP.md` and did not check GitHub branch-protection keys (`required_approving_review_count`, `require_code_owner_reviews`, `require_last_push_approval`). | Added `GITHUB_REPOSITORY_SETUP.md` to `green_merge_active_policy_files`; added `green_merge_github_key_patterns` for the three keys; added matching red-check fixtures (`case_setup_guide_reintroduces_required_approving_review_count_fails`, `case_setup_guide_reintroduces_require_code_owner_reviews_fails`, `case_setup_guide_reintroduces_require_last_push_approval_fails`, `case_setup_guide_disabled_github_keys_pass`); reworded setup guide so negations stay on the same line. |
| 2 | P1 | `README.md`, `SCRIPTS/validate-bootstrap.sh` | README still recommended required PR approvals and Code Owner reviews; README not in validator scope. | Rewrote README "GitHub Repository Controls"; added `README.md` to `green_merge_active_policy_files`; bumped `ART-README` to v1.6. |
| 3 | blocking P2 | `SCRIPTS/validate-bootstrap.sh`, `SCRIPTS/validate-bootstrap-red-checks.sh` | Validator grep was line-by-line; a wrapped Markdown bullet split across lines could bypass the guard. | Added an awk pre-pass that joins indented Markdown continuation lines onto their preceding top-level line; added `case_policy_reintroduces_required_human_approval_wrapped_fails`; documented the normalization in the guard's comment block. |
| 4 | P1 (×2) | `PR_REVIEW_POLICY.md` (lines 21, 121), `AI_PROJECT_BOOTSTRAP.md` (Phase 13), `PR_MERGE_POLICY.md` (Objective Merge Gates, Recurring Bootstrap Governance Exception), `BACKLOG/BOOT-GREEN-MERGE-001-...` (Stop Conditions) | Acceptance-with-rationale backdoor language and required-check bypass language still permitted in residual locations. | Excised "or explicitly accepted with rationale" for P0/P1/blocking P2 across all four files; clarified that required-check failures must be fixed, not accepted; clarified that non-blocking P2 may still be tracked and deferred when the reviewer explicitly classifies it as non-blocking; bumped `PR_MERGE_POLICY.md` to v1.4, `PR_REVIEW_POLICY.md` to v1.4. |
| 4 | blocking P2 | `GITHUB_REPOSITORY_SETUP.md`, live GitHub branch protection | `required_conversation_resolution: true` could create a soft merge gate beyond the green-merge objective gates. | Set the key to `false` in both PUT examples; added an explicit "leave `required_conversation_resolution` disabled" bullet to Required Repository Controls; added "no required conversation resolution gate is enforced" to Expected Protection Behavior; ran `gh api --method PUT` to align the live `main` protection (returned `required_conversation_resolution.enabled = false`). |
| 5 | blocking P2 | `SCRIPTS/validate-bootstrap.sh`, `SCRIPTS/validate-bootstrap-red-checks.sh` | Validator rejected the nested GitHub keys but allowed a non-null `required_pull_request_reviews` parent object, which GitHub treats as enabling PR-review protection. | Added a fourth pattern `"required_pull_request_reviews"[[:space:]]*:[[:space:]]*\{` to `green_merge_github_key_patterns`; added `case_setup_guide_reintroduces_non_null_required_pull_request_reviews_fails` and `case_setup_guide_null_required_pull_request_reviews_passes` fixtures. |
| 6 | — | — | No blocking findings. | Branch clear to merge per the AI green-merge contract once CI passes. |

## Operation Routing Review

- Profile correctness: bootstrap-governance under the recurring exception in
  `PR_MERGE_POLICY.md`. Recorded in this review and in the PR evidence.
- Escalation precedence: validator and red-checks remained strict-protected;
  no fast-path was used for the green-merge changes.
- Protected artifacts: `PR_MERGE_POLICY.md`, `PR_REVIEW_POLICY.md`,
  `GOVERNANCE.md`, role files, validator scripts, `.github/CODEOWNERS`,
  `GITHUB_REPOSITORY_SETUP.md`, `README.md`, `ARTIFACT_REGISTRY.md`,
  `TRACEABILITY_MATRIX.md`, `TEST_RESULTS.md`, `WORKLOG/WORKLOG_INDEX.md`,
  `BACKLOG/BACKLOG_INDEX.md`, `REVIEWS/REVIEW_INDEX.md`. All updated together.
- Skipped validation rationale: none. Local validator, red checks, shell
  syntax, `git diff --check`, and policy scan all ran and passed.
- Handoff and evidence durability: this review is a durable committed
  record under `REVIEWS/` and is registered in `REVIEWS/REVIEW_INDEX.md`,
  `ARTIFACT_REGISTRY.md`, and `TRACEABILITY_MATRIX.md`.

## Split-State Review

- Canonical state remains merge-safe: `CURRENT_STATE.md` and `AI_HANDOFF.md`
  are not modified by this branch; the canonical baseline is unchanged.
- Branch-specific status is in PR evidence: yes — this review record and
  the upcoming PR body carry branch-specific status.
- Local session facts are not committed: yes — `.ai/SESSION.md` is
  gitignored; no local-session text was added to committed files.
- Review evidence durability is appropriate for risk: yes — high-risk
  governance/validator change has a durable committed review record under
  `REVIEWS/` per `PR_REVIEW_POLICY.md`.

## Required Changes

None remain. All iterations' blocking findings are resolved.

## Optional Improvements

- Future work could extend the validator's wrap-normalization to also
  handle ordered-list markers (`1.`, `2.`) and to recognize Markdown
  fenced-code blocks more carefully. The current pre-pass covers
  unordered-bullet continuations, which is the dominant Markdown form in
  the scoped active-policy files. Not blocking.

## Evidence For Major Findings

- Iteration 1: Codex temp-fixture injection showed `required_pull_request_reviews`
  parent object slipped the original guard; resolved as in the table above.
- Iteration 2: README review confirmed the recommended-settings list still
  requested approvals; resolved.
- Iteration 3: Codex pointed out the validator's comment claimed newline
  collapse but the implementation was line-by-line; resolved with awk
  pre-pass.
- Iteration 4: Codex enumerated specific lines in `PR_REVIEW_POLICY.md`,
  `AI_PROJECT_BOOTSTRAP.md`, `PR_MERGE_POLICY.md`, and the backlog item
  carrying acceptance-with-rationale or accepted-skip language; all
  resolved.
- Iteration 5: Codex temp-fixture confirmed the non-null parent object slip
  by appending `"required_pull_request_reviews": { "dismiss_stale_reviews":
  true }` to the setup guide and observing the validator still exited 0;
  resolved with the parent-object pattern and red-check fixture.
- Iteration 6: Codex confirmed no further findings; branch clear to merge
  once required CI is green.

## Final Recommendation

Proceed to merge once required CI passes. Per `PR_MERGE_POLICY.md`, AI may
merge without waiting for human, maintainer, or Code Owner approval once the
objective gates are satisfied.

## Re-Review Conditions

Re-review is required if the validator regression guard is loosened, if any
of the active authoritative policy/role files reintroduce assertive approval
language, if GitHub branch protection re-enables required PR reviews or Code
Owner reviews, or if the recurring bootstrap-governance exception is used to
merge product implementation, runtime code, schemas, APIs, migrations,
dependencies, deployment changes, security-sensitive runtime behavior, or
architecture-sensitive product decisions.
