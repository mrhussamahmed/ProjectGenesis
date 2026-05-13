artifact_id: ART-TEST-002
title: Test Plan
type: test-plan
status: active
version: v1.1
created: 2026-05-09
updated: 2026-05-14
owner: AI Bootstrap Maintainers
source: Initial bootstrap scaffold and SPEC-BOOT-003
linked_specs: [SPEC-BOOT-003]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Test Plan

## Bootstrap Validation

| Check | Command | Expected Result | Status |
|-------|---------|-----------------|--------|
| Required files and folders | `bash SCRIPTS/validate-bootstrap.sh` | exits 0 | passed |
| Metadata blocks | `bash SCRIPTS/validate-bootstrap.sh` | key root files include metadata | passed |
| Handoff sections | `bash SCRIPTS/validate-bootstrap.sh` | required handoff sections exist | passed |
| Operation routing structure | `bash SCRIPTS/validate-bootstrap.sh` | routing file, profile names, impact map, validation modes, and evidence envelope sections exist | active |
| Operation routing red checks | `bash SCRIPTS/validate-bootstrap-red-checks.sh` | invalid routing fixtures fail for expected reasons | active |
| Script and CI syntax | shell syntax checks and CI `validate` | changed scripts and workflow are valid | active |

## Product-Specific Tests

No product-specific tests exist yet because no product spec has been created.
When the first spec is created, add:

- unit test expectations
- integration test expectations
- contract test expectations
- end-to-end test expectations
- security test expectations
- performance test expectations
- manual test checklist entries

## Exit Criteria

The bootstrap scaffold is valid when the routed validation mode passes and
`CURRENT_STATE.md`, `AI_HANDOFF.md`, `ARTIFACT_REGISTRY.md`,
`TRACEABILITY_MATRIX.md`, and `OPERATION_ROUTING.md` are aligned.
