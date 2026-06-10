artifact_id: ART-TEST-001
title: Test Strategy
type: test-strategy
status: authoritative
version: v1.1
created: 2026-05-09
updated: 2026-05-14
owner: AI Bootstrap Maintainers
source: User request and SPEC-BOOT-003
linked_specs: [SPEC-BOOT-003]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Test Strategy

Testing is driven by specs and acceptance criteria. Automated tests are
preferred where practical. Manual checks are acceptable only when automation is
not practical and the reason is recorded.

## Implementation Sequence

1. Read the relevant spec and acceptance criteria.
2. Classify the operation and validation mode using `OPERATION_ROUTING.md`.
3. Identify expected behavior.
4. Create or update tests first where practical.
5. Confirm tests fail for the right reason when practical.
6. Implement the smallest safe change.
7. Run relevant tests.
8. Refactor only after tests pass.
9. Update documentation, traceability, artifact registry, and handoff.

## Test Levels

- Unit tests: local behavior and pure logic.
- Integration tests: cross-module behavior and data flow.
- Contract tests: API, schema, provider, and boundary behavior.
- End-to-end tests: critical user journeys.
- Performance tests: critical flows and capacity-sensitive areas.
- Security tests: auth, authorization, input validation, dependency, secrets.
- Manual tests: exploratory checks, visual checks, or cases that cannot be
  automated economically.

## Rules

- Do not claim a feature is complete unless relevant tests exist or the lack of
  tests is explicitly justified.
- Acceptance criteria should become automated tests wherever practical.
- Every test should map to at least one acceptance criterion where practical.
- Record test results in `TEST_RESULTS.md`, `AI_HANDOFF.md`, or worklog before
  stopping.
- If tests were not run, state exactly why.
- Validate once per PR, not per edit: one full validation covering the final
  diff supersedes per-edit re-runs; the PR evidence note states which run
  covered the set.
- Use fast, standard, or strict validation mode from `OPERATION_ROUTING.md`;
  skipped checks require durable rationale.
- If tests fail, record the failure, likely cause, and next action.
- Do not delete or weaken tests to make a change pass unless the spec changed
  and the reason is documented.
