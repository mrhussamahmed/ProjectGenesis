---
artifact_id: ART-TEMPLATE-MANIFEST
title: Template Manifest
type: scaffold-manifest
status: active
version: v2.0
created: 2026-05-16
updated: 2026-06-10
owner: ProjectGenesis Maintainers
source: Clean scaffold boundary first slice
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true
---

# Template Manifest

## Purpose

This manifest defines how ProjectGenesis is copied into a new project so the
new project starts from a clean operating-model scaffold and does not inherit
ProjectGenesis's own maintainer development history (BOOT tickets, PR review
records, worklog entries, validation envelopes, post-merge cleanup notes, or
branch references).

The manifest classifies every top-level repository path, defines nested
overrides where folders have mixed contents, inventories required-reading
files, maps every `starter-reset` target to a clean source under
`TEMPLATE_STARTERS/`, and describes a minimal scaffold-assembly procedure that
a maintainer can run by hand.

The recommended extraction path is `bash SCRIPTS/scaffold-extract.sh`
(dry-run by default; `--apply` to write). The script implements this
manifest's contract; the manual procedure below is the fallback.

## Copy Semantics Decision

ProjectGenesis supports two copy modes. Both are clean for the file paths
classified as `maintainer-archive`; one mode additionally resets the
`starter-reset` files.

1. **Raw-root direct copy (slice 2 and later).** A subset of ProjectGenesis
   maintainer-archive paths have been relocated into a single top-level
   `MAINTAINER_ARCHIVE/` directory in slice 2:

   - `MAINTAINER_ARCHIVE/BACKLOG/BOOT-029..035.md` (PG BOOT ticket files)
   - `MAINTAINER_ARCHIVE/REVIEWS/PR_REVIEW_PACKAGE-*.md` and
     `MAINTAINER_ARCHIVE/REVIEWS/REVIEW-*.md` (PG PR review records)
   - `MAINTAINER_ARCHIVE/SPECS/SPEC-BOOT-002/003/004.md` (PG specs)
   - `MAINTAINER_ARCHIVE/.github/ISSUE_TEMPLATE/` (PG-branded issue templates)
   - `MAINTAINER_ARCHIVE/docs/` (PG launch/demo/release notes)
   - `MAINTAINER_ARCHIVE/ARTIFACTS/` (formerly top-level ARTIFACTS/)
   - `MAINTAINER_ARCHIVE/snapshots/` (pre-slice-3 shared-state snapshots)

   The following PG-specific files were **deliberately NOT relocated in
   slice 2** because the strict red-check harness
   (`SCRIPTS/validate-bootstrap-red-checks.sh`) and the
   `SCRIPTS/scaffold-extract.sh` tool depend on these files being at
   their active root paths (the tool's clean-reset templates and rsync
   mirror produce a scaffold with them at root):

   - `BOOTSTRAP_AUDIT.md`
   - `GITHUB_REPOSITORY_SETUP.md`
   - `GOVERNANCE_PERFORMANCE.md`
   - `PARALLEL_EXECUTION_PLAN.md`
   - `SCAFFOLD_FORK_CHECKLIST.md`
   - `STALE_ITEMS.md`
   - `SCRIPTS/scaffold-extract.sh`
   - `SCRIPTS/run-seeded-defect-bench.sh`
   - `SCRIPTS/prune-history.sh`
   - `TESTS/ACCEPTANCE_CRITERIA_MAP.md`
   - `TESTS/ADVERSARIAL_SEED_BENCHMARK.md`

   A future slice can move these ten files once the red-check harness
   and scaffold-extract reset templates are updated to match the new
   layout.

   A maintainer may therefore run `cp -R projectgenesis newproj` and get
   a scaffold whose **relocated maintainer-archive paths** are now under
   `MAINTAINER_ARCHIVE/` and ignorable. The consumer's recommended
   cleanup step is `rm -rf newproj/MAINTAINER_ARCHIVE/`. The ten
   not-yet-relocated PG-specific files remain at active root and a
   consumer who wants a fully clean scaffold should additionally delete
   them by hand (or use the manifest-mediated copy mode below).

   Caveat: the `starter-reset` files at the active scaffold root
   (`AI_HANDOFF.md`, `CURRENT_STATE.md`, `BACKLOG.md`,
   `BACKLOG/BACKLOG_INDEX.md`, `REVIEWS/REVIEW_INDEX.md`,
   `WORKLOG/WORKLOG_INDEX.md`, `TRACEABILITY_MATRIX.md`, `TEST_RESULTS.md`,
   `ARTIFACT_REGISTRY.md`, `IMPLEMENTATION_PLAN.md`, `SPECS/SPEC_INDEX.md`,
   `README.md`) carry the live ProjectGenesis instance state under
   `cp -R` (slice 3 trimmed them and archived the accumulated history to
   `MAINTAINER_ARCHIVE/snapshots/`, but the root copies remain
   instance-specific). Consumers using raw `cp -R` should additionally
   apply the `TEMPLATE_STARTERS/` mapping below;
   `SCRIPTS/scaffold-extract.sh` does this automatically.

2. **Manifest-mediated scaffold copy (slice 1, still supported).** Follow
   the classification table, nested overrides, starter-reset mappings, and
   scaffold procedure below. This produces a scaffold that excludes
   `MAINTAINER_ARCHIVE/` and replaces `starter-reset` targets with files
   from `TEMPLATE_STARTERS/`, giving a fully clean scaffold without a
   post-copy cleanup step.

History note: prior versions of this manifest stated raw root copy was not
clean at all. Slice 2 relocated ProjectGenesis maintainer history into
`MAINTAINER_ARCHIVE/` and updated `SCRIPTS/validate-bootstrap.sh` and
`ARTIFACT_REGISTRY.md` to point at the new paths, which makes raw root copy
clean of maintainer-archive content for the first time. Active state
required-reading files are still slice-3 work.

## Classification Legend

| Class | Meaning |
|---|---|
| `copy` | Reusable scaffold asset copied unchanged into the new project. |
| `copy-clean` | Required-reading or operational scaffold asset verified clean enough to copy unchanged. May cite ProjectGenesis specs (`SPEC-BOOT-*`) only in metadata fields (`source`, `linked_specs`); these references are acknowledged stale lineage, not active history, and may be cleaned by the consumer if desired. |
| `starter-reset` | Copied into new projects from `TEMPLATE_STARTERS/` instead of from the live ProjectGenesis file. |
| `exclude` | Not copied into new projects. |
| `example` | Copied only as clearly marked example material under an `examples/` path or equivalent. |
| `maintainer-archive` | ProjectGenesis maintainer history. Not part of the clean scaffold. Not required reading for downstream projects. |

