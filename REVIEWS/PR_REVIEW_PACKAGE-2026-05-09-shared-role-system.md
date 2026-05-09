artifact_id: ART-PR-PACKAGE-SHARED-ROLE-001
title: Shared Role System PR Review Package
type: pr-review-package
status: active
version: v1.0
created: 2026-05-09
updated: 2026-05-09
owner: AI Bootstrap Maintainers
source: Shared role system implementation
linked_specs: []
linked_tickets:
- BOOT-001
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Shared Role System PR Review Package

## PR Title

Add shared AI role system for Claude, Codex, and other coding agents.

## PR Purpose

Make `memory/ai/` the durable source of truth for shared agent behavior so
Claude, Codex, and other coding agents follow the same roles, source-of-truth
hierarchy, handoff protocol, traceability rules, diagram rules, and review
policy.

## Linked Specs

- None. This is bootstrap-governance work covered by backlog item `BOOT-001`.
  Product implementation still requires approved or active specs.

## Linked Backlog Items Or Tickets

- `BOOT-001` in `BACKLOG.md`: validate bootstrap scaffold.
- No external Linear ticket is claimed.

## Linked ADRs

- None. No product or runtime architecture decision was introduced.

## Changed Files

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
- `SCRIPTS/start-claude.sh`
- `SCRIPTS/validate-bootstrap.sh`
- `AGENTS.md`
- `CLAUDE.md`
- `CONTEXT_INDEX.md`
- `BOOTSTRAP_USAGE.md`
- `AI_PROJECT_BOOTSTRAP.md`
- `ARCHITECTURE.md`
- `ARTIFACT_REGISTRY.md`
- `TRACEABILITY_MATRIX.md`
- `CURRENT_STATE.md`
- `AI_HANDOFF.md`
- `TEST_RESULTS.md`
- `REVIEWS/REVIEW_INDEX.md`
- `REVIEWS/REVIEW-2026-05-09-shared-role-system.md`
- `REVIEWS/PR_REVIEW_PACKAGE-2026-05-09-shared-role-system.md`
- `WORKLOG/WORKLOG_INDEX.md`

## Summary Of Changes

- Added shared agent rules and role definitions under `memory/ai/`.
- Added `SCRIPTS/start-claude.sh` with an explicit mode allowlist.
- Updated `AGENTS.md` so Codex and generic agents read the same role files
  directly.
- Updated `CLAUDE.md` so Claude treats startup prompts as optional
  convenience, not source of truth.
- Documented the shared role system in bootstrap, context, and usage docs.
- Updated validation to check shared role files, Claude startup script, mode
  allowlist, and default-mode documentation.
- Registered the new artifacts and traceability.
- Recorded adversarial review findings and this review package.

## Acceptance Criteria

- Shared behavior rules live in `memory/ai/SHARED_AGENT_RULES.md`.
- Required role definitions exist under `memory/ai/`.
- Claude startup supports only allowlisted modes.
- `default` Claude startup remains allowed but is explicitly orientation-only
  and not valid for task work until a role file is selected.
- Codex instructions tell Codex to read the same shared rules and role files
  directly.
- `CLAUDE.md` and `AGENTS.md` stay short and point to shared files.
- Artifact registry and traceability include the shared role system.
- Validation catches missing role files, missing Claude startup script, missing
  registry entries, missing allowlisted modes, and missing default-mode
  documentation.

## Tests Added Or Changed

- `SCRIPTS/validate-bootstrap.sh` now checks:
  - `memory/ai/SHARED_AGENT_RULES.md`
  - all required `memory/ai/ROLE_*.md` files
  - `SCRIPTS/start-claude.sh`
  - executable bit for `SCRIPTS/start-claude.sh`
  - allowlisted Claude modes
  - default mode orientation-only documentation in script and docs

## Test Results

- Focused required-file check failed before implementation, as expected.
- `bash SCRIPTS/validate-bootstrap.sh` failed before new artifacts were
  registered in `ARTIFACT_REGISTRY.md`, as expected.
- `bash SCRIPTS/validate-bootstrap.sh` passed after alignment.
- `bash -n SCRIPTS/start-claude.sh` passed.
- `bash -n SCRIPTS/validate-bootstrap.sh` passed.
- After the review fixes, `bash SCRIPTS/validate-bootstrap.sh` passed.
- After the review fixes,
  `bash -n SCRIPTS/start-claude.sh && bash -n SCRIPTS/validate-bootstrap.sh`
  passed.

## Known Risks

- The repository has no commits yet, so review is against the live bootstrap
  worktree rather than a clean PR diff.
- `SCRIPTS/start-claude.sh` requires the `claude` CLI in the caller
  environment.
- Downstream projects may need additional project-specific validation after a
  stack is selected.

## Known Limitations

- The bootstrap package does not include product-specific specs, runtime
  architecture, or product tests.
- `default` Claude startup is for orientation only. Task work requires a
  selected role mode or direct reading of the relevant role file.

## Assumptions

- This reusable scaffold is allowed to use `BOOT-001` as the governing backlog
  item for bootstrap governance changes.
- Older `memory/ai/PROJECT_AI_RULES.md` and `memory/ai/*_SYSTEM_PROMPT.md`
  compatibility files were absent, so no compatibility aliases were needed.

## Unresolved Questions

- Which product input should be used for the first downstream project scaffold?
- Will Linear be available for the downstream project?

## Rollout Considerations

- Copy the full `memory/ai/` directory, `AGENTS.md`, `CLAUDE.md`, and
  `SCRIPTS/start-claude.sh` with the scaffold.
- Claude users can run `./SCRIPTS/start-claude.sh <mode>`.
- Codex users should prompt Codex to read `memory/ai/SHARED_AGENT_RULES.md`
  and the relevant `memory/ai/ROLE_*.md` file.

## Rollback Considerations

- Revert the shared role files, startup helper, and related docs as one
  coherent scaffold change if the role model is rejected.
- Do not leave `CLAUDE.md` or `AGENTS.md` pointing to missing shared files.

## Security And Privacy Considerations

- No secrets, credentials, or product data were added.
- Security reviewer role rules cover secrets, authentication, authorization,
  input validation, sensitive data handling, logging, dependency risk, and
  deployment/config risk.

## Observability Considerations

- Operational state is visible through `CURRENT_STATE.md`, `AI_HANDOFF.md`,
  `ARTIFACT_REGISTRY.md`, `TRACEABILITY_MATRIX.md`, `TEST_RESULTS.md`,
  `REVIEWS/`, and `WORKLOG/WORKLOG_INDEX.md`.

## Traceability Links

- `TRACEABILITY_MATRIX.md` row `REQ-BOOT-013`.
- `ARTIFACT_REGISTRY.md` entries for `ART-AI-*`,
  `ART-SCRIPT-CLAUDE`, `ART-REVIEW-SHARED-ROLE-001`, and
  `ART-PR-PACKAGE-SHARED-ROLE-001`.

## Artifact Updates

- Shared role files were added and registered.
- Claude and Codex entrypoints were updated as short pointers.
- Validator, registry, traceability, current state, handoff, test results, and
  worklog were updated.
- Review package and adversarial review record were registered.

## Worktree And Branch Status

- Branch: `main`
- Worktree: `/Users/ahmedabd/Desktop/AI Projects/New Poject bootstrap`
- Dirty status: repository has no commits yet; scaffold files are untracked
  before baseline commit.
- Untracked files: all scaffold files are untracked because the repository has
  just been initialized.
