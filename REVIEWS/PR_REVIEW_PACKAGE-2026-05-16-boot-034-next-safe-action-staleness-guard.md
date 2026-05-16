artifact_id: ART-PR-PACKAGE-BOOT-034-NEXT-SAFE-ACTION-STALENESS-GUARD
title: BOOT-034 Next Safe Action Staleness Guard Review Package
type: pr-review-package
status: active
version: v1.0
created: 2026-05-16
updated: 2026-05-16
owner: AI Bootstrap Maintainers
source: BOOT-034 implementation of the validator-backed staleness guard for `Next safe action:` envelope fields
linked_specs: [SPEC-BOOT-003]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# PR Review Package

## PR Title

BOOT-034 add next safe action staleness guard

## PR Purpose

Prevent committed handoff and state evidence in `AI_HANDOFF.md` and
`CURRENT_STATE.md` from carrying more than one unmarked forward-looking
`Next safe action:` envelope field at a time. The PR #10 / BOOT-033 v1.0
through v1.5 review loop is the canonical incident: successive fresh-context
reviews each surfaced an older, unmarked `Next safe action:` line that was
misread as still active and triggered new request-changes cycles. The
validator-backed guard makes the historical-marker convention enforceable
and fail-closed.

## Linked Specs

- `SPECS/SPEC-BOOT-003-adaptive-governance-routing.md` (`AGR-FR-003` final
  durable evidence envelope and `AGR-FR-008` handoff/current-state
  continuity).

## Linked Backlog Items Or Tickets

- `BACKLOG.md` row `BOOT-034` (in-review).
- `BACKLOG/BOOT-034-next-safe-action-staleness-guard.md` (in-review at v1.1).

## Linked ADRs

- None. The PR does not introduce a new artifact family or change governance,
  routing, or branch/worktree policy.

## Operation Classification

- Operation profile: `strict-protected`.
- Branch: `claude/boot-034-next-safe-action-staleness-guard`.
- Base: `main` at `f116f85`.
- Risk: high (validator mechanics change).
- Validation mode: strict.
- Reviewers: fresh-context Codex adversarial review required before merge.

## Operation Routing Evidence

- `OPERATION_ROUTING.md` was read to confirm scope:
  - `strict-protected` applies because the change adds validator behavior
    and red-check fixtures.
  - Source-of-truth artifacts update to reflect BOOT-034 in-review state,
    local validation evidence, and the new PR review package.
  - Out of scope: hooks, CI workflow, role files, command files, context
    packs, templates, ADRs, governance policy, operation routing policy,
    branch/worktree policy, PR/merge policy, risk model, architecture,
    security, release, scaffold extraction scripts, metric scripts, and
    runtime product mechanics.

## Chosen Design

Validator-backed, narrow, fail-closed:

- `SCRIPTS/validate-bootstrap.sh` gains
  `count_unmarked_next_safe_actions`, which scans `AI_HANDOFF.md` and
  `CURRENT_STATE.md` for lines matching the structured envelope field
  pattern `- Next safe action:` (case insensitive, allowing `*` bullets and
  leading whitespace). Section headings such as `## Next Recommended
  Action` (any line starting with `#`) and narrative prose mentioning
  `Next safe action:` inside backticks are excluded by the pattern.
- A `Next safe action:` payload is "marked" (historical) when it contains
  any of `completed`, `superseded`, `historical`, or `delegated` as a
  whole word (case insensitive). Empty payloads are treated as marked.
- The validator fails when more than one unmarked field exists in a single
  file. Zero unmarked fields is allowed (no current action). One unmarked
  field represents the current active envelope.
- `SCRIPTS/validate-bootstrap-red-checks.sh` gains eight focused fixtures:
  - `case_stale_next_safe_action_historical_fails`
  - `case_current_state_stale_next_safe_action_fails`
  - `case_next_safe_action_marked_completed_passes`
  - `case_next_safe_action_marked_superseded_passes`
  - `case_next_safe_action_marked_historical_passes`
  - `case_next_safe_action_marked_delegated_passes`
  - `case_next_recommended_action_heading_passes`
  - `case_next_safe_action_prose_not_overmatched`