Nested overrides take precedence over parent classifications when assembling a
scaffold. For example, a folder may be `maintainer-archive` by default while a
specific index file inside it is `starter-reset` and is created from
`TEMPLATE_STARTERS/`.

## Maintainer-History Exclusion Rule

Maintainer-history paths are not copied into the active operational state of a
new project. If a maintainer-history path is kept for audit reasons inside the
ProjectGenesis repository, it must remain outside required-reading paths and
must not be classified as `copy` or `copy-clean`.

After slice 2, the following ProjectGenesis maintainer-archive files
live under the top-level `MAINTAINER_ARCHIVE/` directory:

- `MAINTAINER_ARCHIVE/BACKLOG/BOOT-029..035.md` (PG BOOT ticket files)
- `MAINTAINER_ARCHIVE/REVIEWS/PR_REVIEW_PACKAGE-*.md` and
  `MAINTAINER_ARCHIVE/REVIEWS/REVIEW-*.md` (PG PR review records)
- `MAINTAINER_ARCHIVE/SPECS/SPEC-BOOT-002/003/004.md` (PG specs)
- `MAINTAINER_ARCHIVE/.github/ISSUE_TEMPLATE/` (PG-branded issue templates)
- `MAINTAINER_ARCHIVE/docs/` (PG-launch/demo/release content)
- `MAINTAINER_ARCHIVE/ARTIFACTS/` (formerly top-level ARTIFACTS/)
- `MAINTAINER_ARCHIVE/snapshots/` (pre-slice-3 shared-state snapshots)

The original top-level paths (`BACKLOG/`, `REVIEWS/`, `SPECS/`, `.github/`)
remain in the repository root and now contain only reusable scaffold
material (indexes, templates).

**NOT relocated in slice 2** (kept at active root because the strict
red-check harness or `SCRIPTS/scaffold-extract.sh` reset templates and
rsync mirror depend on them at their active paths):

- `BOOTSTRAP_AUDIT.md`
- `GITHUB_REPOSITORY_SETUP.md`
- `GOVERNANCE_PERFORMANCE.md`
- `PARALLEL_EXECUTION_PLAN.md`
- `SCAFFOLD_FORK_CHECKLIST.md`
- `STALE_ITEMS.md`
- `SCRIPTS/scaffold-extract.sh`
- `SCRIPTS/run-seeded-defect-bench.sh`
- `SCRIPTS/prune-history.sh`
- `TESTS/ACCEPTANCE_CRITERIA_MAP.md`
- `TESTS/ADVERSARIAL_SEED_BENCHMARK.md`

These ten files remain classified as `maintainer-archive` semantically;
their relocation is deferred to a future slice that also updates the
red-check harness, the `scaffold-extract.sh` reset templates, and the
rsync exclude list to match the new layout.

## Documented Allowlist

The forbidden-history search will produce intentional hits in the assembled
scaffold. The following are intentional, reusable mentions and do not count
as ProjectGenesis history leakage:

1. `TEMPLATE_MANIFEST.md` itself describes the scaffold-boundary mechanism and
   therefore quotes the forbidden terms (`BOOT-`, `PR #`, `review-fix`,
   `post-merge cleanup`, `validation envelope`, `Codex re-review`,
   `Claude re-review`, `claude/`, `codex/`, `ProjectGenesis`) as the strings
   to be detected.
2. The reuse-boundary slice replaced the inline `README.md` starter with a
   project-neutral version: "This repository was initialized from an AI
   project bootstrap scaffold." The starter no longer names the upstream
   scaffold and contains no bare upstream-brand text. The earlier
   upstream-branded starter is retired.
3. Reusable bootstrap scripts under `SCRIPTS/` retain four intentional
   categories of hits:
   (a) inline comments in `SCRIPTS/validate-bootstrap.sh` and
       `SCRIPTS/validate-bootstrap-red-checks.sh` reference the
       ProjectGenesis ticket numbers (e.g. `BOOT-031`, `BOOT-033`,
       `BOOT-034`), pull-request numbers (e.g. `PR #10`), and
       review-loop version markers (e.g. `v1.0 through v1.5 review loop`)
       that motivated specific validator logic. Concrete example:
       `SCRIPTS/validate-bootstrap.sh` line 473 contains
       `# happened. The PR #10 / BOOT-033 v1.0 through v1.5 review loop is the`
       which is a motivating-context comment;
   (b) heredoc fixture content embedded in
       `SCRIPTS/validate-bootstrap-red-checks.sh` writes test data into
       throwaway temp directories. That fixture content contains concrete
       PG-shaped strings such as `BOOT-035`, `PR #12`, GitHub Actions run
       IDs, commit short hashes (for example `f116f85`), and
       `post-merge cleanup` because the validator's job is precisely to
       detect those patterns. The fixture strings are test data, not
       runtime state of a copied project, and are never written to a
       consumer's repository unless the consumer chooses to run the
       validator's red-check harness in their own checkout;
   (c) test-fixture branch names of the form `claude/red-*` and
       `codex/red-*` are constants used inside the harness;
   (d) `SCRIPTS/metric-evidence-coverage.sh` and
       `SCRIPTS/metric-traceability-completeness.sh` use the bootstrap-
       default backlog/requirement prefixes `BOOT-*` and `REQ-BOOT-*` as
       file-glob and pattern defaults (e.g. `find BACKLOG -name 'BOOT-*.md'`
       and `/^\| REQ-BOOT-/`). Consumers using a different ticket prefix
       update these globs/patterns on first use. The script logic is
       project-neutral; the prefix is a default.
   The validator and metric logic itself is project-neutral.
