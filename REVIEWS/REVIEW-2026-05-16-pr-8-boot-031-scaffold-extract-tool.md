artifact_id: ART-REVIEW-PR-8-BOOT-031-SCAFFOLD-EXTRACT-TOOL
title: PR 8 BOOT-031 Scaffold Extraction Tool Review
type: pr-review
status: active
version: v1.1
created: 2026-05-16
updated: 2026-05-16
owner: AI Bootstrap Maintainers
source: Fresh-context Codex adversarial review of ProjectGenesis PR #8 and implementer review-fix response
linked_specs: [SPEC-BOOT-002, SPEC-BOOT-003]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Adversarial PR Review

## Review Decision

request changes

## Risk Level

high

## Model Or Effort Level Used Or Recommended

adversarial deep

## Reviewer

- Agent: Codex
- Role: Adversarial PR Reviewer
- Date: 2026-05-16

## Inputs Reviewed

- Review package: `REVIEWS/PR_REVIEW_PACKAGE-2026-05-16-boot-031-scaffold-extract-tool.md`
- PR diff or local diff: `gh pr diff 8 --repo mrhussamahmed/ProjectGenesis` failed due `api.github.com` connectivity; reviewed local diff `9e21ce9...HEAD`
- Operation classification: `AI_HANDOFF.md` `## BOOT-031 Pre-Change Classification`
- Final evidence envelope: `AI_HANDOFF.md` `## BOOT-031 Final Evidence Envelope`
- Specs: `SPECS/SPEC_INDEX.md`, `SPECS/SPEC-BOOT-002-scaffold-intake-and-governance.md` status via index, `SPECS/SPEC-BOOT-003-adaptive-governance-routing.md` status via index
- Backlog items or tickets: `BACKLOG.md`, `BACKLOG/BACKLOG_INDEX.md`, `BACKLOG/BOOT-031-scaffold-extract-tool.md`
- ADRs: none linked; `ADR/ADR_INDEX.md` was not changed by the PR
- Tests: `bash SCRIPTS/validate-bootstrap.sh`, `bash SCRIPTS/validate-bootstrap-red-checks.sh`, `git diff --check origin/main...HEAD`, manual extraction to `/tmp/pr8-review-scaffold`
- Traceability: `TRACEABILITY_MATRIX.md` BOOT-031 row
- Artifact registry: `ARTIFACT_REGISTRY.md` BOOT-031 rows and impacted artifact rows
- Current state and handoff: `CURRENT_STATE.md`, `AI_HANDOFF.md`

## Findings

| Severity | File | Evidence | Finding | Required Change |
|----------|------|----------|---------|-----------------|
| P1 | `SCRIPTS/scaffold-extract.sh` | `SCAFFOLD_FORK_CHECKLIST.md:474-482` requires the extracted `ARTIFACT_REGISTRY.md` to include every kept framework file and GitHub config. `SCRIPTS/scaffold-extract.sh:1117-1255` emits the extracted registry, but a review extraction to `/tmp/pr8-review-scaffold` left these kept files without backtick registry entries: `.github/CODEOWNERS`, `.gitignore`, `00_intake/raw/.gitkeep`, `00_intake/summaries/.gitkeep`, `ARTIFACTS/.gitkeep`, `ARTIFACTS/ARCHIVE/.gitkeep`, `COMMANDS/start-requirement-breakdown.md`, `GITHUB_REPOSITORY_SETUP.md`, and `README.md`. | The extraction produces an under-registered scaffold even though those files are kept by rsync and the checklist explicitly requires registry coverage. Bootstrap validation passes, so the shipped golden fixture does not catch this acceptance gap. | Add missing extracted-registry rows or otherwise align the emitted registry with every kept framework file/GitHub config/directory marker required by the checklist, then add or strengthen validation so the gap is caught. |
| P1 | `SCRIPTS/scaffold-extract.sh` | `SCAFFOLD_FORK_CHECKLIST.md:494-504` requires `STALE_ITEMS.md`, `ADR/ADR_INDEX.md`, and `HANDOFFS/HANDOFF_INDEX.md` to reset to empty tables with header rows. The script instead emits `STALE_ITEMS.md` with a bullet list at `SCRIPTS/scaffold-extract.sh:852-855`, emits `ADR/ADR_INDEX.md` with a `none` data row at `SCRIPTS/scaffold-extract.sh:932-936`, and emits `HANDOFFS/HANDOFF_INDEX.md` without a handoff table at `SCRIPTS/scaffold-extract.sh:956-959`. | The reset output does not follow the checklist's clean-state expectations exactly. This violates BOOT-031's core requirement to implement the BOOT-030 reset policy rather than an approximate reset. | Change the emitted reset content for those files to header-only tables matching the checklist, and re-run extraction plus in-target validation. |
| P2 | `SCRIPTS/validate-bootstrap-red-checks.sh` | The four BOOT-031 fixtures at `SCRIPTS/validate-bootstrap-red-checks.sh:333-427` cover golden validation plus three safety refusals. They do not assert exact clean-state reset content or extracted registry completeness; both P1 issues passed `bash SCRIPTS/validate-bootstrap-red-checks.sh`. | The new fixtures do not cover all BOOT-031 acceptance criteria in practice. The golden fixture only proves the current validator passes, not that the checklist's registry and reset-file contracts are satisfied. | Add targeted fixture assertions for extracted registry coverage and exact reset-file shapes, or extend validator coverage if that is the intended enforcement point. |

## Operation Routing Review

