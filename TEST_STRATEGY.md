artifact_id: ART-TEST-001
title: Test Strategy
type: test-strategy
status: authoritative
version: v1.0
created: 2026-05-09
updated: 2026-05-09
owner: AI Bootstrap Maintainers
source: User request
linked_specs: []
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
2. Identify expected behavior.
3. Create or update tests first where practical.
4. Confirm tests fail for the right reason when practical.
5. Implement the smallest safe change.
6. Run relevant tests.
7. Refactor only after tests pass.
8. Update documentation, traceability, artifact registry, and handoff.

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
- If tests fail, record the failure, likely cause, and next action.
- Do not delete or weaken tests to make a change pass unless the spec changed
  and the reason is documented.