4. `copy-clean` files may legitimately retain ProjectGenesis spec and
   ticket lineage in their YAML frontmatter `source` and `linked_specs`
   fields. Examples seen in the assembled scaffold include
   `source: User request, reference repository audit, and SPEC-BOOT-003`,
   `linked_specs: [SPEC-BOOT-002, SPEC-BOOT-003]`, and
   `source: SPEC-BOOT-003 and user authorization for BOOT-019 through
   BOOT-024`. These references record which upstream ProjectGenesis spec
   or sub-ticket range introduced the reusable document. They are not
   active ProjectGenesis history in the new project and a consumer may
   clear them on first edit. Files affected include but are not limited
   to: `AI_PROJECT_BOOTSTRAP.md`, `CONTEXT_INDEX.md`, `GOVERNANCE.md`,
   `BRANCH_AND_WORKTREE_GUIDE.md`, `OPERATION_ROUTING.md`,
   `PR_REVIEW_POLICY.md`, `PR_MERGE_POLICY.md`, `BOOTSTRAP_USAGE.md`,
   `CI_CD_GUIDE.md`, `RISK_MODEL.md`, `TEST_STRATEGY.md`,
   `HOOKS_AND_GUARDRAILS.md`,
   `NEW_PROJECT_INITIALIZATION.md`, `memory/ai/SHARED_AGENT_RULES.md`,
   `memory/ai/ROLE_*.md`, `CONTEXT_PACKS/*.md`, the `00_intake/`,
   `01_context/`, `02_requirements/` index files, `ADR/ADR_INDEX.md`,
   and the templates under `*/templates/`.
5. `OPERATION_ROUTING.md`:
   - Line 19 names the file as the adaptive governance control plane "for
     ProjectGenesis". This is the operating-model brand referring to the
     upstream scaffold.
   - Line 197 body references "the rule in `SPEC-BOOT-003`" as the spec
     that defines the not-impacted criterion. This is a lineage reference
     to the upstream spec that defined the rule; the rule statement
     itself is body-local.
   - Line 283 references `BOOT-024` performance measurement as motivating
     context for a routing rule. The body content is otherwise project-
     neutral. Consumers may sanitize any of these lines if desired.
6. `CI_CD_GUIDE.md` line 26 mentions running the red-check script "for
   ProjectGenesis governance PRs or other validator-rule changes". This is
   the operating-model brand naming the upstream scaffold. The instruction
   itself is reusable.
7. Generic English uses of the words `worklog`, `review package`, and
   `pull request` in reusable operating-model docs are vocabulary, not
   project-specific history. These appear in `AI_PROJECT_BOOTSTRAP.md`,
   `AI_REVIEW_PROMPTS.md`, `BOOTSTRAP_USAGE.md`, `CONTEXT_INDEX.md`,
   `CONTEXT_PACKS/`, `CONTRIBUTING.md`, `PR_REVIEW_POLICY.md`,
   `RISK_MODEL.md`, `OPERATION_ROUTING.md`, `ARCHITECTURE.md`,
   `TEST_STRATEGY.md`, and `memory/ai/ROLE_*.md`.
8. `TEMPLATE_STARTERS/WORKLOG_INDEX.md` and `WORKLOG/WORKLOG_INDEX.md` use
   the word `worklog` as the index's own subject.
9. `BOOT-001` is the bootstrap baseline ticket convention used throughout
   reusable operating-model documentation as an example ticket reference.
   In particular, `PR_MERGE_POLICY.md` line 46 says
   "the work links to `BOOT-001` in `BACKLOG.md`" as an example of how
   bootstrap-baseline work threads through the operating model, and
   `.githooks/commit-msg` line 18 uses `BOOT-001 validate bootstrap
   scaffold` as the example commit-message body. Consumers may substitute
   their own baseline ticket ID. The commit-msg hook's regex itself
   (`(SPEC-[0-9]+|BACKLOG-[0-9]+|ADR-[0-9]+|BOOT-[0-9]+|...)`) accepts
   `BOOT-NNN` as one of several ticket prefixes; it is a generic
   ticket-prefix matcher, not ProjectGenesis history.
10. `artifact_id: ART-BOOT-001` (in `AI_PROJECT_BOOTSTRAP.md`) and
    `artifact_id: ART-BOOT-002` (in `BOOTSTRAP_USAGE.md`) are stable
    artifact ID constants that name the bootstrap operating-model
    artifacts themselves. They are convention-level identifiers, not
    project-specific history, and remain stable across downstream
    projects.

Hits outside this allowlist are real leaks and must be reclassified.

## Top-Level Path Classification

