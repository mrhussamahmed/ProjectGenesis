artifact_id: ART-HOOKS-001
title: Hooks And Guardrails
type: guide
status: authoritative
version: v1.0
created: 2026-05-09
updated: 2026-05-09
owner: AI Bootstrap Maintainers
source: User request and reference repository audit
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Hooks And Guardrails

Local hooks should be fast and obvious. Heavier checks belong in CI.

## Suggested Local Checks

- formatting checks where available
- linting where available
- secret scan where available
- generated-file checks
- stale-artifact check
- artifact metadata reminder
- spec link reminder for implementation changes
- handoff update reminder
- traceability update reminder
- bootstrap consistency validation

## Suggested CI Checks

- full test suite
- type checks
- dependency audit
- security scan
- build verification
- contract tests
- integration tests
- documentation consistency checks
- traceability checks
- PR review checklist validation
- bootstrap validation script

## Hook Templates

This package includes:

- `.githooks/pre-commit`
- `.githooks/commit-msg`
- `.githooks/pre-push`

To enable them in a Git repository:

```sh
git config core.hooksPath .githooks
```

## Guardrail Philosophy

- Do not block routine work with slow local checks.
- Do block commits that clearly violate bootstrap consistency.
- Do remind agents to update shared state when implementation files changed.
- Do not install stack-specific tools until architecture selects the stack.

