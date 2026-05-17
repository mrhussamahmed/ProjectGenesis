artifact_id: ART-REVIEW-001
title: PR Review Policy
type: review-policy
status: authoritative
version: v1.2
created: 2026-05-09
updated: 2026-05-17
owner: AI Bootstrap Maintainers
source: User request, reference repository audit, SPEC-BOOT-003, and BOOT-STATE-001
linked_specs: [SPEC-BOOT-003]
linked_tickets: [BOOT-STATE-001]
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# PR Review Policy

Every PR requires a fresh-context adversarial review.

## Fresh Context

The reviewer must not rely on implementer chat history. The reviewer reads:

- review package
- PR diff or local diff
- operation classification and evidence envelope from `OPERATION_ROUTING.md`
- relevant specs
- relevant ADRs
- tests and test results
- backlog items or tickets
- traceability matrix
- artifact registry
- current state and handoff

## Branch-Specific State

Branch-specific current status, active worktree, next branch action, and
temporary validation state belong in the PR body, PR comments, or review
package. They must not be active facts in committed canonical state files.

Normal low-risk PR review evidence may live in GitHub PR reviews or PR
comments. High-risk, governance, validator, hook, CI, role, or
source-of-truth changes need a durable review object: either a GitHub review
object or a committed review record under `REVIEWS/`.

## Severity Levels

- P0: blocker, must be fixed before merge.
- P1: high severity, must be fixed before merge unless explicitly accepted with
  documented rationale.
- P2: medium severity, should be fixed before merge unless clearly
  non-blocking and tracked.
- P3: minor issue or improvement, may be fixed if cheap or tracked as follow-up.

## Review Decisions

- approve
- approve with minor comments
- request changes
- block

## Mandatory Checks

The reviewer must check:

- Does the change match the approved or active spec?
- Are acceptance criteria satisfied?
- Are tests adequate and mapped?
- Are edge cases handled?
- Are security and privacy risks addressed?
- Is there architecture drift or product scope drift?
- Was stale documentation or stale code used as current truth?
- Are artifacts and traceability updated?
- Is handoff or PR evidence updated in the correct split-state location?
- Are errors and failure modes handled?
- Is observability adequate?
- Is the change too broad or unrelated?
- Are generated files and dependencies justified?
- Are migrations safe and rollback possible?
- Are hidden assumptions present?
- Is there evidence of hallucinated claims?
- Was the operation classified before target edits, and does the selected
  profile match the touched files, protected artifacts, validation, and review
  evidence?
- Are skipped reads, skipped validation, and not-impacted artifacts justified by
  the operation profile and impact map?
- Do committed canonical state files avoid active branch/session facts that
  would become false after merge?

## Blocking Issues

Block or request changes for:

- implementation does not match approved spec
- missing or inadequate tests for meaningful behavior
- unaddressed security or privacy risk
- destructive migration without rollback or backup plan
- undocumented architecture change
- stale artifact used as current truth
- missing traceability for important requirement
- unexplained dirty worktree or unrelated changes
- missing required PR evidence or durable handoff/state update in the correct
  split-state location after significant work
- high uncertainty without spike or open question

## Reviewer Output

The reviewer must include:

- review decision
- risk level
- model or effort level used or recommended
- files reviewed
- specs reviewed
- tests reviewed
- findings by severity
- required changes
- optional improvements
- evidence for each major finding
- final recommendation

High-risk or complex PRs may require two rounds of adversarial review plus
focused security, architecture, QA, and release reviews.