| Path | Class | Notes |
|------|-------|-------|
| `.git` | `exclude` | Git internal state. Never copied; new project initializes its own. |
| `.githooks/` | `copy` | Reusable commit-msg and pre-commit hooks. Project-neutral. |
| `.github/` | `copy` | After slice 2 contains `workflows/` and `CODEOWNERS`; the reuse-boundary slice excludes `CODEOWNERS` from the extracted scaffold because it carries upstream owner attribution. PG-branded `ISSUE_TEMPLATE/` moved to `MAINTAINER_ARCHIVE/.github/ISSUE_TEMPLATE/`. See nested overrides. |
| `.gitignore` | `copy` | Reusable ignore rules. |
| `00_intake/` | `copy` | Intake scaffolding; instance files are empty templates. See nested overrides. |
| `01_context/` | `copy` | Product context scaffolding; instance files are empty templates. See nested overrides. |
| `02_requirements/` | `copy` | Requirements scaffolding; instance files are empty templates. See nested overrides. |
| `ADR/` | `copy` | ADR folder. See nested overrides for `ADR_INDEX.md`. |
| `AGENTS.md` | `copy-clean` | Generic agent instruction file. No ProjectGenesis history in body. |
| `AI_HANDOFF.md` | `starter-reset` | Heavy ProjectGenesis handoff history. Replace from `TEMPLATE_STARTERS/AI_HANDOFF.md`. |
| `AI_PROJECT_BOOTSTRAP.md` | `copy-clean` | Reusable bootstrap operating-model description. Metadata references PG specs only. |
| `AI_REVIEW_PROMPTS.md` | `copy-clean` | Reusable review-prompt library. |
| `ARCHITECTURE.md` | `copy-clean` | Project-neutral architecture stub. Consumer is expected to overwrite for their product. |
| `MAINTAINER_ARCHIVE/` | `maintainer-archive` | Consolidated ProjectGenesis maintainer history folder (added in slice 2). Contains BACKLOG/BOOT-029..035, REVIEWS/PR_REVIEW_PACKAGE-*, REVIEWS/REVIEW-*, SPECS/SPEC-BOOT-*, .github/ISSUE_TEMPLATE/, docs/ (PG launch/demo/release notes), ARTIFACTS/, and snapshots/. The deferred-relocation files (see "NOT relocated in slice 2" above) remain at top level and carry their own `maintainer-archive` rows below. Required-reading is unaffected. A consumer may `rm -rf MAINTAINER_ARCHIVE/` after `cp -R` if they do not want to keep the upstream audit copy. |
| `ARTIFACT_REGISTRY.md` | `starter-reset` | Heavy ProjectGenesis registry history. Treat as starter-reset; see Mapping table. |
| `BACKLOG.md` | `starter-reset` | Top-level backlog summary contains ProjectGenesis BOOT history. Replace from `TEMPLATE_STARTERS/BACKLOG.md`. |
| `BACKLOG/` | `copy` | Ships `BACKLOG_INDEX.md` and `templates/` to new projects. Maintainer `BOOT-*.md` ticket files remain tracked here in the source repo but are excluded from extraction (`BACKLOG/BOOT-*`); older BOOT history lives in `MAINTAINER_ARCHIVE/BACKLOG/`. See nested overrides for the starter-reset `BACKLOG_INDEX.md`. |
| `BOOTSTRAP_AUDIT.md` | `maintainer-archive` | PG audit history. Remains at top level (red-check harness depends on this path); relocation deferred. Excluded from extraction. |
| `BOOTSTRAP_USAGE.md` | `copy-clean` | Reusable usage guide. Metadata references PG specs only. |
| `BRANCH_AND_WORKTREE_GUIDE.md` | `copy-clean` | Reusable branch/worktree guidance. Metadata references PG specs only. |
| `CI_CD_GUIDE.md` | `copy-clean` | Reusable CI/CD guidance. |
| `CLAUDE.md` | `copy-clean` | Short Claude entry-point pointing to canonical docs. |
| `COMMANDS/` | `copy` | Reusable command templates. |
| `CONTEXT_INDEX.md` | `copy-clean` | Reusable context index. Metadata references PG specs only. |
| `CONTEXT_PACKS/` | `copy` | Reusable context packs. |
| `CONTRIBUTING.md` | `copy-clean` | Reusable contributing guide. |
| `CURRENT_STATE.md` | `starter-reset` | Heavy ProjectGenesis state history. Replace from `TEMPLATE_STARTERS/CURRENT_STATE.md`. |
| `DECISIONS.md` | `copy-clean` | Reusable decision-governance guidance. |
| `GITHUB_REPOSITORY_SETUP.md` | `maintainer-archive` | PG repository-setup record. Remains at top level; relocation deferred. Excluded from extraction. |
| `GOVERNANCE.md` | `copy-clean` | Reusable governance doc. Metadata references PG specs only. |
| `GOVERNANCE_PERFORMANCE.md` | `maintainer-archive` | PG governance-measurement record. Remains at top level; relocation deferred. Excluded from extraction. |
| `HOOKS_AND_GUARDRAILS.md` | `copy-clean` | Reusable hooks/guardrails guidance. |
| `IMPLEMENTATION_PLAN.md` | `starter-reset` | Heavy ProjectGenesis phase-1 history. See Mapping table. |
| `LICENSE` | `copy` | License file. |
| `NEW_PROJECT_INITIALIZATION.md` | `copy-clean` | Reusable new-project initialization guide. |
| `OBSERVABILITY.md` | `copy-clean` | Reusable observability guidance. |
| `OPEN_QUESTIONS.md` | `copy-clean` | Reusable open-questions register with seeded generic OQ rows. Consumer may overwrite. |
| `OPERATION_ROUTING.md` | `copy-clean` | Reusable adaptive-governance routing. Body says it is the routing control plane for "ProjectGenesis"; the word here refers to the operating model itself (the scaffold product). Consumer may keep or rename to their project. |
| `PARALLEL_EXECUTION_PLAN.md` | `maintainer-archive` | PG parallel-stream plan. Remains at top level; relocation deferred. Excluded from extraction. |
| `PR_MERGE_POLICY.md` | `copy-clean` | Reusable merge policy. Metadata references PG specs only. |
| `PR_REVIEW_POLICY.md` | `copy-clean` | Reusable review policy. Metadata references PG specs only. |
| `README.md` | `starter-reset` | Upstream-branded README in the source repo. New projects must not inherit upstream branding. The reuse-boundary slice generates a project-neutral starter inline (see Step 4). |
| `RELEASE_NOTES.md` | `exclude` | Upstream release history. Carries upstream release URLs and maintainer-only context. Excluded from the extracted scaffold so downstream consumers do not ship upstream release notes; consumers add their own as needed. |
| `RELEASE_READINESS.md` | `copy-clean` | Reusable release readiness checklist. |
| `REVIEWS/` | `copy` | Ships `REVIEW_INDEX.md` and `templates/` to new projects. Maintainer `PR_REVIEW_PACKAGE-*.md` and `REVIEW-*.md` records remain tracked here in the source repo but are excluded from extraction; older records live in `MAINTAINER_ARCHIVE/REVIEWS/`. See nested overrides for the starter-reset `REVIEW_INDEX.md`. |
| `RISK_MODEL.md` | `copy-clean` | Reusable risk model guidance. |
| `SCAFFOLD_FORK_CHECKLIST.md` | `maintainer-archive` | Manual fallback and policy reference for `SCRIPTS/scaffold-extract.sh`. Remains at top level; relocation deferred. Excluded from extraction. |
| `SCRIPTS/` | `copy` | Reusable scripts. |
| `SECURITY_AND_PRIVACY.md` | `copy-clean` | Reusable security/privacy guidance. |
| `SPECS/` | `copy` | After slice 2 contains only `SPEC_INDEX.md` and `templates/`. All `SPEC-BOOT-*.md` files moved to `MAINTAINER_ARCHIVE/SPECS/`. See nested overrides for the starter-reset `SPEC_INDEX.md`. |
| `STALE_ITEMS.md` | `maintainer-archive` | PG staleness register. Remains at top level; relocation deferred. Excluded from extraction; reusable docs describe it as an optional pattern a new project can recreate. |
| `TEMPLATE_MANIFEST.md` | `copy-clean` | This manifest. Copied unchanged. |
| `TEMPLATE_STARTERS/` | `copy` | Starter source folder. Copied unchanged so consumers can re-run starter resets later. |
| `TESTS/` | `copy` | Reusable test framework scaffolding. |
| `TEST_RESULTS.md` | `starter-reset` | Heavy ProjectGenesis test history. Replace from `TEMPLATE_STARTERS/TEST_RESULTS.md`. |
| `TEST_STRATEGY.md` | `copy-clean` | Reusable test strategy. |
| `TRACEABILITY_MATRIX.md` | `starter-reset` | Heavy ProjectGenesis traceability history. Replace from `TEMPLATE_STARTERS/TRACEABILITY_MATRIX.md`. |
| `WORKLOG/` | `copy` | After slice 2 contains only `WORKLOG_INDEX.md` (starter-reset). No worklog history files exist at root. |
| `docs/` | `maintainer-archive` | PG launch/demo/release notes moved to `MAINTAINER_ARCHIVE/docs/` in slice 2. The current top-level `docs/` contains only maintainer planning history (`docs/superpowers/plans/`); skip on extraction. |
| `examples/` | `example` | Clearly marked example projects under `examples/simple-saas-demo/`. Copy only as example reference, not as active state. |
| `memory/` | `copy` | Memory folder. See nested overrides. |

