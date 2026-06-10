artifact_id: ART-SCAFFOLD-FORK-CHECKLIST
title: Scaffold Fork Checklist
type: guide
status: authoritative
version: v2.0
created: 2026-05-15
updated: 2026-06-10
owner: AI Bootstrap Maintainers
source: BOOT-030 Phase 1 execution planning input and BOOT-029 merged
  sequencing decision in `IMPLEMENTATION_PLAN.md`
linked_specs: [SPEC-BOOT-002, SPEC-BOOT-003]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Scaffold Fork Checklist

This file is the human-readable policy for turning ProjectGenesis into a
clean downstream project scaffold. Use `bash SCRIPTS/scaffold-extract.sh`
(dry-run by default; `--apply` to write). This checklist is the manual
fallback and the policy reference.

The extraction tool shipped as the BOOT-031 deliverable. Where this
checklist and `TEMPLATE_MANIFEST.md` or `SCRIPTS/scaffold-extract.sh`
disagree on a path's keep/reset/exclude treatment, the manifest and the
extractor are authoritative and this checklist should be updated.

## Purpose

When a downstream team forks or copies ProjectGenesis to start a new
project, they should inherit the reusable governance framework but not the
ProjectGenesis-specific instance history, review records, or stale
operational state. This checklist defines exactly which artifacts are
reusable framework, which are ProjectGenesis-specific instance history,
which are examples, which are templates, and which are generated or
temporary. It also defines the clean-state expectations for shared state
files after an extraction.

## How To Use This Checklist

1. Read the source-of-truth files first:
   `AI_PROJECT_BOOTSTRAP.md`, `GOVERNANCE.md`, `OPERATION_ROUTING.md`,
   `CONTEXT_INDEX.md`, `BRANCH_AND_WORKTREE_GUIDE.md`,
   `ARTIFACT_REGISTRY.md`, and `TRACEABILITY_MATRIX.md`.
2. Make a fresh clone or copy of ProjectGenesis at the latest green `main`.
3. Apply each category below in order: keep framework files, reset or
   remove instance history, decide on examples, keep templates, remove
   generated or temporary files.
4. Reset the listed shared state files to the clean-state contents defined
   below.
5. Run the manual extraction validation in the
   `## Manual Extraction Validation` section.
6. If any step requires changing validators, hooks, CI, role files, ADRs,
   metadata schemas, or repository policy, stop and follow the
   `## Stop Conditions For Extraction Changes` rules instead of expanding
   scope.

The checklist is intentionally explicit about every reused path. When in
doubt, prefer keeping a registered authoritative artifact unless it is
clearly listed below as instance history.

## Artifact Categories

### Framework Files To Keep

These files are reusable governance, templates, validation, and shared
role infrastructure. They should be copied into the extracted scaffold
unchanged unless explicitly noted.

Governance and operating model:

- `AI_PROJECT_BOOTSTRAP.md`
- `GOVERNANCE.md`
- `GOVERNANCE_PERFORMANCE.md`
- `OPERATION_ROUTING.md`
- `CONTEXT_INDEX.md`
- `BRANCH_AND_WORKTREE_GUIDE.md`
- `RISK_MODEL.md`
- `PR_REVIEW_POLICY.md`
- `PR_MERGE_POLICY.md`
- `AI_REVIEW_PROMPTS.md`
- `HOOKS_AND_GUARDRAILS.md`
- `SECURITY_AND_PRIVACY.md`
- `OBSERVABILITY.md`
- `CI_CD_GUIDE.md`
- `RELEASE_READINESS.md`
- `CONTRIBUTING.md`
- `BOOTSTRAP_USAGE.md`
- `NEW_PROJECT_INITIALIZATION.md`
- `ARCHITECTURE.md`
- `DECISIONS.md`

Agent entrypoints and shared role system:

