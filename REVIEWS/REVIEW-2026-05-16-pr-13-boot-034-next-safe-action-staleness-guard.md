artifact_id: ART-REVIEW-PR-13-BOOT-034-NEXT-SAFE-ACTION-STALENESS-GUARD
title: PR #13 BOOT-034 Next Safe Action Staleness Guard Review
type: pr-review
status: active
version: v1.5
created: 2026-05-16
updated: 2026-05-16
owner: AI Bootstrap Maintainers
source: Fresh-context Codex adversarial review of BOOT-034 PR #13 at head 9d93250 (v1.0 request changes), Claude v1.2 review-fix, fresh-context Codex v1.2 re-review (new blocking P2 on stale descriptions), Claude v1.3 description-alignment, fresh-context Codex v1.3 re-review (new blocking P2 on review-record registry row plus P3 on backlog version), Claude v1.4 micro-fix, fresh-context Codex v1.4 re-review (three new blocking P2 on review-record description, state-file registry row versions, and BOOT-034 traceability row), and Claude v1.5 registry/traceability alignment response
linked_specs: [SPEC-BOOT-003]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# PR #13 BOOT-034 Next Safe Action Staleness Guard Review

## Review Scope

Fresh-context Codex adversarial review of PR #13 BOOT-034 next safe action
staleness guard on `claude/boot-034-next-safe-action-staleness-guard` at head
`9d93250`.

Focus areas challenged:

- Validator regex correctness for structured envelope fields.
- BSD/GNU awk portability.
- Marker set completeness.
- Staleness guard scope boundary (`AI_HANDOFF.md` and `CURRENT_STATE.md`
  only).
- Bulk-marking edit faithfulness.
- Source-of-truth coherence across registry, traceability, current state,
  handoff, test results, worklog, and review index.
- Pre-change classification block against `OPERATION_ROUTING.md` and
  `SPEC-BOOT-003` strict-protected requirements.
- Final evidence envelope compliance with the new rule itself.
- Red-check fixture self-containment.
- Completeness of the PR review package.

## Review Method

Repository files and the PR diff were the only source of truth. Validator
syntax checks, validator/red-check runs, awk-logic edge-case probes, and
`git diff --check origin/main...HEAD` were used to confirm reproducibility.

## v1.0 Decision

Request changes.

## v1.0 Findings

### P0

None.

### P1

- `SCRIPTS/validate-bootstrap.sh:500-519`: staleness guard can undercount
  active stale entries. Empty same-line payloads are ignored, so multiline
  `- Next safe action:` bullets are treated as marked, and marker words are
  accepted anywhere in the payload. Evidence: `payload == ""` skips the
  line; `completed`, `superseded`, `historical`, and `delegated` match
  anywhere in the payload. A probe of the exact awk logic counted `0`
  unmarked entries for active-looking lines containing multiline payload,
  "delegated authority", and "completed upstream".
- `ARTIFACT_REGISTRY.md:69,70,91,96,118,159`: registry metadata is stale or
  inconsistent for changed artifacts. Registry says `ARTIFACT_REGISTRY.md`
  is `v3.52` while file metadata is `v3.53`; `TRACEABILITY_MATRIX.md` is
  registered as `v2.50` while file is `v2.51`; `AI_HANDOFF.md` is
  registered as `v3.59` while file is `v3.58`; `TEST_RESULTS.md`,
  `REVIEWS/REVIEW_INDEX.md`, and `WORKLOG/WORKLOG_INDEX.md` are also one
  version behind in the registry.

### P2

- `SCRIPTS/validate-bootstrap.sh:508-513`,
  `SCRIPTS/validate-bootstrap-red-checks.sh:906-927`: code-blocked
  examples are not excluded. The validator skips prose but will count
  `- Next safe action:` lines inside fenced code blocks.
- `SCRIPTS/validate-bootstrap-red-checks.sh:67-81,831-884`: the
  marker-pass fixtures use `expect_no_failure_mentioning` and therefore
  do not assert validator success — they only check the failure string is
  absent.