### Notes On `README.md`

In this slice, the scaffold procedure replaces the top-level `README.md` with
a minimal placeholder that names the new project rather than ProjectGenesis.
A starter is provided inline in the scaffold procedure (see "Step 4" below)
to keep the slice scope tight; future work may move the starter into
`TEMPLATE_STARTERS/README.md`. New projects must not ship the ProjectGenesis
README as their own README.

## Nested Overrides

When a parent path's class would copy or exclude in bulk, the nested overrides
below take precedence and are applied during scaffold assembly.

### `BACKLOG/` (parent: `copy`)

| Nested Path | Class | Notes |
|-------------|-------|-------|
| `BACKLOG/BACKLOG_INDEX.md` | `starter-reset` | Replace from `TEMPLATE_STARTERS/BACKLOG_INDEX.md`. |
| `BACKLOG/templates/` | `copy` | Reusable backlog-item templates. |
| `BACKLOG/BOOT-*.md` | `maintainer-archive` | ProjectGenesis BOOT ticket files. Excluded from new-project scaffold. |

### `REVIEWS/` (parent: `copy`)

| Nested Path | Class | Notes |
|-------------|-------|-------|
| `REVIEWS/REVIEW_INDEX.md` | `starter-reset` | Replace from `TEMPLATE_STARTERS/REVIEW_INDEX.md`. |
| `REVIEWS/templates/` | `copy` | Reusable adversarial and PR review templates. |
| `REVIEWS/PR_REVIEW_PACKAGE-*.md` | `maintainer-archive` | ProjectGenesis PR review packages. Excluded from new-project scaffold. |
| `REVIEWS/REVIEW-*.md` | `maintainer-archive` | ProjectGenesis review records. Excluded from new-project scaffold. |

### `WORKLOG/` (parent: `copy`)

| Nested Path | Class | Notes |
|-------------|-------|-------|
| `WORKLOG/WORKLOG_INDEX.md` | `starter-reset` | Replace from `TEMPLATE_STARTERS/WORKLOG_INDEX.md`. |

### `SPECS/` (parent: `copy`)

| Nested Path | Class | Notes |
|-------------|-------|-------|
| `SPECS/SPEC_INDEX.md` | `starter-reset` | Recreate as clean index using `TEMPLATE_STARTERS/` content (see Step 4 below). |
| `SPECS/templates/` | `copy` | Reusable spec templates, including `SPECS/templates/TECH_DESIGN_TEMPLATE.md` (added 2026-06-10). |
| `SPECS/SPEC-BOOT-*.md` | `maintainer-archive` | ProjectGenesis-specific specs. Excluded from new-project scaffold. |

### `ADR/` (parent: `copy`)

| Nested Path | Class | Notes |
|-------------|-------|-------|
| `ADR/ADR_INDEX.md` | `copy-clean` | Generic ADR governance guide. No ProjectGenesis history in body. |
| `ADR/templates/` | `copy` | Reusable ADR templates. |

### `MAINTAINER_ARCHIVE/ARTIFACTS/` (parent: `maintainer-archive`)

| Nested Path | Class | Notes |
|-------------|-------|-------|
| `MAINTAINER_ARCHIVE/ARTIFACTS/ARCHIVE/` | `maintainer-archive` | Empty archive folder reserved for ProjectGenesis-side use. Not copied; `SCRIPTS/scaffold-extract.sh` recreates an empty `ARTIFACTS/ARCHIVE/` structure in the target. |

### `memory/` (parent: `copy`)

| Nested Path | Class | Notes |
|-------------|-------|-------|
| `memory/ai/SHARED_AGENT_RULES.md` | `copy-clean` | Reusable shared role guidance. Metadata references PG spec only. |
| `memory/ai/ROLE_*.md` | `copy-clean` | Reusable role files. Project-neutral. |

### `00_intake/`, `01_context/`, `02_requirements/` (parent: `copy`)

These folders already contain placeholder content ("No downstream X yet").
They are copy-safe. Their metadata cites `SPEC-BOOT-002` as the spec that
introduced them; consumers may relabel.

| Nested Path | Class | Notes |
|-------------|-------|-------|
| `00_intake/raw/` | `copy` | Empty intake raw directory. |
| `00_intake/summaries/` | `copy` | Intake summaries directory. |
| `00_intake/summaries/SUMMARY_TEMPLATE.md` | `copy` | Reusable intake summary template (added 2026-06-10). |
| `00_intake/research/` | `copy` | Research notes directory (added 2026-06-10). |
| `00_intake/research/RESEARCH_NOTE_TEMPLATE.md` | `copy` | Reusable research note template (added 2026-06-10). |

### `TESTS/` (parent: `copy`)

| Nested Path | Class | Notes |
|-------------|-------|-------|
| `TESTS/MANUAL_TEST_CHECKLIST.md` | `copy-clean` | Clean reusable manual-test scaffold. |
| `TESTS/ACCEPTANCE_CRITERIA_MAP.md` | `maintainer-archive` | Heavy ProjectGenesis SPEC-BOOT-002/003 + BOOT-019..024 history. |
| `TESTS/ADVERSARIAL_SEED_BENCHMARK.md` | `maintainer-archive` | ProjectGenesis BOOT-031/032/033 seeded-defect benchmark plan. |

### `SCRIPTS/` (parent: `copy`)