- Existing 25 unmarked historical envelope fields in `AI_HANDOFF.md` were
  bulk-marked with `(historical)` prefixes via an idempotent perl
  substitution that leaves already-marked lines untouched. The two
  pre-existing markers (`completed; superseded` and `superseded`) were
  preserved.
- The new BOOT-034 Final Evidence Envelope is the single active unmarked
  entry in `AI_HANDOFF.md`.

## Changed Files

- `SCRIPTS/validate-bootstrap.sh` — adds `count_unmarked_next_safe_actions`
  helper and per-file unmarked-count check for `AI_HANDOFF.md` and
  `CURRENT_STATE.md`.
- `SCRIPTS/validate-bootstrap-red-checks.sh` — adds eight new BOOT-034
  fixtures and registers them in the dispatcher list.
- `AI_HANDOFF.md` — new BOOT-034 Pre-Change Classification and Final
  Evidence Envelope; 25 historical `- Next safe action:` lines bulk-marked
  with `(historical)`; header sections updated for active agent, role,
  branch, worktree, last completed task, and current in-progress task.
- `CURRENT_STATE.md` — version bump; active branch, worktree, backlog
  focus, blockers, next recommended action, and latest validation updated;
  new BOOT-034 implementation paragraph in Active Implementation Phase.
- `BACKLOG.md`, `BACKLOG/BACKLOG_INDEX.md`, and
  `BACKLOG/BOOT-034-next-safe-action-staleness-guard.md` — BOOT-034 moved
  from proposed to in-review with the validator-backed implementation
  decision recorded.
- `IMPLEMENTATION_PLAN.md` — BOOT-034 moved from Phase 2 candidate to
  Phase 2 in-review row.
- `ARTIFACT_REGISTRY.md` — validator and red-check rows bumped, state-file
  rows bumped, BOOT-034 backlog item row updated, and the new review
  package registered.
- `TRACEABILITY_MATRIX.md` — BOOT-034 row updated with validator,
  red-check, and bulk-marking evidence.
- `TEST_RESULTS.md` — new BOOT-034 local validation row.
- `WORKLOG/WORKLOG_INDEX.md` — new BOOT-034 implementation session row.
- `REVIEWS/REVIEW_INDEX.md` — new BOOT-034 review package row.
- `REVIEWS/PR_REVIEW_PACKAGE-2026-05-16-boot-034-next-safe-action-staleness-guard.md`
  (new) — this review package.

## Risk

high

## Acceptance Criteria Mapping

- Stale unmarked historical `Next safe action:` envelope in `AI_HANDOFF.md`
  trips the validator: `case_stale_next_safe_action_historical_fails`.
- Stale unmarked historical `Next safe action:` envelope in
  `CURRENT_STATE.md` trips the validator:
  `case_current_state_stale_next_safe_action_fails`.
- `completed` marker passes: `case_next_safe_action_marked_completed_passes`.
- `superseded` marker passes:
  `case_next_safe_action_marked_superseded_passes`.
- `historical` marker passes:
  `case_next_safe_action_marked_historical_passes`.
- `delegated` marker passes:
  `case_next_safe_action_marked_delegated_passes`.
- The live `## Next Recommended Action` section heading is not over-matched
  and `CURRENT_STATE.md` continues to validate when that section exists:
  `case_next_recommended_action_heading_passes`.
- Narrative prose mentioning `Next safe action:` inside backticks is not
  over-matched: `case_next_safe_action_prose_not_overmatched`.

## Tests Added Or Updated

- Eight new BOOT-034 red-check fixtures listed above.
- No existing fixtures were modified.

## Tests Run

- `bash -n SCRIPTS/validate-bootstrap.sh` — passes.
- `bash -n SCRIPTS/validate-bootstrap-red-checks.sh` — passes.
- Pre-bulk-mark `bash SCRIPTS/validate-bootstrap.sh` failed as expected
  with `AI_HANDOFF.md has 25 unmarked 'Next safe action:' entries`, proving
  the new staleness guard activates on the recorded historical drift.