- `AI_HANDOFF.md:93-95`: pre-change classification says BOOT-034 status
  changes "from proposed to done," but the rest of the PR records
  BOOT-034 as `in-review`.

### P3

- Marker set omits common historical terms like `merged`, `applied`,
  `done`, `obsolete`, `n/a`. Non-blocking but should be documented.

## v1.2 Review-Fix Response

Implementer applied the following fixes at v1.2:

- P1.1 — `count_unmarked_next_safe_actions` was rewritten to (a) stitch
  multiline bullets so continuation lines are appended to the payload
  until the next bullet, blank line, fence, or section heading; (b) skip
  lines inside Markdown fenced code blocks (` ``` ` and `~~~`); (c)
  require the marker to be at the start of the trimmed payload — either
  as a leading parenthetical like `(historical)` or as a direct marker
  word followed by a non-letter; (d) treat empty payloads as unmarked so
  structurally incomplete envelopes are flagged.
- P1.2 — `ARTIFACT_REGISTRY.md` rows for `ART-REG-001` (v3.52 → v3.54),
  `ART-TRACE-001` (v2.50 → v2.52), `ART-STATE-002` (v3.60 → v3.61),
  `ART-STATE-003` (v3.59), `ART-TEST-003` (v1.78 → v1.80),
  `ART-REVIEW-INDEX` (v2.46 → v2.48), and `ART-WORKLOG-INDEX` (v3.54 →
  v3.56) are aligned with the actual file metadata. `AI_HANDOFF.md` was
  bumped to `v3.59` to match the registry. `CURRENT_STATE.md` was bumped
  to `v3.61`. `TEST_RESULTS.md` bumped to `v1.80`.
  `WORKLOG/WORKLOG_INDEX.md` bumped to `v3.56`. `REVIEWS/REVIEW_INDEX.md`
  bumped to `v2.48`. `TRACEABILITY_MATRIX.md` bumped to `v2.52`.
- P2.1 — fenced code block exclusion implemented in the awk helper. New
  fixture `case_fenced_code_next_safe_action_ignored` asserts illustrative
  bullets inside fenced blocks do not trip the validator.
- P2.2 — all eight BOOT-034 pass fixtures (`completed`, `superseded`,
  `historical`, `delegated`, heading, prose, multiline-marked, fenced)
  now use `expect_success`.
- P2.3 — `AI_HANDOFF.md` pre-change classification wording corrected from
  "proposed to done" to "proposed to in-review".
- P3 — validator comment now documents the canonical four-marker set
  (`completed`, `superseded`, `historical`, `delegated`) and the
  canonical pattern (`Next safe action: completed by PR #N merge; ...`)
  that absorbs `merged`/`applied`/`done`/`obsolete`/`n/a` cases. No new
  markers added; the rule stays narrow and fail-closed.

Four new red-check fixtures were added to validate the tightened logic:

- `case_marker_word_mid_payload_is_not_marker`
- `case_empty_next_safe_action_payload_is_unmarked`
- `case_multiline_marked_next_safe_action_passes`
- `case_fenced_code_next_safe_action_ignored`

Total red-check cases: 49 (45 prior + 4 new BOOT-034 review-fix).

The previous BOOT-034 v1.0 Final Evidence Envelope `Next safe action:`
field is now marked `superseded by the BOOT-034 PR #13 v1.2 Review-Fix
Evidence Envelope below`, and the new v1.2 envelope carries the current
active unmarked next-action line.

## v1.2 Re-Review Decision

Request changes. All six prior findings (P1.1, P1.2, P2.1, P2.2, P2.3,
P3) confirmed fixed. One new blocking P2 finding: the PR review package
and several summaries still described pre-v1.2 behavior, creating a
permanent mismatch between the authoritative review evidence and the
actual implementation. Specific locations:

- `REVIEWS/PR_REVIEW_PACKAGE-2026-05-16-boot-034-next-safe-action-staleness-guard.md`
  lines `:83-85` ("marker words may appear anywhere in the payload",
  "empty payloads are marked") and `:161-175` (eight-fixture / 45-case
  description).
- `REVIEWS/REVIEW_INDEX.md` line `:66` (pre-v1.2 fixture counts).
- `ARTIFACT_REGISTRY.md` lines `:135,164` (PR-package and red-check
  summaries with eight-fixture v1.0 description).
- `BACKLOG/BOOT-034-next-safe-action-staleness-guard.md` lines `:52-66`
  (old whole-word/eight-fixture implementation decision).

## v1.3 Description Alignment Response

Implementer applied the following description-only updates at v1.3:

- PR review package rewritten to describe v1.2 behavior: start-of-payload
  marker requirement, multiline-bullet stitching, fenced-code-block
  exclusion, empty-payload-is-unmarked. Listed all twelve red-check
  fixtures (eight initial plus four v1.2 review-fix), updated test count
  to 49, and documented the v1.2 awk edge-case probe. Bumped review
  package version to v1.2.
- REVIEW_INDEX summary updated to match v1.2 implementation.
- ARTIFACT_REGISTRY rows for validator (`ART-SCRIPT-VALIDATE`),
  red-check (`ART-SCRIPT-VALIDATE-RED`), BOOT-034 backlog item
  (`ART-BACKLOG-BOOT-034`), and PR review package
  (`ART-PR-PACKAGE-BOOT-034-NEXT-SAFE-ACTION-STALENESS-GUARD`) updated
  to describe v1.2 behavior. PR-package row bumped to v1.2, backlog row
  bumped to v1.3.
- BACKLOG item v1.3 with the Implementation Decision section rewritten
  to describe v1.2 behavior and twelve fixtures.
- This review record updated with the v1.2 re-review verdict and v1.3
  fix response.
- Source-of-truth version bumps: ARTIFACT_REGISTRY v3.55, CURRENT_STATE
  v3.62, AI_HANDOFF v3.60, TEST_RESULTS v1.81, WORKLOG v3.57,
  REVIEW_INDEX v2.49, TRACEABILITY_MATRIX v2.53.

No validator script or red-check fixture behavior change in v1.3; only
description-level alignment.

## v1.3 Re-Review Decision

Request changes. v1.2 blocking P2 (stale descriptions) confirmed
resolved. One new blocking P2 and one P3 found:

- P2 (blocking) — `ARTIFACT_REGISTRY.md:136` registered the review
  record (this file) as `v1.2` with description "Awaiting fresh-context
  re-review at v1.2 head," but the review record header had already
  been bumped to `v1.3` in the v1.3 commit. Registry row was not
  updated.
- P3 — `REVIEWS/PR_REVIEW_PACKAGE-2026-05-16-boot-034-next-safe-action-staleness-guard.md:43`
  still referenced `BACKLOG/BOOT-034-next-safe-action-staleness-guard.md`
  as "in-review at v1.1" while the backlog item metadata is at v1.3.

## v1.4 Micro-Fix Response

Implementer applied two targeted description fixes at v1.4:

- Bumped the `ART-REVIEW-PR-13-BOOT-034-NEXT-SAFE-ACTION-STALENESS-GUARD`
  registry row from `v1.2` to `v1.3` and updated its description to
  mention the v1.2 re-review verdict and v1.3 description-alignment
  response.
- Updated the PR review package linked-backlog line from "in-review at
  v1.1" to "in-review at v1.3".
- Bumped state-file versions: `ARTIFACT_REGISTRY.md` v3.55 → v3.56,
  `AI_HANDOFF.md` v3.60 → v3.61, `CURRENT_STATE.md` v3.62 → v3.63,
  `TEST_RESULTS.md` v1.81 → v1.82, `WORKLOG/WORKLOG_INDEX.md` v3.57 →
  v3.58, `REVIEWS/REVIEW_INDEX.md` v2.49 → v2.50, and this review
  record v1.3 → v1.4.
- Updated the BOOT-034 PR #13 v1.3 Description Alignment Evidence
  Envelope `Next safe action:` to describe the v1.4 micro-fix and
  request fresh-context Codex re-review at the v1.4 head.

No validator-script, red-check-fixture, design, or scope-of-policy
changes in v1.4.

## v1.4 Re-Review Decision

Request changes. v1.3 P2 (review-record registry row) and P3 (backlog
version reference) confirmed resolved. Three new blocking P2 findings:

- P2-A — `ARTIFACT_REGISTRY.md:136` review-record row was bumped to
  v1.3 in the v1.4 commit but its description still said "Awaiting
  fresh-context re-review at v1.3 head" with no mention of the v1.4
  micro-fix.
- P2-B — state-file registry rows (`ART-REG-001:69`,
  `ART-STATE-002:90`, `ART-STATE-003:91`, `ART-TEST-003:96`,
  `ART-REVIEW-INDEX:118`, `ART-WORKLOG-INDEX:160`) still listed old
  file versions; the corresponding file headers had been bumped to
  v3.56, v3.63, v3.61, v1.82, v2.50, v3.58 respectively in v1.4 but
  the registry rows were not updated to match.
- P2-C — `TRACEABILITY_MATRIX.md:77` BOOT-034 row still described the
  review record as v1.3 and said it was "awaiting fresh-context
  re-review at the v1.3 head" with no v1.4 evidence.

## v1.5 Registry/Traceability Alignment Response

Implementer applied the following description-only updates at v1.5:

- Bumped state-file registry rows to match actual file metadata:
  `ART-REG-001` v3.55 → v3.57; `ART-STATE-002` v3.62 → v3.64;
  `ART-STATE-003` v3.60 → v3.62; `ART-TEST-003` v1.81 → v1.83;
  `ART-REVIEW-INDEX` v2.49 → v2.51; `ART-WORKLOG-INDEX` v3.57 → v3.59.
- Bumped `ART-REVIEW-PR-13-...` review-record row from v1.3 → v1.5
  with cumulative description including v1.0 request-changes, v1.2
  review-fix, v1.2 re-review P2, v1.3 description alignment, v1.3
  re-review P2/P3, v1.4 micro-fix, v1.4 re-review P2-A/B/C, and v1.5
  alignment response.
- Updated the `TRACEABILITY_MATRIX.md` BOOT-034 row to include the
  v1.4 micro-fix and v1.5 alignment in the source notes and description.
  Bumped `TRACEABILITY_MATRIX.md` from v2.53 → v2.54, with
  `ART-TRACE-001` registry row bumped to match.
- Bumped registry itself: `ARTIFACT_REGISTRY.md` v3.56 → v3.57.
- Bumped state-file file metadata: `AI_HANDOFF.md` v3.61 → v3.62,
  `CURRENT_STATE.md` v3.63 → v3.64, `TEST_RESULTS.md` v1.82 → v1.83,
  `WORKLOG/WORKLOG_INDEX.md` v3.58 → v3.59,
  `REVIEWS/REVIEW_INDEX.md` v2.50 → v2.51, this review record v1.4 →
  v1.5.
- Updated the AI_HANDOFF v1.3 envelope `Next safe action:` and the
  CURRENT_STATE next-recommended-action to point at the v1.5 head.

No validator-script, red-check-fixture, or design changes in v1.5.

## v1.5 Status

Awaiting fresh-context Codex re-review at the v1.5 head. Local
validation passed:

- `bash -n SCRIPTS/validate-bootstrap.sh` — passes
- `bash -n SCRIPTS/validate-bootstrap-red-checks.sh` — passes
- `bash SCRIPTS/validate-bootstrap.sh` — passes
- `bash SCRIPTS/validate-bootstrap-red-checks.sh` — passes with 49
  cases (unchanged from v1.2; v1.3 through v1.5 are description-only)
- `git diff --check` — clean

## Out Of Scope

- Validator behavior beyond the BOOT-034 staleness guard.
- Hooks, CI workflow files, shared rules, role files, command files,
  context packs, templates, ADRs, governance policy, operation routing
  policy, branch/worktree policy, PR/merge policy, risk model,
  architecture, security, release, scaffold extraction script, metric
  scripts, seeded-defect benchmark, or runtime product files.