| Nested Path | Class | Notes |
|-------------|-------|-------|
| `SCRIPTS/start-claude.sh` | `copy` | Reusable role launcher. |
| `SCRIPTS/operation-profile.sh` | `copy` | Reusable slice-4 operation-profile extractor for adaptive fast-path validation. |
| `SCRIPTS/strict-gate-paths.sh` | `copy` | Shared strict-gate path list for hooks and CI (added 2026-06-10). |
| `SCRIPTS/session.sh` | `copy` | Local session helper for `.ai/SESSION.md` (added 2026-06-10). |
| `SCRIPTS/doctor.sh` | `copy` | One-command orientation/status report (added 2026-06-10). |
| `SCRIPTS/metric-acceptance-coverage.sh` | `copy` | Reusable metric script. |
| `SCRIPTS/metric-evidence-coverage.sh` | `copy` | Reusable metric script. |
| `SCRIPTS/metric-traceability-completeness.sh` | `copy` | Reusable metric script. |
| `SCRIPTS/validate-bootstrap.sh` | `copy` | Reusable validator. Inline comments and fixture strings reference PG ticket numbers; these are motivating-context comments only (see Documented Allowlist). |
| `SCRIPTS/validate-bootstrap-red-checks.sh` | `copy` | Reusable red-check harness. Inline fixture content uses `claude/` and `codex/` strings as test data (see Documented Allowlist). |
| `SCRIPTS/run-seeded-defect-bench.sh` | `maintainer-archive` | BOOT-032 benchmark runner; PG-specific. |
| `SCRIPTS/prune-history.sh` | `maintainer-archive` | GEN-17 WORKLOG/REVIEWS rotation tool; targets `MAINTAINER_ARCHIVE/`, PG-specific. |
| `SCRIPTS/scaffold-extract.sh` | `maintainer-archive` | BOOT-031 deliverable embedding ProjectGenesis REQ-BOOT rows. |

### `COMMANDS/` (parent: `copy`)

| Nested Path | Class | Notes |
|-------------|-------|-------|
| `COMMANDS/validate-idea.md` | `copy` | Reusable command (added 2026-06-10). |
| `COMMANDS/start-architecture-design.md` | `copy` | Reusable command (added 2026-06-10). |
| `COMMANDS/implement-next-story.md` | `copy` | Reusable command (added 2026-06-10). |
| `COMMANDS/resume-work.md` | `copy` | Reusable command (added 2026-06-10). |
| `COMMANDS/export-backlog-to-linear.md` | `copy` | Reusable command (added 2026-06-10). |

### `TEMPLATE_STARTERS/` (parent: `copy`)

| Nested Path | Class | Notes |
|-------------|-------|-------|
| `TEMPLATE_STARTERS/SESSION.md` | `copy` | Starter for the local gitignored `.ai/SESSION.md` (added 2026-06-10). |
| `TEMPLATE_STARTERS/ACCEPTANCE_CRITERIA_MAP.md` | `copy` | Clean starter for a downstream `TESTS/ACCEPTANCE_CRITERIA_MAP.md` (added 2026-06-10). |

### `.github/` (parent: `copy`)

| Nested Path | Class | Notes |
|-------------|-------|-------|
| `.github/workflows/` | `copy` | Reusable CI workflows. |
| `.github/CODEOWNERS` | `exclude` | Carries upstream-specific owner attribution. Excluded from the extracted scaffold to prevent owner leakage; downstream projects add their own CODEOWNERS as needed. |
| `.github/ISSUE_TEMPLATE/` | (relocated) | Moved to `MAINTAINER_ARCHIVE/.github/ISSUE_TEMPLATE/` in slice 2. Templates referenced the upstream scaffold name in `about:` lines, `owner` metadata, and the upstream repository URL. New projects should provide their own issue templates. |

## Required-Reading Inventory

The "required-reading" set is the files a downstream project's first AI agent
is expected to read on startup, per `CLAUDE.md` and `AGENTS.md`. Each required
file must be `copy-clean`, `starter-reset`, or `exclude`.

| Required-Reading File | Class | Notes |
|-----------------------|-------|-------|
| `AGENTS.md` | `copy-clean` | Clean. |
| `CLAUDE.md` | `copy-clean` | Clean. |
| `AI_PROJECT_BOOTSTRAP.md` | `copy-clean` | Metadata cites PG spec only. |
| `CONTEXT_INDEX.md` | `copy-clean` | Metadata cites PG specs only. |
| `CURRENT_STATE.md` | `starter-reset` | Replaced from `TEMPLATE_STARTERS/CURRENT_STATE.md`. |
| `AI_HANDOFF.md` | `starter-reset` | Replaced from `TEMPLATE_STARTERS/AI_HANDOFF.md`. |
| `ARTIFACT_REGISTRY.md` | `starter-reset` | Replaced via Step 4 below (no `TEMPLATE_STARTERS/` file required in this slice; generated inline). |
| `SPECS/SPEC_INDEX.md` | `starter-reset` | Replaced via Step 4 below (generated inline). |
| `TRACEABILITY_MATRIX.md` | `starter-reset` | Replaced from `TEMPLATE_STARTERS/TRACEABILITY_MATRIX.md`. |
| `GOVERNANCE.md` | `copy-clean` | Metadata cites PG specs only. |
| `BRANCH_AND_WORKTREE_GUIDE.md` | `copy-clean` | Metadata cites PG specs only. |
| `OPERATION_ROUTING.md` | `copy-clean` | Metadata cites PG spec only. Body uses "ProjectGenesis" as the operating-model brand. |
| `memory/ai/SHARED_AGENT_RULES.md` | `copy-clean` | Metadata cites PG spec only. |
| `memory/ai/ROLE_*.md` | `copy-clean` | Clean. |
| `CONTEXT_PACKS/*.md` | `copy-clean` | Metadata cites PG specs only. |

`SPECS/SPEC_INDEX.md` and `ARTIFACT_REGISTRY.md` are handled by an inline
starter generated during scaffold assembly (Step 4 below). Future iterations
may promote these to dedicated files under `TEMPLATE_STARTERS/`; that
expansion is explicitly out of scope for this slice.

## Starter-Reset Mapping

