artifact_id: ART-TOKEN-EFFICIENCY-001
title: Token Efficiency Guidance
type: guide
status: active
version: v1.0
created: 2026-05-14
updated: 2026-05-14
owner: ProjectGenesis Maintainers
source: Public launch readiness and adoption packaging task
linked_specs: [SPEC-BOOT-003, SPEC-BOOT-004]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Token Efficiency Guidance

ProjectGenesis can reduce unnecessary AI token use by scoping reads to the task
without weakening safety. This guide is subordinate to `OPERATION_ROUTING.md`,
`CONTEXT_INDEX.md`, `GOVERNANCE.md`, and the shared agent rules.

## Load Full Context When

- The operation changes governance, validators, hooks, CI, roles, command
  framework rules, context-pack authority, source-of-truth hierarchy, security,
  release, branch, PR, merge, or risk policy.
- Implementation changes product behavior.
- Specs, backlog, requirements, assumptions, traceability, or ADRs are created
  or materially changed.
- A stale or conflicting artifact is suspected.
- Review requires fresh-context adversarial analysis.
- Validation failed and the cause is unclear.

## Load Task-Specific Context When

- The operation is a scoped documentation addition.
- The touched files are non-authoritative and do not change policy meaning.
- The target artifact already states its authority, owner, and lifecycle.
- `OPERATION_ROUTING.md` classifies the work as `docs-trivial`,
  `docs-non-authoritative`, or a narrow `docs-public-claim`.

## Use Context Packs

Use `CONTEXT_PACKS/` as read manifests, not as authority replacements.

- `CONTEXT_PACKS/product-intake.md`: rough input to product context and
  requirements.
- `CONTEXT_PACKS/spec-authoring.md`: spec drafting and readiness.
- `CONTEXT_PACKS/architecture.md`: architecture and ADR work.
- `CONTEXT_PACKS/implementation.md`: implementation-ready tasks.
- `CONTEXT_PACKS/review.md`: fresh-context review.
- `CONTEXT_PACKS/resume.md`: resume after context loss.

If a context pack conflicts with an authoritative file, follow the higher
source and record the conflict.

## Avoid Re-Reading Unchanged Files

- Read indexes and metadata first: `CONTEXT_INDEX.md`,
  `ARTIFACT_REGISTRY.md`, `TRACEABILITY_MATRIX.md`, `SPECS/SPEC_INDEX.md`.
- Use `git diff --name-only` and `git status --short --branch` to identify
  changed surfaces.
- Reopen a large file only when its relevant section may affect the current
  task.
- In handoff, record which files were intentionally not read and why.

## Separate Authoritative Docs From Historical Notes

Authoritative current truth usually lives in:

- `AI_PROJECT_BOOTSTRAP.md`
- `GOVERNANCE.md`
- `OPERATION_ROUTING.md`
- `CONTEXT_INDEX.md`
- `ARTIFACT_REGISTRY.md`
- `TRACEABILITY_MATRIX.md`
- approved or active specs
- active ADRs
- current backlog and requirement registers

Historical or lower-priority context usually lives in:

- older worklog entries
- older review records
- archived artifacts
- superseded docs
- chat history

Use historical notes to explain why something changed, not to override current
truth.

## Summarize Stale Or Historical Context

When older records are relevant, summarize only:

- the artifact path
- status
- decision or finding
- why it matters now
- whether it is superseded, resolved, or still active

Do not copy long review histories into new docs unless the detail is necessary
for a current decision.

## Fast Path And Strict Path

Fast path:

- Use for typo fixes, narrow docs cleanup, and low-risk non-authoritative
  updates.
- Read Tier 1 plus the touched section.
- Run `git diff --check`; run bootstrap validation when the touched file is
  registered or context-indexed.

Strict path:

- Use for protected mechanics, high-risk public claims, governance behavior,
  validators, CI, hooks, roles, source-of-truth hierarchy, specs, backlog,
  traceability, or product implementation.
- Read the required authority files and relevant target artifacts.
- Run bootstrap validation, red checks when validator behavior changes, diff
  checks, and stack-specific tests when applicable.
- Record a durable evidence envelope.

## Avoid Over-Validating Tiny Documentation Changes

For tiny docs-only edits, do not repeatedly run the full suite after every line
change. One final validation run can cover the final diff when the operation
profile allows it.

Still run required checks before claiming completion.

## Full Validation Remains Mandatory When

- Any protected artifact changes.
- Any new Markdown artifact is added.
- Public setup or release claims change.
- Registry, traceability, state, handoff, worklog, or test results change.
- A validation script, red-check script, hook, or workflow changes.
- The user asks for validation.

## Prevent Token Saving From Becoming A Safety Bypass

- Token efficiency never changes source-of-truth hierarchy.
- Agents must not skip required files because they are long.
- Agents must not treat chat summaries as authoritative.
- Agents must record skipped reads when they matter.
- Agents must escalate when uncertainty remains.
- Review and validation requirements come from `OPERATION_ROUTING.md`, not from
  convenience.