- Profile correctness: `strict-protected` is correct because the PR adds `SCRIPTS/scaffold-extract.sh`, modifies validator required files, and changes red-check fixtures.
- Escalation precedence: correct; script and validator mechanics outrank planning-governance/state-sync.
- Protected artifacts: identified in the review package and `AI_HANDOFF.md`; changed-file scope is limited to BOOT-031 script/test/state artifacts.
- Skipped validation rationale: stack-specific product tests are reasonably skipped because no product runtime exists. `gh pr diff` could not be fetched in this environment due network connectivity; local base diff was used as fallback.
- Handoff and evidence durability: durable evidence exists, but it currently overstates checklist conformance because the extracted output has the P1 mismatches above.

## Required Changes

- Fix extracted `ARTIFACT_REGISTRY.md` coverage for kept framework files and GitHub config.
- Fix extracted `STALE_ITEMS.md`, `ADR/ADR_INDEX.md`, and `HANDOFFS/HANDOFF_INDEX.md` reset shapes to match the checklist exactly.
- Add targeted red-check or validation coverage for the above contracts.

## Optional Improvements

- Correct the usage text that says the script skips the "governance performance log" even though `GOVERNANCE_PERFORMANCE.md` is listed as framework material in `SCAFFOLD_FORK_CHECKLIST.md` and is not excluded by the script.

## Evidence For Major Findings

- Local validations before review state edits: `bash SCRIPTS/validate-bootstrap.sh` passed; `bash SCRIPTS/validate-bootstrap-red-checks.sh` passed; `git diff --check origin/main...HEAD` passed.
- PR diff fetch: `gh pr diff 8 --repo mrhussamahmed/ProjectGenesis` failed with `error connecting to api.github.com`.
- Manual extraction evidence: `bash SCRIPTS/scaffold-extract.sh --apply /tmp/pr8-review-scaffold` passed and ran in-target `bash SCRIPTS/validate-bootstrap.sh`, but the extracted scaffold still contained the registry and reset-shape gaps listed in Findings.

## Final Recommendation

Request changes. The PR is correctly scoped and locally validates, but BOOT-031 cannot merge while the extracted scaffold diverges from the authoritative `SCAFFOLD_FORK_CHECKLIST.md` clean-state contract.

## Re-Review Conditions

- Re-run fresh review after the extraction output is updated.
- Required validation for re-review: `bash SCRIPTS/validate-bootstrap.sh`, `bash SCRIPTS/validate-bootstrap-red-checks.sh`, `git diff --check origin/main...HEAD`, and manual `--apply` extraction with targeted inspection of the generated registry and reset files.

## Fix Response

Implementer addressed all P1, P2, and P3 findings in a follow-up commit on
`claude/boot-031-scaffold-extract-tool`:

- P1.1 (extracted registry coverage): `SCRIPTS/scaffold-extract.sh` now emits
  registry rows for every kept framework path the reviewer flagged:
  `README.md`, `GITHUB_REPOSITORY_SETUP.md`, `GOVERNANCE_PERFORMANCE.md`
  (was previously excluded; now mirrored and registered),
  `.github/CODEOWNERS`, `.gitignore`,
  `COMMANDS/start-requirement-breakdown.md`, `00_intake/raw/.gitkeep`,
  `00_intake/summaries/.gitkeep`, `ARTIFACTS/.gitkeep`, and
  `ARTIFACTS/ARCHIVE/.gitkeep`. The script's rsync exclusions also no longer
  drop `GOVERNANCE_PERFORMANCE.md`.
- P1.2 (reset-file shapes): `STALE_ITEMS.md`, `ADR/ADR_INDEX.md`, and
  `HANDOFFS/HANDOFF_INDEX.md` are now emitted as the
  `SCAFFOLD_FORK_CHECKLIST.md` clean-state contract requires:
  - `STALE_ITEMS.md` `## Current Stale Items` is now a header-only table
    (`| Item | Type | Detected | Status | Resolution |` plus separator).
  - `ADR/ADR_INDEX.md` `## ADRs` is now a header-only table; the `| none |
    none | ... |` body row has been removed.
  - `HANDOFFS/HANDOFF_INDEX.md` now includes a header-only handoff table
    (`| Date | Agent | Role | Branch | Worktree | File |` plus separator).
- P2 (fixture coverage): two new red-check fixtures in
  `SCRIPTS/validate-bootstrap-red-checks.sh` enforce the above contracts:
  - `case_scaffold_extract_registry_includes_kept_framework_paths` asserts
    that every reviewer-flagged kept path appears (backtick-quoted) in the
    extracted `ARTIFACT_REGISTRY.md`.
  - `case_scaffold_extract_reset_files_use_header_only_tables` asserts the
    exact header-only table shapes for `STALE_ITEMS.md`,
    `ADR/ADR_INDEX.md`, and `HANDOFFS/HANDOFF_INDEX.md`, and explicitly
    rejects a `none none` ADR body row.
- P3 (usage text): the script header text no longer claims it skips the
  "governance performance log" and now lists `GOVERNANCE_PERFORMANCE.md`
  among the framework files mirrored to the target.

Post-fix validation on `claude/boot-031-scaffold-extract-tool`:

- `bash -n SCRIPTS/scaffold-extract.sh` passes.
- `bash -n SCRIPTS/validate-bootstrap-red-checks.sh` passes.
- `bash SCRIPTS/validate-bootstrap.sh` passes.
- `bash SCRIPTS/validate-bootstrap-red-checks.sh` passes all 25 cases
  (19 prior + 6 BOOT-031 fixtures: four safety/golden plus two new
  registry/reset shape coverage fixtures).
- Manual `--apply` extraction into `/tmp/scaffold-test` followed by
  in-target `bash SCRIPTS/validate-bootstrap.sh` passes, and targeted
  inspection confirms the registry and reset files now match the
  checklist.
- `git diff --check origin/main...HEAD` is clean.

Fresh-context Codex re-review pending after the fix commit is pushed and
GitHub `validate` is green again.