| Target Path In New Project | Starter Source |
|----------------------------|----------------|
| `AI_HANDOFF.md` | `TEMPLATE_STARTERS/AI_HANDOFF.md` |
| `CURRENT_STATE.md` | `TEMPLATE_STARTERS/CURRENT_STATE.md` |
| `BACKLOG.md` | `TEMPLATE_STARTERS/BACKLOG.md` |
| `BACKLOG/BACKLOG_INDEX.md` | `TEMPLATE_STARTERS/BACKLOG_INDEX.md` |
| `REVIEWS/REVIEW_INDEX.md` | `TEMPLATE_STARTERS/REVIEW_INDEX.md` |
| `WORKLOG/WORKLOG_INDEX.md` | `TEMPLATE_STARTERS/WORKLOG_INDEX.md` |
| `TRACEABILITY_MATRIX.md` | `TEMPLATE_STARTERS/TRACEABILITY_MATRIX.md` |
| `TEST_RESULTS.md` | `TEMPLATE_STARTERS/TEST_RESULTS.md` |
| `ARTIFACT_REGISTRY.md` | Inline minimal starter (Step 4 below). |
| `IMPLEMENTATION_PLAN.md` | Inline minimal starter (Step 4 below). |
| `SPECS/SPEC_INDEX.md` | Inline minimal starter (Step 4 below). |
| `README.md` | Inline minimal starter (Step 4 below). |

## Manifest-Mediated Scaffold Procedure

The procedure below produces a clean new-project scaffold (`<DEST>`) from a
ProjectGenesis checkout (`<SRC>`). Run it from a shell in the maintainer's
environment.

### Step 1: Create Destination Root

```sh
mkdir -p "<DEST>"
```

### Step 2: Copy `copy` And `copy-clean` Paths

Copy each path listed in the manifest with class `copy` or `copy-clean`, plus
the nested overrides with those classes, into `<DEST>` preserving relative
path. Suggested commands:

```sh
# top-level files
for f in \
  .gitignore \
  AGENTS.md \
  AI_PROJECT_BOOTSTRAP.md \
  AI_REVIEW_PROMPTS.md \
  ARCHITECTURE.md \
  BOOTSTRAP_USAGE.md \
  BRANCH_AND_WORKTREE_GUIDE.md \
  CI_CD_GUIDE.md \
  CLAUDE.md \
  CONTEXT_INDEX.md \
  CONTRIBUTING.md \
  DECISIONS.md \
  GOVERNANCE.md \
  HOOKS_AND_GUARDRAILS.md \
  LICENSE \
  NEW_PROJECT_INITIALIZATION.md \
  OBSERVABILITY.md \
  OPEN_QUESTIONS.md \
  OPERATION_ROUTING.md \
  PR_MERGE_POLICY.md \
  PR_REVIEW_POLICY.md \
  RELEASE_READINESS.md \
  RISK_MODEL.md \
  SECURITY_AND_PRIVACY.md \
  TEMPLATE_MANIFEST.md \
  TEST_STRATEGY.md; do
    cp "<SRC>/$f" "<DEST>/$f"
done

# top-level folders (full copy)
for d in \
  .githooks \
  00_intake \
  01_context \
  02_requirements \
  COMMANDS \
  CONTEXT_PACKS \
  TEMPLATE_STARTERS \
  memory; do
    cp -R "<SRC>/$d" "<DEST>/$d"
done

# .github with nested overrides: copy workflows only
mkdir -p "<DEST>/.github"
if [ -d "<SRC>/.github/workflows" ]; then
    cp -R "<SRC>/.github/workflows" "<DEST>/.github/workflows"
fi
# .github/CODEOWNERS carries upstream owner attribution and is intentionally
# NOT copied; downstream projects add their own CODEOWNERS as needed.
# .github/ISSUE_TEMPLATE/ is maintainer-archive and intentionally NOT copied.

# SCRIPTS with nested overrides: copy reusable scripts only
mkdir -p "<DEST>/SCRIPTS"
for s in \
  start-claude.sh \
  operation-profile.sh \
  strict-gate-paths.sh \
  session.sh \
  doctor.sh \
  metric-acceptance-coverage.sh \
  metric-evidence-coverage.sh \
  metric-traceability-completeness.sh \
  validate-bootstrap.sh \
  validate-bootstrap-red-checks.sh; do
    if [ -f "<SRC>/SCRIPTS/$s" ]; then
        cp "<SRC>/SCRIPTS/$s" "<DEST>/SCRIPTS/$s"
    fi
done
# SCRIPTS/run-seeded-defect-bench.sh and SCRIPTS/scaffold-extract.sh are
# maintainer-archive and intentionally NOT copied.

# TESTS with nested overrides: copy reusable manual-test scaffold only
mkdir -p "<DEST>/TESTS"
if [ -f "<SRC>/TESTS/MANUAL_TEST_CHECKLIST.md" ]; then
    cp "<SRC>/TESTS/MANUAL_TEST_CHECKLIST.md" "<DEST>/TESTS/MANUAL_TEST_CHECKLIST.md"
fi
# TESTS/ACCEPTANCE_CRITERIA_MAP.md and TESTS/ADVERSARIAL_SEED_BENCHMARK.md are
# maintainer-archive and intentionally NOT copied.

# folders copied index-and-templates only (instance files are starter-reset)
mkdir -p "<DEST>/ADR" "<DEST>/ADR/templates" \
  "<DEST>/BACKLOG" "<DEST>/BACKLOG/templates" \
  "<DEST>/REVIEWS" "<DEST>/REVIEWS/templates" \
  "<DEST>/SPECS" "<DEST>/SPECS/templates" \
  "<DEST>/WORKLOG"
cp "<SRC>/ADR/ADR_INDEX.md" "<DEST>/ADR/ADR_INDEX.md"
cp -R "<SRC>/ADR/templates/." "<DEST>/ADR/templates/"
cp -R "<SRC>/BACKLOG/templates/." "<DEST>/BACKLOG/templates/"
cp -R "<SRC>/REVIEWS/templates/." "<DEST>/REVIEWS/templates/"
cp -R "<SRC>/SPECS/templates/." "<DEST>/SPECS/templates/"
```

### Step 3: Apply Starter-Reset Files

Copy each starter file in `TEMPLATE_STARTERS/` to its mapped destination.
Suggested:

```sh
cp "<SRC>/TEMPLATE_STARTERS/AI_HANDOFF.md"        "<DEST>/AI_HANDOFF.md"
cp "<SRC>/TEMPLATE_STARTERS/CURRENT_STATE.md"     "<DEST>/CURRENT_STATE.md"
cp "<SRC>/TEMPLATE_STARTERS/BACKLOG.md"           "<DEST>/BACKLOG.md"
cp "<SRC>/TEMPLATE_STARTERS/BACKLOG_INDEX.md"     "<DEST>/BACKLOG/BACKLOG_INDEX.md"
cp "<SRC>/TEMPLATE_STARTERS/REVIEW_INDEX.md"      "<DEST>/REVIEWS/REVIEW_INDEX.md"
cp "<SRC>/TEMPLATE_STARTERS/WORKLOG_INDEX.md"     "<DEST>/WORKLOG/WORKLOG_INDEX.md"
cp "<SRC>/TEMPLATE_STARTERS/TRACEABILITY_MATRIX.md" "<DEST>/TRACEABILITY_MATRIX.md"
cp "<SRC>/TEMPLATE_STARTERS/TEST_RESULTS.md"      "<DEST>/TEST_RESULTS.md"
```

