artifact_id: ART-TEST-003
title: Test Results
type: test-results
status: active
version: v1.13
created: 2026-05-09
updated: 2026-05-13
owner: AI Bootstrap Maintainers
source: Initial bootstrap scaffold, final adversarial review, stale status fix, and narrow re-review
linked_specs: [SPEC-BOOT-002]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Test Results

| Date | Scope | Command | Result | Notes |
|------|-------|---------|--------|-------|
| 2026-05-09 | Bootstrap scaffold | `bash SCRIPTS/validate-bootstrap.sh` | passed | Initial validator run passed before adversarial review findings. |
| 2026-05-09 | Hook templates | `.githooks/pre-commit && .githooks/pre-push` | passed | Hook templates ran the bootstrap validator successfully. |
| 2026-05-09 | Review fixes | `bash SCRIPTS/validate-bootstrap.sh`, `.githooks/pre-commit`, `.githooks/pre-push` | passed | Registry, validator, hook, input directory, merge policy, and handoff fixes validated. |
| 2026-05-09 | Governance metadata exception | `bash SCRIPTS/validate-bootstrap.sh`, `.githooks/pre-commit`, `.githooks/pre-push` | passed | Added documented exception for short agent entrypoint files; validation passed after edit. |
| 2026-05-09 | Shared role required-file red check | focused shell existence check for `memory/ai/SHARED_AGENT_RULES.md`, required `ROLE_*.md` files, and `SCRIPTS/start-claude.sh` | failed as expected | Confirmed the new required shared-role surface was missing before implementation. |
| 2026-05-09 | Shared role validator registry check | `bash SCRIPTS/validate-bootstrap.sh` | failed as expected | Validator detected new required role files and Claude helper were not yet registered in `ARTIFACT_REGISTRY.md`. |
| 2026-05-09 | Shared role scaffold validation | `bash SCRIPTS/validate-bootstrap.sh` | passed | Shared role files, Claude helper, docs, registry, traceability, and validator checks passed. |
| 2026-05-09 | Shared role script syntax | `bash -n SCRIPTS/start-claude.sh && bash -n SCRIPTS/validate-bootstrap.sh` | passed | Claude helper and validator shell syntax checks passed. |
| 2026-05-09 | Shared role review fixes | `bash SCRIPTS/validate-bootstrap.sh` | passed | Durable PR review package added and Claude default mode documented as orientation-only. |
| 2026-05-09 | Shared role review fix script syntax | `bash -n SCRIPTS/start-claude.sh && bash -n SCRIPTS/validate-bootstrap.sh` | passed | Claude helper and validator syntax checks passed after review fixes. |
| 2026-05-09 | Commit preparation validation | `bash SCRIPTS/validate-bootstrap.sh` | passed | Bootstrap validation passed before baseline commit. |
| 2026-05-09 | Commit preparation script syntax | `bash -n .githooks/pre-commit && bash -n SCRIPTS/start-claude.sh && bash -n SCRIPTS/validate-bootstrap.sh` | passed | Hook and script syntax checks passed before baseline commit. |
| 2026-05-09 | Pre-commit hook validation | `.githooks/pre-commit` | passed | Hook initially detected its own secret scanner pattern in staged content; after splitting scanner literals into shell fragments, hook passed. |
| 2026-05-09 | Shared role adversarial review validation | `bash SCRIPTS/validate-bootstrap.sh`; `bash -n SCRIPTS/start-claude.sh`; `bash -n SCRIPTS/validate-bootstrap.sh` | passed | Review validation passed; review decision remains request changes because process and startup-mode findings are recorded in `REVIEWS/REVIEW-2026-05-09-shared-role-system.md`. |
| 2026-05-13 | Scaffold improvement plan adversarial review validation | `bash SCRIPTS/validate-bootstrap.sh` | passed | Baseline validation passed before creating the review record and required state updates for the proposed scaffold improvement plan. |
| 2026-05-13 | Scaffold improvement plan review state validation | `bash SCRIPTS/validate-bootstrap.sh` | passed | Validation passed after creating the review record and updating review index, registry, traceability, current state, handoff, test results, and worklog. |
| 2026-05-13 | SPEC-BOOT-002 spec creation validation | `bash SCRIPTS/validate-bootstrap.sh` | passed | Validation passed after creating `SPECS/SPEC-BOOT-002-scaffold-intake-and-governance.md`, adding staged backlog items, and updating registry, traceability, current state, handoff, test results, and worklog. |
| 2026-05-13 | SPEC-BOOT-002 v0.2 correction validation | `bash SCRIPTS/validate-bootstrap.sh`; `git diff --check` | passed | Validation passed after correcting BOOT-012 workflow-policy scope and adding branch/governance artifacts to the proposed implementation inventory. |
| 2026-05-13 | SPEC-BOOT-002 v0.4 correction validation | `bash SCRIPTS/validate-bootstrap.sh`; `git diff --check` | passed | Validation passed after addressing independent review findings for assumption approval authority, staged sequencing, ticket evidence, NFR traceability, artifact inventory, and validator red-check fixture design. |
| 2026-05-13 | SPEC-BOOT-002 implementation validation | `bash SCRIPTS/validate-bootstrap.sh`; `bash SCRIPTS/validate-bootstrap-red-checks.sh`; `git diff --check` | passed | Validation passed after implementing BOOT-010 through BOOT-015: intake, product context, requirements control, workflow policy, templates, validator red checks, context packs, command framework, and onboarding migration. |
| 2026-05-13 | SPEC-BOOT-002 pre-final-review validation | `bash SCRIPTS/validate-bootstrap.sh`; `bash SCRIPTS/validate-bootstrap-red-checks.sh`; `git diff --check` | passed | Fresh validation passed before requesting final implementation review. |
| 2026-05-13 | SPEC-BOOT-002 final review fixes validation | `bash SCRIPTS/validate-bootstrap.sh`; `bash SCRIPTS/validate-bootstrap-red-checks.sh`; `git diff --check` | passed | Validation passed after fixing final review findings for column-aware source evidence checks, approved-assumption evidence checks, Product Analyst intake path guidance, and context-pack authority limits. |
| 2026-05-13 | SPEC-BOOT-002 final implementation review | independent reviewer re-review plus targeted temporary fixtures | passed | Re-review approved with minor comments; targeted fixtures for empty source IDs, self-approved assumption evidence, and unsupported assumption evidence failed as expected. |
| 2026-05-13 | SPEC-BOOT-002 final state validation | `bash SCRIPTS/validate-bootstrap.sh`; `bash SCRIPTS/validate-bootstrap-red-checks.sh`; `git diff --check` | passed | Final validation after review record, traceability, acceptance map, registry, current state, handoff, test results, and worklog updates. |
| 2026-05-13 | SPEC-BOOT-002 final adversarial review validation | `bash SCRIPTS/validate-bootstrap.sh`; `bash SCRIPTS/validate-bootstrap-red-checks.sh`; `git diff --check`; `bash -n SCRIPTS/validate-bootstrap.sh && bash -n SCRIPTS/validate-bootstrap-red-checks.sh` | passed | Independent validation passed during final adversarial review. Review decision is request changes for stale `SPECS/SPEC_INDEX.md` current-status text. |
| 2026-05-13 | SPEC-BOOT-002 final adversarial review state validation | `bash SCRIPTS/validate-bootstrap.sh`; `bash SCRIPTS/validate-bootstrap-red-checks.sh`; `git diff --check`; `bash -n SCRIPTS/validate-bootstrap.sh && bash -n SCRIPTS/validate-bootstrap-red-checks.sh` | passed | Validation passed after adding the final review record, stale-item entry, registry, traceability, state, handoff, test-result, and worklog updates. |
| 2026-05-13 | SPEC-BOOT-002 stale spec-index status fix | `bash SCRIPTS/validate-bootstrap.sh`; `bash SCRIPTS/validate-bootstrap-red-checks.sh`; `git diff --check`; `bash -n SCRIPTS/validate-bootstrap.sh && bash -n SCRIPTS/validate-bootstrap-red-checks.sh` | passed | `SPECS/SPEC_INDEX.md` status text was corrected, `STALE_ITEMS.md` marked the stale item resolved, and narrow re-review approved with no remaining P0/P1/P2 findings. |

## Rules

- Record every meaningful validation run.
- Include skipped tests and exact reasons.
- Do not hide failures.
- Link results to specs or acceptance criteria where practical.