- `AGENTS.md`
- `CLAUDE.md`
- `memory/ai/SHARED_AGENT_RULES.md`
- `memory/ai/ROLE_PRODUCT_ANALYST.md`
- `memory/ai/ROLE_SPEC_AUTHOR.md`
- `memory/ai/ROLE_ARCHITECT.md`
- `memory/ai/ROLE_BACKLOG_PLANNER.md`
- `memory/ai/ROLE_IMPLEMENTATION_AGENT.md`
- `memory/ai/ROLE_QA_REVIEWER.md`
- `memory/ai/ROLE_SECURITY_REVIEWER.md`
- `memory/ai/ROLE_DEVOPS_RELEASE_REVIEWER.md`
- `memory/ai/ROLE_DOCUMENTATION_CURATOR.md`
- `memory/ai/ROLE_ADVERSARIAL_PR_REVIEWER.md`
- `memory/ai/ROLE_DIAGRAM_ARCHITECT.md`

Intake, context, and requirements scaffolding (canonical empty form):

- `00_intake/INTAKE_INDEX.md`
- `00_intake/SOURCE_REGISTRY.md`
- `00_intake/raw/.gitkeep`
- `00_intake/summaries/.gitkeep`
- `01_context/PROJECT_BRIEF.md`
- `01_context/PROJECT_CHARTER.md`
- `01_context/GLOSSARY.md`
- `01_context/CONSTRAINTS.md`
- `02_requirements/REQUIREMENTS_INDEX.md`
- `02_requirements/ASSUMPTIONS_REGISTER.md`
- `02_requirements/RISK_REGISTER.md`

Context packs and command framework:

- `CONTEXT_PACKS/README.md`
- `CONTEXT_PACKS/product-intake.md`
- `CONTEXT_PACKS/spec-authoring.md`
- `CONTEXT_PACKS/architecture.md`
- `CONTEXT_PACKS/implementation.md`
- `CONTEXT_PACKS/review.md`
- `CONTEXT_PACKS/resume.md`
- `COMMANDS/COMMAND_INDEX.md`
- `COMMANDS/COMMAND_TEMPLATE.md`
- `COMMANDS/start-requirement-breakdown.md`

Validation, hooks, CI, and licensing:

- `SCRIPTS/start-claude.sh`
- `SCRIPTS/validate-bootstrap.sh`
- `SCRIPTS/validate-bootstrap-red-checks.sh`
- `.githooks/pre-commit`
- `.githooks/commit-msg`
- `.githooks/pre-push`
- `.github/workflows/bootstrap-validation.yml`
- `.github/CODEOWNERS` (downstream forkers should replace the owner
  handle with their own before publishing)
- `.gitignore`
- `LICENSE` (downstream forkers must keep AGPLv3 or replace per their own
  license requirements before publishing)

Tests, audit, and bootstrap baseline:

- `BOOTSTRAP_AUDIT.md`
- `TEST_STRATEGY.md`
- `TEST_PLAN.md`
- `TESTS/MANUAL_TEST_CHECKLIST.md`
- `TESTS/ACCEPTANCE_CRITERIA_MAP.md`

This scaffold extraction checklist itself is also framework material:

- `SCAFFOLD_FORK_CHECKLIST.md`

The `README.md` is a framework file but its content references the
ProjectGenesis instance. Downstream forkers should keep the file and
rewrite the project-specific text (project name, public claims, owner,
launch links, current state summary) for their own project before
publishing. (`SCRIPTS/scaffold-extract.sh` emits a neutral starter README
automatically. `GITHUB_REPOSITORY_SETUP.md` is maintainer-only per
`TEMPLATE_MANIFEST.md` and is not part of the extracted scaffold.)

### ProjectGenesis Instance Or History Files To Reset Or Remove

These files contain ProjectGenesis-specific operational state, history, or
records. They should be reset to a clean state (see
`## Clean-State Expectations` for exact contents) or removed before
publishing the downstream scaffold.

Operational state (reset, do not delete):

