artifact_id: ART-TEST-003
title: Test Results
type: test-results
status: active
version: v1.2
created: 2026-05-09
updated: 2026-05-09
owner: AI Bootstrap Maintainers
source: Initial bootstrap scaffold
linked_specs: []
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

## Rules

- Record every meaningful validation run.
- Include skipped tests and exact reasons.
- Do not hide failures.
- Link results to specs or acceptance criteria where practical.
