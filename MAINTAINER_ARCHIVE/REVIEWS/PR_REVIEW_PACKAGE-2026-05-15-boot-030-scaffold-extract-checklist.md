artifact_id: ART-PR-PACKAGE-BOOT-030-SCAFFOLD-EXTRACT-CHECKLIST
title: BOOT-030 Scaffold Extraction Checklist Review Package
type: pr-review-package
status: active
version: v1.0
created: 2026-05-15
updated: 2026-05-15
owner: ProjectGenesis Maintainers
source: BOOT-030 implementation of the scaffold extraction checklist
linked_specs: [SPEC-BOOT-002, SPEC-BOOT-003]
linked_tickets: [BOOT-030]
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# BOOT-030 Scaffold Extraction Checklist Review Package

## PR Title

BOOT-030 add scaffold extraction checklist

## PR Purpose

Introduce `SCAFFOLD_FORK_CHECKLIST.md` as the authoritative human-readable
reset and exclusion policy for turning ProjectGenesis into a clean
downstream project scaffold. Establishes the policy that future BOOT-031
extraction script work must follow, before any script is written.

## Linked Specs

- `SPECS/SPEC-BOOT-002-scaffold-intake-and-governance.md`
- `SPECS/SPEC-BOOT-003-adaptive-governance-routing.md`

## Linked Backlog Items Or Tickets

- `BOOT-030` Scaffold extraction checklist

## Operation Routing

- Routing authority: `OPERATION_ROUTING.md`
- Operation profile: `planning-governance`
- Validation mode: standard
- Pre-change classification location: `AI_HANDOFF.md`, section
  `BOOT-030 Pre-Change Classification`
- Final evidence envelope location: `AI_HANDOFF.md`, section
  `BOOT-030 Final Evidence Envelope`
- Impact map summary: new authoritative checklist artifact plus protected
  planning and source-of-truth updates (registry, traceability, backlog,
  backlog index, BOOT-030 backlog item, current state, handoff, test
  results, worklog, review index, and this review package); no validator,
  hook, CI, shared rule, role file, command file, context pack, template,
  ADR, or runtime mechanics change
- Skipped reads or validations: stack-specific product tests are skipped
  because no product runtime code exists in this repository

## Linked ADRs

- none

## Changed Files

- `SCAFFOLD_FORK_CHECKLIST.md` (new)
- `ARTIFACT_REGISTRY.md`
- `TRACEABILITY_MATRIX.md`
- `BACKLOG.md`
- `BACKLOG/BACKLOG_INDEX.md`
- `BACKLOG/BOOT-030-scaffold-extract-checklist.md`
- `CURRENT_STATE.md`
- `AI_HANDOFF.md`
- `TEST_RESULTS.md`
- `WORKLOG/WORKLOG_INDEX.md`
- `REVIEWS/REVIEW_INDEX.md`
- `REVIEWS/PR_REVIEW_PACKAGE-2026-05-15-boot-030-scaffold-extract-checklist.md`
  (new)

## Summary Of Changes

- Adds `SCAFFOLD_FORK_CHECKLIST.md` at the repository root. The checklist
  defines artifact categories (framework files to keep, ProjectGenesis
  instance/history files to reset or remove, examples/demo files,
  templates, generated/temporary files), clean-state expectations for
  shared state files, manual extraction validation expectations, and
  explicit stop conditions for BOOT-031 script work.
- Registers `ART-SCAFFOLD-FORK-CHECKLIST` and
  `ART-PR-PACKAGE-BOOT-030-SCAFFOLD-EXTRACT-CHECKLIST` in
  `ARTIFACT_REGISTRY.md`.
- Adds a new BOOT-030 row to `TRACEABILITY_MATRIX.md` that links the
  checklist to `SPEC-BOOT-002` and `SPEC-BOOT-003` and to this review
  package.
- Moves BOOT-030 readiness from `ready` to `in-review` in `BACKLOG.md` and
  `BACKLOG/BACKLOG_INDEX.md`, and links implementation evidence in the
  BOOT-030 backlog item file.
- Updates `CURRENT_STATE.md` active phase, branch, worktree, blockers,
  source-of-truth file list, next recommended action, and latest
  validation row.
- Updates `AI_HANDOFF.md` top-level fields, adds the BOOT-030 Pre-Change
  Classification and Final Evidence Envelope blocks, and refreshes the
  trailing Files Changed / Specs Changed / Artifacts Changed / Decisions
  Made / Assumptions Made / Open Questions / Tests Run / Tests Not Run /
  Known Failures / Known Risks / Dirty Worktree Status / Untracked Files /
  Next Recommended Action / Implementation Status sections.
- Adds a BOOT-030 row to `TEST_RESULTS.md` and a BOOT-030 session row to
  `WORKLOG/WORKLOG_INDEX.md`.
- Registers this review package in `REVIEWS/REVIEW_INDEX.md`.

## Acceptance Criteria

- `SCAFFOLD_FORK_CHECKLIST.md` exists at the repository root and is
  registered in `ARTIFACT_REGISTRY.md`.
- The checklist explicitly enumerates framework, instance/history,
  example, template, and generated/temporary artifact categories.
- The checklist defines clean-state expectations for `CURRENT_STATE.md`,
  `AI_HANDOFF.md`, `TRACEABILITY_MATRIX.md`, `BACKLOG.md`, specs,
  reviews, worklogs, test results, and the artifact registry.
