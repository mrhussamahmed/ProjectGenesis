artifact_id: ART-BACKLOG-BOOT-030
title: BOOT-030 Scaffold Extraction Checklist
type: backlog-item
status: active
version: v1.4
created: 2026-05-15
updated: 2026-05-15
owner: AI Bootstrap Maintainers
source: Phase 1 execution planning input promoted into tracked backlog, PR #6 review fix, PR #6 merge/post-merge source-of-truth cleanup, BOOT-030 implementation evidence linked, PR #7 Codex adversarial review and re-review approval, and PR #7 merge/post-merge source-of-truth cleanup
linked_specs: [SPEC-BOOT-002, SPEC-BOOT-003]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# BOOT-030: Scaffold Extraction Checklist

## Purpose

Define the human-readable extraction policy for turning ProjectGenesis into a
clean downstream project scaffold before writing an extraction script.

## User Or System Value

Removes the biggest reuse blocker: downstream users should not inherit
ProjectGenesis-specific BOOT history, review records, and stale handoff state.

## Scope

In scope:

- Create `SCAFFOLD_FORK_CHECKLIST.md`.
- Define which artifacts are framework files, instance history, examples, or
  reset templates.
- Define the clean-state expectations for `CURRENT_STATE.md`, `AI_HANDOFF.md`,
  `TRACEABILITY_MATRIX.md`, `BACKLOG.md`, specs, reviews, and worklogs.
- Define validation expectations for a manually extracted scaffold.

Out of scope:

- Writing `SCRIPTS/scaffold-extract.sh`.
- Changing validators.
- Adding new metadata fields.
- Editing public README claims beyond a minimal pointer if needed.

## Links

- Linked spec: `SPEC-BOOT-002`, `SPEC-BOOT-003`
- Linked acceptance criteria: `SCAFFOLD_FORK_CHECKLIST.md` exists and is
  registered; extraction policy is reviewable before script work.
- Linked requirements: scaffold reuse, source-of-truth reset safety
- Source IDs: none; source evidence is the current user instruction to plan
  before implementation and the durable Phase 1 candidate list in
  `CURRENT_STATE.md`.
- Approved assumptions: none
- Planning rationale: checklist-first sequencing was approved through PR #6;
  BOOT-030 is the next executable Phase 1 slice after latest `main` validation
  is confirmed green.
- Open questions: whether later script needs per-artifact metadata
- Related ADR: none
- Related external ticket: none

## Dependencies

- BOOT-029 merged.

## Risks

- Checklist might miss a ProjectGenesis-specific artifact. Mitigate by
  requiring fresh-context review before script implementation.

## Suggested Owner Role

Documentation Curator

## Estimated Complexity

medium

## Implementation Phase

Phase 1A.

## Related Files Or Modules

- `SCAFFOLD_FORK_CHECKLIST.md`
- `ARTIFACT_REGISTRY.md`
- `TRACEABILITY_MATRIX.md`
- `CURRENT_STATE.md`
- `AI_HANDOFF.md`
- `TEST_RESULTS.md`
- `WORKLOG/WORKLOG_INDEX.md`

## Linear Ticket

- Should become external ticket: no
- Tracker: none
- Ticket status: not-created
- Ticket ID or URL:
- Confirmation evidence:

## Priority

P0

## Readiness Status

done

## Readiness Evidence

- Source evidence: current user instruction to execute BOOT-030
  autonomously, current-state Phase 1 candidates, and BOOT-029 sequencing
  merged through PR #6 on 2026-05-15.
- Spec status: `SPEC-BOOT-002` active; `SPEC-BOOT-003` approved.
- Acceptance criteria: `SCAFFOLD_FORK_CHECKLIST.md` records artifact
  categories, clean-state expectations, manual extraction validation, and
  explicit stop conditions for BOOT-031.
- Dependencies: BOOT-029 plan merged.
- Architecture impact: none; no new metadata fields or validator
  structural checks are introduced.