- `CURRENT_STATE.md` — reset to clean-state contents.
- `AI_HANDOFF.md` — reset to clean-state contents.
- `OPEN_QUESTIONS.md` — reset to clean-state contents.
- `STALE_ITEMS.md` — maintainer-only; excluded from extracted output
  (a downstream project can recreate the pattern if needed).
- `TEST_RESULTS.md` — reset to clean-state contents.
- `WORKLOG/WORKLOG_INDEX.md` — reset to clean-state contents.

Planning, backlog, and traceability (reset, do not delete):

- `BACKLOG.md` — reset to clean-state contents.
- `BACKLOG/BACKLOG_INDEX.md` — reset to clean-state contents.
- `IMPLEMENTATION_PLAN.md` — reset to clean-state contents.
- `PARALLEL_EXECUTION_PLAN.md` — maintainer-only; excluded from extracted
  output.
- `TRACEABILITY_MATRIX.md` — reset to clean-state contents.
- `ARTIFACT_REGISTRY.md` — reset to clean-state contents
  (the registry must continue to list every framework file kept above).

Specs and ADRs (reset spec and ADR sets, keep templates and indexes):

- `SPECS/SPEC_INDEX.md` — reset to clean-state contents.
- `SPECS/SPEC-BOOT-*.md` — already relocated to `MAINTAINER_ARCHIVE/SPECS/`
  in slice 2; confirm none remain under active `SPECS/`.
- `ADR/ADR_INDEX.md` — reset to clean-state contents.

ProjectGenesis backlog items: the PG per-item files (BOOT-029 through
BOOT-035) were relocated to `MAINTAINER_ARCHIVE/BACKLOG/` in slice 2 and
are excluded with the rest of `MAINTAINER_ARCHIVE/`.

General rule for forks taken after later instance items are added:

- Remove every `BACKLOG/BOOT-*.md` per-item file outside the BOOT-001
  through BOOT-008 range present in the `BACKLOG/` directory at extraction
  time, regardless of the BOOT number. The BOOT-001 through BOOT-008
  generic scaffold-bringup items are kept by `BACKLOG.md`'s clean-state
  expectation below; per-item files in that range are kept only if they
  exist and remain framework material.
- Remove the matching rows from `BACKLOG.md` and the matching rows from
  `BACKLOG/BACKLOG_INDEX.md` as part of the `BACKLOG.md` clean-state
  reset.
- Remove the matching registry rows from `ARTIFACT_REGISTRY.md` (typically
  `ART-BACKLOG-BOOT-*`) so the registry continues to cover only the files
  that remain on disk.
- Remove the matching traceability rows from `TRACEABILITY_MATRIX.md`.

Templates are kept; the `BACKLOG/templates/BACKLOG_ITEM_TEMPLATE.md` is
framework material.

ProjectGenesis review records and packages (remove all dated PR review
files, keep the `REVIEW_INDEX.md` and `REVIEWS/templates/` set):

- `REVIEWS/REVIEW_INDEX.md` — reset to clean-state contents.
- `REVIEWS/REVIEW-2026-*.md` (every dated ProjectGenesis review file) —
  remove.
- `REVIEWS/PR_REVIEW_PACKAGE-2026-*.md` (every dated ProjectGenesis PR
  review package) — remove.
- `REVIEWS/templates/ADVERSARIAL_PR_REVIEW_TEMPLATE.md` — keep.
- `REVIEWS/templates/PR_REVIEW_PACKAGE_TEMPLATE.md` — keep.

### Examples Or Demo Files

These files exist to demonstrate ProjectGenesis to public visitors. They
are not part of the framework and should be removed before publishing a
downstream scaffold unless the downstream team wants to keep them as
illustrative examples.