- Post-bulk-mark `bash SCRIPTS/validate-bootstrap.sh` — passes.
- `bash SCRIPTS/validate-bootstrap-red-checks.sh` — passes with 45 cases
  (37 prior + 8 new BOOT-034 fixtures).
- `git diff --check` — clean.

## Rollout And Rollback

- Rollout: merge after fresh-context Codex adversarial review approves with
  no P0/P1/blocking P2 findings and GitHub `validate` is green. The merge
  commit itself should pass the staleness guard because the bulk marking
  is part of this PR and the new BOOT-034 envelope is the single active
  unmarked entry on the feature branch.
- Rollback: revert the PR. The validator helper, red-check fixtures, and
  bulk-marking edits revert cleanly. No new artifact family, policy, or
  routing model is introduced.

## Traceability Evidence

- `TRACEABILITY_MATRIX.md` BOOT-034 row maps the staleness-guard
  requirement to the new validator helper, eight red checks, bulk marking
  of 25 historical envelopes, and local validation.
- `ARTIFACT_REGISTRY.md` bumps validator (`v1.13`) and red-check (`v1.9`)
  rows; updates state-file rows; updates the BOOT-034 backlog item entry;
  registers this review package.

## Assumptions

- Convention markers (`completed`, `superseded`, `historical`, `delegated`)
  are sufficient to express all current and foreseeable historical-state
  semantics in BOOT-034's scope; the rule is fail-closed, so reviewers can
  request additional markers if needed.
- The bulk-marking edit only adds a `(historical)` prefix and does not
  alter the original payload of any historical `Next safe action:` line,
  so the audit trail remains intact.
- `AI_HANDOFF.md` and `CURRENT_STATE.md` continue to use Markdown list
  bullets (`-` or `*`) for envelope fields; non-list narrative mentions of
  the phrase remain out of scope.

## Open Questions

- Whether to extend the staleness guard to additional locations like review
  records or backlog items in a follow-up PR. The current scope intentionally
  stays narrow to avoid policing review history.
- Whether to add a future-tense marker (`pending`) in addition to the four
  past-tense markers if a use case emerges. Not needed for the current
  review-loop incident.

## Operation Profile Decision

`strict-protected`. Validator behavior changes and red-check fixture
additions fall under the strict-protected profile.

## Branch Strategy

`claude/boot-034-next-safe-action-staleness-guard` cut from latest green
`main` (`f116f85`). PR will target `main`.

## Dirty Worktree Status

Before edits, `git status --short --branch` showed
`## claude/boot-034-next-safe-action-staleness-guard...origin/main` and no
untracked files. The worktree was clean. After edits, only tracked files
in the documented change set are modified.

## Review Notes

Please review:

1. Whether the marker set (`completed`, `superseded`, `historical`,
   `delegated`) is the right minimum and whether `merged`/`applied`/`done`
   should be added (the present design deliberately keeps the marker set
   small and explicit).
2. Whether the regex correctly distinguishes structured envelope fields
   from prose mentions (the validator skips lines starting with `#` and
   requires a bullet `- ` or `* ` plus `Next safe action:`).
3. Whether the staleness guard scope (`AI_HANDOFF.md` + `CURRENT_STATE.md`
   only) is the right boundary. Review records and backlog items
   intentionally remain out of scope.
4. Whether the bulk-marking edit preserves the semantic content of the
   historical envelopes faithfully and does not introduce false-positive
   markers.

## Review Status

Awaiting fresh-context Codex adversarial review.

## Out Of Scope For This PR

- Extending the staleness guard to review records, backlog items, or
  templates.
- Adding additional marker words beyond `completed`, `superseded`,
  `historical`, `delegated`.
- Changing branch/worktree policy, PR/merge policy, hooks, CI workflow,
  role files, command files, context packs, templates, ADRs, security
  policy, release policy, scaffold extraction scripts, metric scripts, or
  runtime product mechanics.