- Test expectations: bootstrap validation and diff check pass; red checks
  not required because validator behavior does not change.
- Branch/worktree plan: branch `claude/boot-030-scaffold-extract-checklist`
  from green `main` (`22c79f8`).
- Required reviewers: fresh-context Codex adversarial review through the
  installed plugin once the PR is open and GitHub `validate` checks are
  green.
- Blocked until: none.

## Test Expectations

- `bash SCRIPTS/validate-bootstrap.sh`
- `bash SCRIPTS/validate-bootstrap-red-checks.sh`
- `git diff --check`
- Red checks not required unless validator behavior changes; running them
  on this branch is a sanity check only.

## Definition Of Done

- [x] Spec linked (`SPEC-BOOT-002`, `SPEC-BOOT-003`).
- [x] Acceptance criteria satisfied — `SCAFFOLD_FORK_CHECKLIST.md`
  registered in `ARTIFACT_REGISTRY.md` and merged.
- [x] Tests added or updated, or justified — bootstrap validation, red
  checks, and diff check are the only required tests; stack-specific tests
  are not applicable because no product runtime code exists.
- [x] Traceability updated — BOOT-030 row in `TRACEABILITY_MATRIX.md`
  links to the checklist, the PR review package, and the approved Codex
  review record.
- [x] Artifact registry updated — `ART-SCAFFOLD-FORK-CHECKLIST` and
  `ART-PR-PACKAGE-BOOT-030-SCAFFOLD-EXTRACT-CHECKLIST` registered;
  source-of-truth versions advanced through the merge and post-merge
  cleanup.
- [x] Handoff updated — `AI_HANDOFF.md` records the BOOT-030 work,
  Codex review, fix response, re-review approval, merge, and post-merge
  cleanup.
- [x] Review complete — fresh-context Codex adversarial review requested
  changes for one P1 and one P2 finding; both resolved in follow-up
  commit `b6f3104`; fresh-context Codex re-review approved at head
  `9c8d65c`. PR #7 merged to `main` at
  `90668945bfd24f547ee6ea7f6d1996e7f36c083e`.

## Parallelization

- Status: not-allowed
- File ownership boundaries: owns extraction checklist and related
  source-of-truth records only.
- Shared files requiring coordination: registry, traceability, state, handoff,
  test results, worklog.
- Stop conditions: script or validator changes become necessary; in that
  case stop and record the blocker in `OPEN_QUESTIONS.md` or
  `STALE_ITEMS.md` rather than expanding BOOT-030 scope.

## Implementation Evidence

- Branch: `claude/boot-030-scaffold-extract-checklist` from green `main`
  (`22c79f8`).
- Worktree:
  `/Users/ahmedabd/Desktop/AI Projects/New Poject bootstrap/.claude/worktrees/brave-elbakyan-be49a2`
- New artifact: `SCAFFOLD_FORK_CHECKLIST.md` v1.0
  (`ART-SCAFFOLD-FORK-CHECKLIST`).
- New artifact: `REVIEWS/PR_REVIEW_PACKAGE-2026-05-15-boot-030-scaffold-extract-checklist.md`
  v1.0 (`ART-PR-PACKAGE-BOOT-030-SCAFFOLD-EXTRACT-CHECKLIST`).
- Updated source-of-truth records: `ARTIFACT_REGISTRY.md`,
  `TRACEABILITY_MATRIX.md`, `BACKLOG.md`, `BACKLOG/BACKLOG_INDEX.md`, this
  backlog item, `CURRENT_STATE.md`, `AI_HANDOFF.md`, `TEST_RESULTS.md`,
  `WORKLOG/WORKLOG_INDEX.md`, and `REVIEWS/REVIEW_INDEX.md`.
- Local validation: `bash SCRIPTS/validate-bootstrap.sh`,
  `bash SCRIPTS/validate-bootstrap-red-checks.sh`, and
  `git diff --check origin/main...HEAD` pass before commit.