- `examples/simple-saas-demo/README.md`
- `examples/simple-saas-demo/00_raw_input/freelancer-invoice-app.md`
- `examples/simple-saas-demo/01_expected_outputs/product-brief.md`
- `examples/simple-saas-demo/01_expected_outputs/requirements.md`
- `examples/simple-saas-demo/01_expected_outputs/assumptions-and-open-questions.md`
- `examples/simple-saas-demo/01_expected_outputs/backlog-candidates.md`
- `examples/simple-saas-demo/01_expected_outputs/validation-checklist.md`

The PG launch/demo/release notes (`docs/`) and PG-branded
`.github/ISSUE_TEMPLATE/` files were relocated to `MAINTAINER_ARCHIVE/`
in slice 2 and are excluded with the rest of that folder. The current
top-level `docs/` holds maintainer planning history only and is likewise
excluded from extraction.

Removal guidance:

- Downstream forkers who want to keep their own examples should remove
  the ProjectGenesis examples first, then add their own under
  `examples/` and register them in `ARTIFACT_REGISTRY.md`.
- Downstream forkers who delete the example set should also remove the
  registry rows for `ART-EXAMPLE-*` and `ART-LAUNCH-*` artifacts, and
  remove any traceability rows that cite them.

### Templates

Templates are framework material and should always be kept unchanged.

- `SPECS/templates/SPEC_TEMPLATE.md`
- `ADR/templates/ADR_TEMPLATE.md`
- `BACKLOG/templates/BACKLOG_ITEM_TEMPLATE.md`
- `REVIEWS/templates/PR_REVIEW_PACKAGE_TEMPLATE.md`
- `REVIEWS/templates/ADVERSARIAL_PR_REVIEW_TEMPLATE.md`
- `COMMANDS/COMMAND_TEMPLATE.md`

The validator already skips templates from metadata and placeholder
checks. Templates may continue to use placeholder instruction text inside
their fields without tripping the validator.

### Generated Or Temporary Files To Remove

- `research/` — disposable scientific-review output from multi-pass
  adversarial review runs. The validator `-prune`s this directory, but it
  should not ship with a downstream scaffold.
- `.claude/` — Claude Code worktree and harness state. Local to the agent
  environment; not part of the scaffold.
- `ARTIFACTS/ARCHIVE/` contents — keep the directory (per validator
  required-dirs) but remove ProjectGenesis-specific archived artifacts.
- `/tmp/bootstrap-placeholder-hit.*` — transient validator scratch files,
  not committed.
- `node_modules/`, `dist/`, `build/`, `.venv/`, `__pycache__/`, and any
  other stack-specific generated output that may exist in a downstream
  fork — remove and ignore.

The framework keeps `00_intake/raw/.gitkeep` and
`00_intake/summaries/.gitkeep` so the canonical intake directories remain
present. Do not delete these markers.

## Clean-State Expectations

Each reset file below must contain a small, neutral set of facts that lets
a downstream project pick up the scaffold and start its own intake without
inheriting ProjectGenesis history. The expectations use precise wording so
extraction is reviewable.

### `CURRENT_STATE.md`

- Metadata block matches the framework artifact rules.
- `version: v1.0` (initial downstream version).
- `## Active Specs` lists `None.`
- `## Proposed Specs` lists `None.`
- `## Active Architecture` references `ARCHITECTURE.md` only.
- `## Active ADRs` lists `None. ADR/ADR_INDEX.md is initialized and ready
  for project-specific decisions.`
- `## Active Implementation Phase` lists `Phase 0: scaffold bootstrap.
  No implementation work yet.`
- `## Active Branch` lists `main`.
- `## Active Worktree` lists `none (no agent worktrees configured yet)`.
- `## Active Backlog Focus` lists `Downstream project intake using the
  reusable scaffold.`
- `## Current Blockers` lists `No product-specific input has been provided
  for a downstream software project.`
