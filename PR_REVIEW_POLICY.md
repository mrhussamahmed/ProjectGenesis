artifact_id: ART-REVIEW-001
title: PR Review Policy
type: review-policy
status: authoritative
version: v2.0
created: 2026-05-09
updated: 2026-06-10
owner: AI Bootstrap Maintainers
source: User request, reference repository audit, SPEC-BOOT-003, BOOT-STATE-001, and BOOT-GREEN-MERGE-001
linked_specs: [SPEC-BOOT-003]
linked_tickets: [BOOT-STATE-001, BOOT-GREEN-MERGE-001]
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# PR Review Policy

Review depth follows the operation profile per OPERATION_ROUTING.md and
PR_REVIEW_POLICY.md: docs-trivial, docs-non-authoritative, and state-sync
changes require a recorded self-check in the PR body; planning-governance and
strict-protected changes require fresh-context adversarial review.
`docs-public-claim` changes use light fresh-context review, escalating to
adversarial when governance, safety, security, release, dependency,
external-tool, or source-of-truth expectations change. The
`OPERATION_ROUTING.md` profile table Review column and this policy agree and
are jointly authoritative for review depth.

Review is defect detection, not authorization. A clean review does
not unlock a merge by granting a human-style approval; instead, an unresolved
P0, P1, or blocking P2 finding from the review blocks the merge until it is
fixed. P0/P1/blocking P2 findings must not be "accepted with rationale" — they
must be resolved. Non-blocking P2 may be deferred only when the reviewer
explicitly classifies it as non-blocking and the deferral is tracked. Once
required CI/status checks pass, required local validation passes, scope is
clean, and no P0/P1/blocking P2 findings remain, AI may merge per
`PR_MERGE_POLICY.md` without waiting for any human, maintainer, or Code Owner
approval. This applies to every tier: a recorded light-tier self-check plus
green objective gates is sufficient to merge a light-tier PR.

## Review Tiers

- Light tier (self-check): `docs-trivial`, `docs-non-authoritative`, and
  `state-sync`. The implementer records the five-line self-check below in the
  PR body. No review package file and no separate reviewer are needed.
- Fresh-context tier: `docs-public-claim`. A light fresh-context review,
  escalating to adversarial per the `OPERATION_ROUTING.md` profile table.
- Adversarial tier: `planning-governance` and `strict-protected`. Fresh-context
  adversarial review using the Mandatory Checks below.

## Light-Tier Self-Check

The light-tier self-check is exactly these five recorded lines in the PR body:

1. Scope matches profile: yes, with profile named
2. Spec link or rule-based exception:
3. Validation evidence line (which run covered the final diff):
4. No secret or public-claim change: confirmed
5. State updates in the correct split-state location: confirmed

This is the only place the light-tier self-check is defined. Other files cite
this policy instead of restating the lines.

## Fresh Context

At the fresh-context and adversarial tiers, the reviewer must not rely on
implementer chat history. The reviewer reads:

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

- P0: blocker, must be fixed before merge. Must not be accepted with rationale.
- P1: high severity, must be fixed before merge. Must not be accepted with rationale.
- P2: medium severity. Blocking P2 must be fixed before merge and must not be accepted with rationale. Non-blocking P2 may be deferred only when the reviewer explicitly classifies it as non-blocking and the deferral is tracked.
- P3: minor issue or improvement, may be fixed if cheap or tracked as follow-up.

## Review Decisions

The reviewer reports findings and a defect-detection decision:

- no blocking findings
- minor comments only
- blocking findings present (changes required)

These decisions describe whether defects remain to be fixed before merge. They
are not human-style merge authorizations.

## Mandatory Checks

At the adversarial tier (`planning-governance` and `strict-protected`), the
reviewer must check:

- Does the change match the approved or active spec, or a named exception?
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
- Does the PR avoid reintroducing required human, maintainer, or Code Owner
  approval as a merge gate in active authoritative policy?

## Blocking Issues

The reviewer must record a blocking finding for:

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
- reintroduction of required human/maintainer/Code Owner approval as a merge
  gate in active authoritative policy

A blocking finding (P0, P1, or blocking P2) holds the merge until it is
resolved per `PR_MERGE_POLICY.md`. Acceptance-with-rationale is not permitted
for P0, P1, or blocking P2. Non-blocking P2 may be tracked and deferred when
the reviewer explicitly classifies it as non-blocking.

## Reviewer Output

The adversarial-tier reviewer must include:

- defect-detection decision (no blocking findings, minor comments only, or
  blocking findings present)
- risk level
- model or effort level used or recommended
- files reviewed
- specs reviewed
- tests reviewed
- findings by severity
- required changes
- optional improvements
- evidence for each major finding
- final recommendation (which is a defect-detection statement, not a human
  authorization to merge)

High-risk or complex PRs may require two rounds of adversarial review plus
focused security, architecture, QA, and release reviews. The reviewer's role
remains defect detection in all cases.
