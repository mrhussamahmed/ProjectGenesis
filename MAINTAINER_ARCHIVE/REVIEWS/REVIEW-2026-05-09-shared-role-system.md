artifact_id: ART-REVIEW-SHARED-ROLE-001
title: Shared Role System Adversarial Review
type: pr-review
status: active
version: v1.1
created: 2026-05-09
updated: 2026-05-09
owner: AI Bootstrap Maintainers
source: Codex adversarial review
linked_specs: []
linked_tickets:
- BOOT-001
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Shared Role System Adversarial Review

## Review Decision

Request changes.

## Risk Level

medium

## Review Effort

adversarial deep, local only

## Review Scope

Reviewed the shared `memory/ai/` role system update for Claude, Codex, and other
agents, including the role files, agent entrypoints, Claude startup helper,
validator changes, traceability, registry, current state, handoff, and test
records.

## Files Reviewed

- `memory/ai/SHARED_AGENT_RULES.md`
- `memory/ai/ROLE_*.md`
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
- `PR_REVIEW_POLICY.md`
- `PR_MERGE_POLICY.md`
- `RISK_MODEL.md`
- `BACKLOG.md`
- `ADR/ADR_INDEX.md`

## Specs And ADRs Reviewed

- `SPECS/SPEC_INDEX.md`: no product specs exist.
- `ADR/ADR_INDEX.md`: no active ADRs exist.
- `BOOT-001` in `BACKLOG.md` is the governing bootstrap baseline exception.

## Commands Run

- `git status --short --branch`
- `bash SCRIPTS/validate-bootstrap.sh`
- `bash -n SCRIPTS/start-claude.sh`
- `bash -n SCRIPTS/validate-bootstrap.sh`
- targeted `find`, `rg`, `sed`, and `nl` inspection of role, review, registry,
  traceability, handoff, and script files

## Findings

| Severity | Finding | Evidence | Required Change |
|----------|---------|----------|-----------------|
| P1 | Missing durable PR review package for the shared role update. Repository policy requires a review package for PR preparation and the adversarial reviewer role lists the PR review package as required context. The repository currently has only the prior baseline review record under `REVIEWS/`; there is no shared-role review package file. Because repository files are source of truth and chat history is non-authoritative, this blocks merge readiness for the update. | `AI_PROJECT_BOOTSTRAP.md` Phase 11 requires creating `REVIEWS/templates/PR_REVIEW_PACKAGE_TEMPLATE.md` output; Phase 12 requires the reviewer to read the review package. `ROLE_ADVERSARIAL_PR_REVIEWER.md` lists PR review package as required context and says missing review package triggers request changes or block. `find REVIEWS -maxdepth 1 -type f -print` showed only `.DS_Store`, `REVIEW-2026-05-09-bootstrap-baseline.md`, and `REVIEW_INDEX.md` before this review record was created. | Create a durable PR review package under `REVIEWS/` for this shared-role change or add an explicit documented bootstrap exception that allows the merge note to serve as the package. Link it from `REVIEWS/REVIEW_INDEX.md`, `TRACEABILITY_MATRIX.md`, and `ARTIFACT_REGISTRY.md`. |
| P2 | The advertised default Claude startup path loads no role file. `./SCRIPTS/start-claude.sh` is listed as a normal startup example, but `default)` sets `role_prompt=""`, while the shared rules require reading the relevant role file for the task. This weakens the guarantee that Claude and Codex enter the same selected-role operating model. | `SCRIPTS/start-claude.sh` lines 11-14 set `default)` to an empty role prompt. `CLAUDE.md` lists `./SCRIPTS/start-claude.sh` as a startup example. `memory/ai/SHARED_AGENT_RULES.md` requires reading exactly the relevant role file for the task. | Either require an explicit mode and remove the no-role default, map `default` to a safe non-work role such as documentation/handoff, or document that default is only a bootstrap shell and must not be used for task work until a role is selected. Update validation to assert the intended default behavior. |

## Passing Evidence

- `bash SCRIPTS/validate-bootstrap.sh` passed.
- `bash -n SCRIPTS/start-claude.sh` passed.
- `bash -n SCRIPTS/validate-bootstrap.sh` passed.
- All required `memory/ai/ROLE_*.md` files exist and have metadata.
- Shared role artifacts are present in `ARTIFACT_REGISTRY.md`.
- `TRACEABILITY_MATRIX.md` contains `REQ-BOOT-013` for the shared AI role
  system.

## Open Questions And Residual Risks

- The repository has no commits yet; this review was performed against the live
  worktree rather than a clean PR diff.
- Ignored `.DS_Store` files exist in several directories. They are ignored by
  `.gitignore`, but should not be included in any packaged distribution.

## Required Changes Before Approval

1. Add a durable review package or documented exception for this shared-role
   change.
2. Resolve or explicitly document the no-role default mode behavior in
   `SCRIPTS/start-claude.sh` and its docs.
3. Rerun `bash SCRIPTS/validate-bootstrap.sh` and shell syntax checks after the
   fixes.

## Implementation Response

The implementation agent addressed the requested changes after this review:

- P1 response: added
  `REVIEWS/PR_REVIEW_PACKAGE-2026-05-09-shared-role-system.md` as the durable
  PR review package and linked it from `REVIEWS/REVIEW_INDEX.md`,
  `TRACEABILITY_MATRIX.md`, and `ARTIFACT_REGISTRY.md`.
- P2 response: kept `default` mode to satisfy the original bootstrap mode
  requirement, but made it explicitly orientation-only in
  `SCRIPTS/start-claude.sh`, `memory/ai/SHARED_AGENT_RULES.md`, `CLAUDE.md`,
  `BOOTSTRAP_USAGE.md`, and `AI_PROJECT_BOOTSTRAP.md`.
- Validation response: added validator checks for default-mode documentation.
  `bash SCRIPTS/validate-bootstrap.sh` passed, and
  `bash -n SCRIPTS/start-claude.sh && bash -n SCRIPTS/validate-bootstrap.sh`
  passed after the fixes.

The original review decision remains request changes until a fresh reviewer
records a new decision.