- `## Current Source-Of-Truth Files` lists only generic framework files
  (`AI_PROJECT_BOOTSTRAP.md`, `GOVERNANCE.md`, `CONTEXT_INDEX.md`,
  `memory/ai/SHARED_AGENT_RULES.md`, `memory/ai/ROLE_*.md`,
  `ARTIFACT_REGISTRY.md`, `TRACEABILITY_MATRIX.md`,
  `SPECS/SPEC_INDEX.md`, `ARCHITECTURE.md`, `BACKLOG.md`,
  `BRANCH_AND_WORKTREE_GUIDE.md`, `PR_REVIEW_POLICY.md`,
  `RISK_MODEL.md`, `OPERATION_ROUTING.md`,
  `SCAFFOLD_FORK_CHECKLIST.md`).
- `## Known Stale Or Superseded Files` lists `None in this bootstrap
  package at initialization.`
- `## Next Recommended Action` lists `Run the Start requirement breakdown
  command or follow NEW_PROJECT_INITIALIZATION.md to begin downstream
  intake.`
- `## Latest Validation` lists a single row recording
  `bash SCRIPTS/validate-bootstrap.sh` passed on the extraction date with
  the extracted scaffold.

### `AI_HANDOFF.md`

- Metadata block matches the framework artifact rules.
- `version: v1.0` (initial downstream version).
- `## Current Date` lists the extraction date.
- `## Active Agent` lists `none yet`.
- `## Current Role` lists `none yet`.
- `## Current Branch` matches the actual extracted branch (typically
  `main` on the downstream repository).
- `## Current Worktree` lists `none yet`.
- `## Last Completed Task` lists `Scaffold extracted from ProjectGenesis
  using SCAFFOLD_FORK_CHECKLIST.md.`
- `## Current In-Progress Task` lists `Awaiting product intake.`
- `## Pre-Change Classification` and `## Final Evidence Envelope` blocks
  are present but contain only neutral placeholder rows
  (`Operation profile: review-only`, target files `none`, etc.) so the
  validator's classification block consumer has at least one block to
  inspect.
- `## Files Changed`, `## Tests Run`, `## Tests Not Run`, `## Known Risks`,
  `## Dirty Worktree Status`, `## Next Recommended Action`,
  `## What The Next AI Must Read First`, and `## Implementation Status`
  sections exist and contain neutral one-line entries appropriate for a
  fresh scaffold.

### `TRACEABILITY_MATRIX.md`

- Metadata block matches the framework artifact rules.
- `version: v1.0`.
- Bootstrap baseline requirements REQ-BOOT-001 through REQ-BOOT-013 are
  kept; they describe the framework, not the ProjectGenesis instance, and
  they map to `BOOT-001` (generic scaffold-bringup) rather than to any
  removed ProjectGenesis spec.
- `## Proposed Bootstrap Improvements Under Review` is reset to an empty
  table with the header row only.
- `## Adaptive Governance Routing Requirement Mapping` is reset to an
  empty table with the header row only, because every row in that
  section cites `SPEC-BOOT-003` and BOOT-018 through BOOT-024 — all of
  which are removed by the spec and backlog reset above. The live
  framework behavior they described continues to ship through
  `OPERATION_ROUTING.md`, `GOVERNANCE.md`, `BRANCH_AND_WORKTREE_GUIDE.md`,
  `PR_REVIEW_POLICY.md`, `PR_MERGE_POLICY.md`, `RISK_MODEL.md`,
  `CI_CD_GUIDE.md`, and `HOOKS_AND_GUARDRAILS.md`, which remain framework
  files.
- `## Scaffold Improvement Requirement Mapping` is reset to an empty
  table with the header row only, because every row in that section
  cites `SPEC-BOOT-002` and BOOT-009 through BOOT-015 — all of which are
  removed by the spec and backlog reset above. The live framework
  behavior they described continues to ship through `BOOTSTRAP_USAGE.md`,
  `00_intake/`, `01_context/`, `02_requirements/`, `CONTEXT_PACKS/`,
  `COMMANDS/`, `SCRIPTS/validate-bootstrap.sh`,
  `SCRIPTS/validate-bootstrap-red-checks.sh`, the templates set, and
  `NEW_PROJECT_INITIALIZATION.md`, which remain framework files.
