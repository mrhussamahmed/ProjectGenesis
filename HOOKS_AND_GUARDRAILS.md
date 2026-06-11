artifact_id: ART-HOOKS-001
title: Hooks And Guardrails
type: guide
status: authoritative
version: v1.2
created: 2026-05-09
updated: 2026-06-10
owner: AI Bootstrap Maintainers
source: User request, reference repository audit, and SPEC-BOOT-003
linked_specs: [SPEC-BOOT-003]
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
- operation classification reminder
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
- operation routing structural checks
- red-check validation for validator-rule changes

## Hook Templates

This package includes:

- `.githooks/pre-commit`
- `.githooks/commit-msg`
- `.githooks/pre-push`

To enable them in a Git repository (required once per clone; `SCRIPTS/doctor.sh`
warns when this is missing):

```sh
git config core.hooksPath .githooks
```

## Strict-Gate Pattern Source

`SCRIPTS/strict-gate-paths.sh` is the single source of truth for the
strict-gate path pattern. `.githooks/pre-commit`, `.githooks/pre-push`, and
`.github/workflows/bootstrap-validation.yml` all consume it (`--regex` or
`--match`); none carries its own copy. If the helper is missing, the hooks
fail closed and run strict validation. Edit the pattern only in that script.

## Fast-Path Sessions

`SCRIPTS/session.sh` is the entry point for the validation fast path:

```sh
bash SCRIPTS/session.sh start docs-trivial "short task note"
```

It writes gitignored `.ai/SESSION.md` (format: `TEMPLATE_STARTERS/SESSION.md`)
with the keys `SCRIPTS/operation-profile.sh` reads. Light profiles then route
hooks to shape-only validation (scoped to the staged/changed file set) and
the `state-sync` profile routes to the intermediate state-sync validator
level, unless the change touches a strict-gate path. Stale (12-hour TTL),
branch-mismatched, or absent sessions route strict — fail-closed. Use
`session.sh touch` to refresh, `status` to inspect, and `clear` to drop back
to strict.

## Guardrail Philosophy

- Do not block routine work with slow local checks.
- Do block commits that clearly violate bootstrap consistency.
- Do block protected work that lacks durable operation classification or final
  evidence.
- Do remind agents to update shared state when implementation files changed.
- Do not install stack-specific tools until architecture selects the stack.