- The checklist defines manual extraction validation expectations.
- The checklist defines explicit stop conditions for BOOT-031 script
  work, including metadata schema changes, governance/validator/hook/CI
  changes, ADR/command/context-pack changes, runtime product mutation,
  bundling future slices, and unsanctioned external integrations.
- The PR does not implement `SCRIPTS/scaffold-extract.sh` or any other
  extraction script.
- The PR does not change validators, hooks, CI workflows, role files,
  ADRs, command files, context packs, templates, security/release policy,
  or runtime mechanics.

## Tests Added Or Changed

- No test or validator code changed. The new checklist is documentation
  only.
- Red checks are not extended because validator behavior does not change.

## Test Results

- `bash SCRIPTS/validate-bootstrap.sh` passed locally on
  `claude/boot-030-scaffold-extract-checklist` before commit.
- `bash SCRIPTS/validate-bootstrap-red-checks.sh` passed locally
  (all 19 cases) before commit.
- `git diff --check origin/main...HEAD` clean before commit.
- GitHub Actions `validate` will run after push.

## Known Risks

- The singular `AI_HANDOFF.md` `## Current Branch` field can drift on
  merge to `main`; a small post-merge cleanup commit may be required.
  This is a known structural issue that future per-stream handoff work
  will address; it is not introduced by BOOT-030.
- If BOOT-030 review surfaces a need for new artifact metadata or
  validator structural changes, the PR will stop and re-plan rather than
  expanding into BOOT-031, BOOT-032, or BOOT-033 scope.

## Known Limitations

- The checklist documents a manual extraction policy only. Automation is
  intentionally deferred to BOOT-031.
- The checklist defines clean-state expectations precisely but does not
  attempt to enumerate every per-line content change required during an
  extraction; downstream forkers must read the source-of-truth files they
  are resetting.
- The PR does not modify the public `README.md` to advertise the
  checklist. A minimal README pointer can be considered in a later slice
  if forkers do not discover the file.

## Assumptions

- `main` at `22c79f8` is the correct green base for BOOT-030.
- Adding `SCAFFOLD_FORK_CHECKLIST.md` as a new authoritative artifact does
  not require updating the validator's required-files list; the validator
  checks metadata for any non-template Markdown file and the new file is
  registered in `ARTIFACT_REGISTRY.md`.
- The checklist's clean-state expectations align with the framework
  versions of every reset file at the time of writing; downstream forkers
  are expected to adapt the expectations to the framework versions they
  inherit.

## Unresolved Questions

- Whether BOOT-031 will require new per-artifact metadata to flag
  framework versus instance-history content. The checklist records this
  as a stop condition; BOOT-031 must surface it through the open
  questions register if it arises.
- Whether `research/` should be committed as a separate planning artifact
  or remain untracked. Not blocking BOOT-030.

## Rollout Considerations

- Merge after fresh-context Codex adversarial review approves with no
  blocking findings.
- Plan a small post-merge cleanup commit on `main` if GitHub Actions
  reports the singular handoff-branch drift on the merge commit.
- BOOT-031 script work is the next executable Phase 1 slice once
  BOOT-030 is merged; the checklist is the authoritative policy
  BOOT-031 must follow.

## Rollback Considerations

- Revert the BOOT-030 commit if the checklist policy is rejected.
- No product data, runtime code, validator behavior, CI configuration,
  hooks, or external services are affected, so a revert is a
  documentation-only change.

## Security And Privacy Considerations

- No secrets, credentials, private data, or external integrations are
  added.
- The checklist intentionally instructs downstream forkers to remove
  ProjectGenesis-specific Code Owners and review records, which improves
  fork hygiene rather than weakening security.

## Observability Considerations

- Not applicable; no runtime system changed.

## Traceability Links

- `TRACEABILITY_MATRIX.md` BOOT-030 scaffold extraction checklist row.
- `ARTIFACT_REGISTRY.md` `ART-SCAFFOLD-FORK-CHECKLIST` and
  `ART-PR-PACKAGE-BOOT-030-SCAFFOLD-EXTRACT-CHECKLIST` rows.
- `BACKLOG/BOOT-030-scaffold-extract-checklist.md` implementation
  evidence section.
- `IMPLEMENTATION_PLAN.md` Phase 1 Bootstrap Follow-Up Plan, BOOT-030
  row.

## Artifact Updates

- New authoritative artifact: `SCAFFOLD_FORK_CHECKLIST.md` v1.0.
- New review package: this file, v1.0.
- Registry and traceability advanced; state, handoff, backlog, backlog
  index, BOOT-030 backlog item, test results, worklog, and review index
  updated.

## Worktree And Branch Status

- Branch: `claude/boot-030-scaffold-extract-checklist`
- Worktree:
  `/Users/ahmedabd/Desktop/AI Projects/New Poject bootstrap/.claude/worktrees/brave-elbakyan-be49a2`
- Dirty status: expected BOOT-030 branch changes only
- Untracked files at PR open time: only the two new BOOT-030 artifacts
  (`SCAFFOLD_FORK_CHECKLIST.md` and this review package), both staged in
  the BOOT-030 commit. No `research/` directory is present in this
  worktree.