- Downstream projects rebuild their own product-specific requirement
  mapping sections as their own specs and backlog items are created.

### `BACKLOG.md`

- Metadata block matches the framework artifact rules.
- `version: v1.0`.
- `## Current Backlog` keeps `BOOT-001` through `BOOT-008` only (the
  generic scaffold-bringup items). All `BOOT-009` and higher items are
  ProjectGenesis-specific and must be removed.
- The matching `BACKLOG/BOOT-*.md` per-item files for every removed row
  must also be deleted from disk (see the
  `## ProjectGenesis Instance Or History Files To Reset Or Remove`
  section above for the general rule covering any per-item files present
  at extraction time).
- `## External Ticket Workflow` is kept unchanged.

### `SPECS/SPEC_INDEX.md`

- Metadata block matches the framework artifact rules.
- `version: v1.0`.
- `## Specs` is reset to an empty table with the header row only.
- `## Rules` is kept unchanged.

### `REVIEWS/REVIEW_INDEX.md`

- Metadata block matches the framework artifact rules.
- `version: v1.0`.
- `## Reviews` is reset to an empty table with the header row only.
- `## Review Packages` is reset to an empty table with the header row
  only.
- `## Rules` is kept unchanged.

### `WORKLOG/WORKLOG_INDEX.md`

- Metadata block matches the framework artifact rules.
- `version: v1.0`.
- The session table is reset to an empty table with the header row only.
- The introductory paragraph is kept unchanged.

### `TEST_RESULTS.md`

- Metadata block matches the framework artifact rules.
- `version: v1.0`.
- The validation history table is reset to a single row recording
  `bash SCRIPTS/validate-bootstrap.sh` passed on the extraction date with
  the extracted scaffold.

### `ARTIFACT_REGISTRY.md`

- Metadata block matches the framework artifact rules.
- `version: v1.0`.
- `## Current Authoritative Artifacts` includes every framework file kept
  in the `## Framework Files To Keep` section above, with status,
  version, and authoritative metadata aligned to the kept files.
- `## Active Shared State Artifacts` includes the reset shared-state
  artifacts only, all at `version: v1.0`.
- `## Template And Directory Artifacts` lists templates, the new
  `ART-SCAFFOLD-FORK-CHECKLIST` row, intake/context/requirements
  directories, context packs, command files, hooks, CI workflow, and
  GitHub config. Every entry uses `version: v1.0` unless the underlying
  framework file shipped a different version.
- `## Launch And Adoption Artifacts` is removed unless the downstream
  team chooses to keep the example set; in that case the section remains
  but each row records the downstream owner and `version: v1.0`.
- `## Lifecycle Rules` is kept unchanged.

### Other reset files

- `OPEN_QUESTIONS.md` — keep only the framework-level open question
  about external ticket integrations being optional. Remove any other
  question.
- `BACKLOG/BACKLOG_INDEX.md` — empty items table with header row only;
  `## Rules` kept.
- `ADR/ADR_INDEX.md` — empty index table with header row only.
- `IMPLEMENTATION_PLAN.md` — keep the generic plan steps, remove the
  `## Phase 1 Bootstrap Follow-Up Plan` section and any
  ProjectGenesis-specific row.

## Manual Extraction Validation

After applying the categories and clean-state expectations, the downstream
team should run the following validation steps before committing the
extracted scaffold:

1. `git status --short --branch` — confirms expected files only and a
   clean worktree apart from intentional additions.
2. `bash SCRIPTS/validate-bootstrap.sh` — must exit 0 against the
   extracted scaffold. The validator checks required files, required
   directories, metadata, AI_HANDOFF sections, placeholder text,
   approved-spec source IDs, backlog spec linkage, branch parity, command
   sections, context pack sections, source registry rows, assumption
   register rows, operation routing structure, classification routing
   rules, and registry coverage.