### Step 4: Apply Inline Minimal Starters

Write the four inline starter files below. Each is short, clean, and
project-neutral. Replace `<Project Name>` with the consumer's project name.

#### `ARTIFACT_REGISTRY.md`

```md
---
artifact_id: ART-REG-001
title: Artifact Registry
type: registry
status: authoritative
version: v0.1
created: YYYY-MM-DD
updated: YYYY-MM-DD
owner: <Project Name> Maintainers
source: Initial bootstrap scaffold
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true
---

# Artifact Registry

The registry identifies current, authoritative, active, draft, generated,
temporary, superseded, deprecated, cancelled, and archived artifacts.

## Entries

| Artifact ID | Title | Type | Status | Version | Owner | File | Notes |
|-------------|-------|------|--------|---------|-------|------|-------|
| none | none | none | none | none | none | none | No artifacts registered yet. |
```

#### `IMPLEMENTATION_PLAN.md`

```md
---
artifact_id: ART-IMPL-PLAN-001
title: Implementation Plan
type: implementation-plan
status: active
version: v0.1
created: YYYY-MM-DD
updated: YYYY-MM-DD
owner: <Project Name> Maintainers
source: Initial bootstrap scaffold
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false
---

# Implementation Plan

No implementation phases scheduled yet. Add phases once the first spec is
approved.
```

#### `SPECS/SPEC_INDEX.md`

```md
---
artifact_id: ART-SPEC-INDEX
title: Spec Index
type: spec-index
status: active
version: v0.1
created: YYYY-MM-DD
updated: YYYY-MM-DD
owner: <Project Name> Maintainers
source: Initial bootstrap scaffold
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true
---

# Spec Index

Specs are the source of truth for product behavior, spikes, integrations,
infrastructure tasks, refactors, and acceptance criteria.

## Specs

| Spec ID | Title | File | Status | Version | Owner | Related Backlog | Related Ticket | Related ADRs | Current Status |
|---------|-------|------|--------|---------|-------|-----------------|----------------|--------------|----------------|
| none | none | none | none | none | none | none | none | none | No specs registered yet. |

## Rules

- Implementation requires an approved or active spec.
- Draft or proposed specs allow discovery, research, architecture analysis,
  spike work, and backlog preparation only.
- Update this index whenever a spec is created, changed, superseded,
  cancelled, archived, implemented, tested, or released.
```

#### `README.md`

The reuse-boundary slice fixes the inline starter so it does not name the
upstream scaffold. `SCRIPTS/scaffold-extract.sh` emits the same neutral
content directly:

```md
# Project Name

This repository was initialized from an AI project bootstrap scaffold.

## Next Steps

1. Add product source material to `00_intake/raw/`.
2. Ask an AI agent that follows `AGENTS.md` to run `Start requirement breakdown`.
3. Replace this README with the project's own description before publishing.
```

### Step 5: Confirm Exclusions

Confirm the following are not present in `<DEST>`:

- `.git/`
- `ARTIFACTS/` (or `ARTIFACTS/ARCHIVE/` with non-empty content)
- `BACKLOG/BOOT-*.md`
- `REVIEWS/PR_REVIEW_PACKAGE-*.md`
- `REVIEWS/REVIEW-*.md`
- `SPECS/SPEC-BOOT-*.md`
- `BOOTSTRAP_AUDIT.md`
- `GITHUB_REPOSITORY_SETUP.md`
- `GOVERNANCE_PERFORMANCE.md`
- `PARALLEL_EXECUTION_PLAN.md`
- `SCAFFOLD_FORK_CHECKLIST.md`
- `STALE_ITEMS.md`
- `docs/`
- `examples/` (unless the consumer explicitly wants the example reference)
- `.github/ISSUE_TEMPLATE/`
- `TESTS/ACCEPTANCE_CRITERIA_MAP.md`
- `TESTS/ADVERSARIAL_SEED_BENCHMARK.md`
- `SCRIPTS/run-seeded-defect-bench.sh`
- `SCRIPTS/scaffold-extract.sh`

### Step 6: Dry-Run Forbidden-History Search

Run a forbidden-history search across the assembled `<DEST>`. The search must
look at active operational files and required-reading files. Suggested terms:

```text
ProjectGenesis
BOOT
BOOT-
PR #
PR-
pull request
review-fix
review package
post-merge cleanup
validation envelope
worklog
Codex re-review
Claude re-review
claude/
codex/
```

Allowlist only intentional reusable mentions or clearly marked examples
(for example, generic example ticket IDs like `BOOT-001` used as illustration
in reusable docs, or the upstream scaffold brand name used to identify the
scaffold lineage in `TEMPLATE_MANIFEST.md` and `OPERATION_ROUTING.md`). The
inline `README.md` starter is project-neutral and must not be allowlisted
as a brand-attribution site.

The dry run passes only if required-reading active files are clean starter or
clean reusable files.

## Dry-Run Scaffold Check Instructions

Maintainers run a lightweight dry run before declaring the manifest healthy:

1. Pick a destination outside the repo, e.g. `/tmp/projectx-dryrun`.
2. Follow the scaffold procedure above with `<SRC>` = ProjectGenesis root and
   `<DEST>` = the temporary destination.
3. Inspect:
   - all `starter-reset` targets exist and come from `TEMPLATE_STARTERS/` or
     the inline starters in Step 4.
   - active operational files contain no ProjectGenesis BOOT/PR/review/worklog
     history.
   - reusable operating-model files are present and unchanged.
   - `maintainer-archive` paths are absent from active state.
4. Run the forbidden-history search (Step 6 above) and inspect each hit.

## Out Of Scope For This Slice

- new heavy validators
- CI changes
- registry drift automation
- merge-state cleanup
- review-loop policy
- broad operational context cleanup
- deleting ProjectGenesis audit history
- claiming raw root copy is clean