3. `bash SCRIPTS/validate-bootstrap-red-checks.sh` — must exit 0. Red
   checks build temporary fixtures and confirm the validator fails for
   each banned condition. The extracted scaffold should not change red
   checks; if it does, treat that as a stop condition under
   `## Stop Conditions For Extraction Changes`.
4. `bash -n SCRIPTS/validate-bootstrap.sh && bash -n
   SCRIPTS/validate-bootstrap-red-checks.sh` — shell syntax sanity.
5. `git diff --check` — no whitespace issues.
6. `.githooks/pre-commit` — must pass on a representative staged change
   in the extracted scaffold.
7. Spot-check `ARTIFACT_REGISTRY.md` to confirm every file under the
   extracted scaffold is registered (this checklist itself is
   maintainer-only and must not appear in the extracted registry).
8. Spot-check `CONTEXT_INDEX.md` to confirm it still references
   `ARTIFACT_REGISTRY.md`, `TRACEABILITY_MATRIX.md`,
   `SPECS/SPEC_INDEX.md`, `memory/ai/SHARED_AGENT_RULES.md`,
   `memory/ai/ROLE_*.md`, and `OPERATION_ROUTING.md`.
9. If GitHub branch protection is configured on the downstream
   repository, confirm the `validate` workflow exists and is required on
   `main`.

If any step fails, fix the extracted scaffold before publishing. Do not
silently bypass the validator with `--no-verify`.

## Stop Conditions For Extraction Changes

`SCRIPTS/scaffold-extract.sh` (shipped as the BOOT-031 deliverable)
implements this policy. If a change to the extraction tool or to this
policy hits any of the conditions below, stop, record the blocker in
`STALE_ITEMS.md` or `OPEN_QUESTIONS.md`, and re-plan before continuing.

1. The policy needs new per-artifact metadata to flag framework versus
   instance-history versus example content. Do not invent silent flags;
   metadata schema changes require their own reviewed slice.
2. The reset/exclusion policy needs to change repository governance
   (`GOVERNANCE.md`, `OPERATION_ROUTING.md`, `BRANCH_AND_WORKTREE_GUIDE.md`,
   `PR_REVIEW_POLICY.md`, `PR_MERGE_POLICY.md`, `RISK_MODEL.md`,
   `memory/ai/SHARED_AGENT_RULES.md`, or `memory/ai/ROLE_*.md`).
3. The reset/exclusion policy needs to change validators, hooks, or CI
   (`SCRIPTS/validate-bootstrap.sh`,
   `SCRIPTS/validate-bootstrap-red-checks.sh`, `.githooks/*`, or
   `.github/workflows/bootstrap-validation.yml`) outside a reviewed
   validator slice.
4. The script needs to touch ADRs, command files, or context packs in a
   way this policy did not anticipate.
5. The script needs to mutate runtime product code in a downstream
   project; extraction is scaffold-only and must not edit a downstream
   project's product implementation.
6. The script needs network or external service access that is not part
   of the scaffold's existing surface (Git, file system, GitHub CLI, and
   user-approved tooling only).

When a stop condition is reached, surface the blocker through
`OPEN_QUESTIONS.md`, `STALE_ITEMS.md`, and `AI_HANDOFF.md` rather than
expanding scope.

## Related Records

- `MAINTAINER_ARCHIVE/BACKLOG/BOOT-030-scaffold-extract-checklist.md`
  (policy authored)
- `MAINTAINER_ARCHIVE/BACKLOG/BOOT-031-scaffold-extract-tool.md`
  (tool shipped)
- `TEMPLATE_MANIFEST.md` (authoritative path classification)
- `ARTIFACT_REGISTRY.md` `ART-SCAFFOLD-FORK-CHECKLIST` row
- `MAINTAINER_ARCHIVE/REVIEWS/PR_REVIEW_PACKAGE-2026-05-15-boot-030-scaffold-extract-checklist.md`
