artifact_id: ART-SPEC-BOOT-002
title: Scaffold Intake And Governance Improvement
type: spec
status: active
version: v1.2
created: 2026-05-13
updated: 2026-05-13
owner: AI Bootstrap Maintainers
source: User adjusted plan and adversarial reviews on 2026-05-13
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# SPEC-BOOT-002: Scaffold Intake And Governance Improvement

## Metadata

- Spec ID: SPEC-BOOT-002
- Status: active
- Version: v1.2
- Owner or responsible agent: AI Bootstrap Maintainers
- Created: 2026-05-13
- Last updated: 2026-05-13
- Source input:
  - User brainstorming plan for scaffold improvement, 2026-05-13.
  - `REVIEWS/REVIEW-2026-05-13-scaffold-improvement-plan.md`.
  - User adjusted plan, 2026-05-13.
  - Independent review of `SPEC-BOOT-002` v0.2, 2026-05-13.
  - Second independent readiness review of `SPEC-BOOT-002` v0.2, 2026-05-13.
- Related product requirement: bootstrap scaffold improvement only
- Related backlog item: staged backlog plan defined in this spec
- Related Linear ticket: none
- Related architecture decision: none yet
- Related code areas: Markdown governance, templates, validator script, hooks,
  context guides, command prompts, intake directories, and onboarding docs

## Status And Authority

This spec is active after fresh-context review. It authorizes implementation of
the staged backlog items BOOT-010 through BOOT-015 while preserving the slice
order, validation requirements, traceability updates, and review gates defined
below.

The current-session plan text is source input, not durable project truth. This
spec becomes the repository artifact that converts the discussion into
reviewable requirements.

## Goal

Improve the reusable bootstrap scaffold so rough project input can become
registered sources, product context, controlled requirements, evidence-linked
specs, staged backlog items, reviewable implementation slices, and validated
handoff state without relying on repeated prompting or invented assumptions.

## Non-Goals

- Do not implement product-specific features.
- Do not add a CLI, generator, package manager integration, or external ticket
  sync in this improvement.
- Do not remove existing source-of-truth rules.
- Do not make context packs authoritative above `CONTEXT_INDEX.md`,
  `memory/ai/SHARED_AGENT_RULES.md`, selected role files, approved specs,
  ADRs, registry, traceability, current state, or handoff.
- Do not delete or overwrite the RTF onboarding files without a recorded
  migration and lifecycle update.

## Terminology

| Term | Definition |
|------|------------|
| Important requirement | Any P0 or P1 requirement, user-facing behavior, security, privacy, data, architecture, integration, release, dependency, or implementation-readiness requirement. |
| Source evidence | A linked source ID, explicit user instruction, approved spec, accepted ADR, backlog item, confirmed external ticket, or explicitly approved assumption. |
| Approved assumption | An assumption recorded in `02_requirements/ASSUMPTIONS_REGISTER.md` with status `approved`, owner, risk, expiry rule, linked requirement or spec, and approval evidence from an allowed approval authority. |
| Confidence | One of `high`, `medium`, or `low`, indicating how strongly the requirement is supported by source evidence. |
| Source freshness | Source lifecycle status: `active`, `stale`, `superseded`, `archived`, `ignored`, or `conflicting`. |
| Blocked until clarified | A requirement or backlog item status used when missing information could change scope, security, architecture, data model, release safety, or implementation priority. |
| Legacy alias | A documented compatibility path that points agents to a new canonical path during migration. |
| High-impact decision | An irreversible, external integration, security, deployment, API, persistence, data, dependency, expensive-to-change, or high-blast-radius decision. |

## Governing Decisions

- `00_intake/raw/` is the canonical raw intake folder.
- `INPUT/` remains as a legacy alias during migration and must point future
  agents to `00_intake/raw/`.
- Markdown remains authoritative until external tickets are confirmed by an
  integration or direct repository evidence.
- Context packs may reduce repeated reading but cannot waive mandatory context
  from `CONTEXT_INDEX.md`, shared agent rules, or selected role files.
- Command prompts are shortcuts and must not become hidden governance.
- Small documentation changes may happen directly on `main` only after the
  narrow exception in this spec is implemented in `BRANCH_AND_WORKTREE_GUIDE.md`
  and `GOVERNANCE.md`.
- Architecture options are required for high-impact decisions as defined in
  this spec.
- Validator improvements must be specified with failure examples before the
  script changes are implemented.
- External tracker references must remain draft-only until ticket availability
  and ticket existence are evidenced under this spec's ticket rules.

## Functional Requirements

| ID | Requirement | Source | Priority | Confidence | Status |
|----|-------------|--------|----------|------------|--------|
| SBG-FR-001 | Create this governing spec before implementing scaffold changes. | User adjusted plan; review finding P1 | P0 | high | implemented |
| SBG-FR-002 | Define `00_intake/raw/` as the canonical raw source folder and keep `INPUT/` as a documented legacy alias during migration. | User adjusted plan; review finding P1 | P0 | high | implemented |
| SBG-FR-003 | Add intake registries that assign stable source IDs such as `SRC-001`, record source metadata, freshness, owner, status, summary, and processing state. | User adjusted plan | P1 | high | implemented |
| SBG-FR-004 | Add product context artifacts for project brief, project charter, glossary, and constraints. | User adjusted plan | P1 | high | implemented |
| SBG-FR-005 | Add requirement, assumption, and risk registers that enforce source evidence, confidence, status, owner, risk, expiry, and linked specs or backlog items. | User adjusted plan; review finding P1 | P1 | high | implemented |
| SBG-FR-006 | Update spec, ADR, and backlog templates so important requirements link to source IDs, requirement IDs, assumptions, open questions, readiness evidence, and test mapping. | User adjusted plan; review finding P2 | P1 | high | implemented |
| SBG-FR-007 | Expand traceability to map source to requirement to spec to acceptance criteria to backlog to code, tests, review, and release evidence. | User adjusted plan | P1 | high | implemented |
| SBG-FR-008 | Add context packs with explicit authority limits subordinate to mandatory context files and role rules. | User adjusted plan; review finding P1 | P1 | high | implemented |
| SBG-FR-009 | Add a command prompt system only after `COMMANDS/COMMAND_INDEX.md` and `COMMANDS/COMMAND_TEMPLATE.md` define purpose, role, required reads, inputs, outputs, stop conditions, validation, and authority limits. | User adjusted plan; review finding P2 | P1 | high | implemented |
| SBG-FR-010 | Define a narrow main-branch documentation exception and keep governance, specs, ADRs, backlog, templates, validator scripts, hooks, role files, source-of-truth files, security, release, and dependency policy changes on branches. | User adjusted plan; review finding P1 | P1 | high | implemented |
| SBG-FR-011 | Define validator behavior and red-check examples before editing `SCRIPTS/validate-bootstrap.sh`. | User adjusted plan; review finding P2 | P1 | high | implemented |
| SBG-FR-012 | Convert useful RTF onboarding content into Markdown replacements and register or archive the legacy RTF files without casual deletion. | User adjusted plan; review finding P2 | P2 | high | implemented |
| SBG-FR-013 | Define external ticket availability and confirmation evidence for Linear, GitHub Issues, and future trackers before requiring ticket creation. | SPEC-BOOT-002 v0.2 review finding P2 | P2 | high | implemented |

## Non-Functional Requirements

| ID | Requirement | Source | Priority | Confidence | Status |
|----|-------------|--------|----------|------------|--------|
| SBG-NFR-001 | The improvement must preserve the existing source-of-truth hierarchy and role system. | `AI_PROJECT_BOOTSTRAP.md`; `memory/ai/SHARED_AGENT_RULES.md` | P0 | high | implemented |
| SBG-NFR-002 | The improvement must remain plain Markdown first. | User adjusted plan | P1 | high | implemented |
| SBG-NFR-003 | The improvement must be implemented in small slices after spec approval. | User adjusted plan; review recommendation | P0 | high | implemented |
| SBG-NFR-004 | Local validation must remain lightweight and suitable for hooks. | `GOVERNANCE.md`; `RISK_MODEL.md` | P1 | high | implemented |
| SBG-NFR-005 | The implementation must avoid shadow governance by ensuring new command prompts and context packs declare authority limits. | Review finding P2 | P1 | high | implemented |
| SBG-NFR-006 | New Markdown artifacts must include metadata and be registered in `ARTIFACT_REGISTRY.md`. | `GOVERNANCE.md`; review finding P2 | P0 | high | implemented |

## Requirement And Assumption Rules

Requirement statuses:

- `confirmed`
- `inferred`
- `assumption`
- `needs-clarification`
- `rejected`
- `superseded`

Important requirements cannot enter approved specs unless they have source
evidence or an approved assumption. Missing information must use
`needs-clarification` or `blocked until clarified` when it could change scope,
security, architecture, data model, release safety, or implementation priority.

Assumption statuses:

- `proposed`
- `approved`
- `rejected`
- `expired`
- `superseded`
- `needs-confirmation`

Agents may propose assumptions but must not approve their own assumptions.
Approval evidence must point to at least one of:

- explicit user approval in the current session, recorded in the relevant
  artifact or handoff
- an approved or active spec
- an accepted ADR
- a maintainer-approved register entry
- verified external evidence recorded in the source registry

High-risk assumptions require explicit user, maintainer, approved-spec, or
accepted-ADR approval. Medium-risk assumptions require review by a role other
than the author before they can be marked approved. Low-risk assumptions may be
approved by a responsible role only when the approval evidence and expiry are
recorded. Expired assumptions revert to `needs-confirmation` before use.

Assumption expiry:

- Low risk assumptions expire after 30 days or before implementation,
  whichever comes first.
- Medium risk assumptions must be reviewed before spec approval.
- High risk assumptions cannot be used for implementation until confirmed.

Confidence:

- `high`: directly supported by explicit source evidence.
- `medium`: inferred from source evidence and reviewed by the responsible role.
- `low`: plausible but weakly supported; cannot authorize implementation of an
  important requirement.

## Intake Migration Rules

- `00_intake/raw/` is the canonical folder for raw dropped files.
- `00_intake/summaries/` stores agent-created summaries of registered sources.
- `00_intake/SOURCE_REGISTRY.md` assigns source IDs and tracks metadata,
  freshness, status, owner, processing state, and summary links.
- `00_intake/INTAKE_INDEX.md` tracks pending, processed, stale, superseded, and
  ignored sources.
- `INPUT/` remains during migration as a legacy alias.
- `INPUT/README.md` or an equivalent registered artifact must direct future
  agents to `00_intake/raw/`.
- Existing references to `INPUT/` must be updated or explicitly documented as
  compatibility references.
- `CONTEXT_INDEX.md` and `BOOTSTRAP_USAGE.md` are in the BOOT-010 migration
  scope because they currently point agents to `INPUT/`.
- Removal or archival of `INPUT/` requires a later reviewed change after no
  active scaffold references depend on it.

## Product Context Requirements

The product understanding slice must add:

- `01_context/PROJECT_BRIEF.md`
- `01_context/PROJECT_CHARTER.md`
- `01_context/GLOSSARY.md`
- `01_context/CONSTRAINTS.md`

Generated product facts must be labeled as one of:

- `confirmed`
- `inferred`
- `assumption`

`PROJECT_MEMORY.md` should remain a concise durable summary and must not become
the detailed source of truth for requirements.

## Requirements Control Requirements

The requirements control slice must add:

- `02_requirements/REQUIREMENTS_INDEX.md`
- `02_requirements/ASSUMPTIONS_REGISTER.md`
- `02_requirements/RISK_REGISTER.md`

Each requirement must include:

- stable requirement ID
- statement
- type
- priority
- source IDs or approved assumption link
- confidence
- status
- linked specs or backlog items when known

Each assumption must include:

- stable assumption ID
- statement
- risk
- expiry rule
- owner
- status
- linked requirement or spec
- approval or review evidence when applicable

## External Ticket Evidence Rules

External trackers are required once available, but Markdown remains
authoritative until ticket existence is confirmed.

Tracker availability means the repository has an installed, usable integration
or CLI for the tracker, the user has authorized its use, and the agent can read
or create tickets with command or tool evidence. Confirmation evidence means a
real ticket ID or URL returned by the integration, a successful CLI/API command
output, or an authoritative repository artifact that records the confirmed
ticket. Draft text, planned titles, or chat claims are not confirmation.

When Linear, GitHub Issues, or a future tracker is unavailable, backlog items
remain Markdown-authoritative and may include tracker-ready draft text. Agents
must not claim tickets exist until confirmation evidence is recorded in the
backlog item, traceability matrix, and handoff.

## Template And Traceability Requirements

Update these workflow policy files and templates only after this spec is
approved:

- `BRANCH_AND_WORKTREE_GUIDE.md`
- `GOVERNANCE.md`
- `SPECS/templates/SPEC_TEMPLATE.md`
- `ADR/templates/ADR_TEMPLATE.md`
- `BACKLOG/templates/BACKLOG_ITEM_TEMPLATE.md`
- `TRACEABILITY_MATRIX.md`

Workflow policy updates must implement the narrow direct-`main` documentation
exception in `BRANCH_AND_WORKTREE_GUIDE.md` and `GOVERNANCE.md` before any
agent relies on that exception.

Template changes must add fields for source IDs, requirement IDs, confidence,
assumption links, open question links, readiness evidence, test mapping, and
blocked-until status where relevant.

ADR changes must preserve strong decision quality. Architecture options are
required for high-impact decisions, including irreversible, external
integration, security, deployment, API, persistence, data, dependency, or
expensive-to-change decisions.

## Context Pack Requirements

Context packs must live under `CONTEXT_PACKS/` and may include:

- `CONTEXT_PACKS/README.md`
- `CONTEXT_PACKS/product-intake.md`
- `CONTEXT_PACKS/spec-authoring.md`
- `CONTEXT_PACKS/architecture.md`
- `CONTEXT_PACKS/implementation.md`
- `CONTEXT_PACKS/review.md`
- `CONTEXT_PACKS/resume.md`

Each context pack must define:

- files to read first
- files to read only if relevant
- files not to scan unless needed
- expected output files
- stop conditions
- authority limit

Authority limit: context packs are subordinate to `CONTEXT_INDEX.md`,
`memory/ai/SHARED_AGENT_RULES.md`, selected role files, approved specs, ADRs,
registry, traceability, current state, and handoff.

## Command Prompt Requirements

Before adding workflow prompts, create:

- `COMMANDS/COMMAND_INDEX.md`
- `COMMANDS/COMMAND_TEMPLATE.md`

Each command prompt must define:

- purpose
- required role
- required files to read
- inputs
- outputs
- stop conditions
- validation
- authority limit

Authority limit: commands are shortcuts for repeatable workflows. They are not
source-of-truth governance and cannot override specs, ADRs, registry,
traceability, current state, handoff, `CONTEXT_INDEX.md`, or role files.

## Main-Branch Documentation Exception

The branch guide may allow direct `main` edits only for low-risk documentation
changes after this rule is implemented.

Allowed on `main`:

- typo fixes
- formatting fixes
- non-authoritative wording improvements
- small README-style documentation fixes

Not allowed on `main`:

- governance changes
- specs
- ADRs
- backlog changes
- templates
- validator scripts
- hooks
- role files
- source-of-truth files
- security policy
- release policy
- dependency policy

All disallowed changes require a branch.

Required checks for eligible direct-`main` documentation edits:

- run `git status --short --branch` before and after the edit
- run `git diff --check`
- run `bash SCRIPTS/validate-bootstrap.sh` when the touched file is registered
  in `ARTIFACT_REGISTRY.md` or referenced by `CONTEXT_INDEX.md`

No fresh adversarial review is required for typo, formatting, or small
non-authoritative wording-only changes on `main`. Any change touching
source-of-truth meaning, governance, templates, validation, review policy,
security, release, dependency policy, roles, specs, ADRs, backlog, registry,
traceability, or handoff requires a branch and the normal review path.

## Validator Requirements

Validator behavior must be defined before `SCRIPTS/validate-bootstrap.sh` is
edited. The validator design must state exact files checked, field names,
allowed empty values by status, false-positive escape hatches, local hook
coverage, and CI coverage.

Validator red-checks must use executable, non-destructive fixtures. The
BOOT-013 implementation should add a helper such as
`SCRIPTS/validate-bootstrap-red-checks.sh` that creates a temporary copy of the
repository under `${TMPDIR:-/tmp}`, injects malformed fixture files into that
temporary copy, runs `bash SCRIPTS/validate-bootstrap.sh`, asserts expected
failure text, and deletes the temporary copy. Invalid fixture files must not be
committed into the live scaffold tree.

Each red-check case must define:

- fixture mutation or generated fixture path in the temporary copy
- command shape
- expected non-zero or failure condition
- expected failure text prefix or stable substring
- cleanup behavior

Required red-check examples:

- approved spec with missing source IDs
- approved spec with empty source IDs
- active backlog item without linked spec or documented discovery exception
- stale handoff branch mismatch
- command prompt missing required reads
- source registry entry without freshness or processing state
- assumption missing expiry
- assumption marked approved without allowed approval evidence
- assumption marked approved with self-approval evidence

Validator implementation must first demonstrate at least one failing example
for each new rule, then demonstrate passing validation after the rule and
fixture are corrected or encoded safely.

## Onboarding And RTF Migration Requirements

The onboarding cleanup slice must not delete `start here/Project starting
instruction tips.rtf` or `start here/new project initialization prompt.rtf`
without preserving useful content.

Required approach:

- Convert useful RTF content into Markdown.
- Add `GETTING_STARTED.md` and/or `NEW_PROJECT_INITIALIZATION.md` when content
  is ready.
- Register replacements in `ARTIFACT_REGISTRY.md`.
- Register the legacy RTF files and mark them superseded or archived, or move
  them into an archive location through a reviewed lifecycle change.

## Staged Backlog Plan

The following staged backlog items are authorized by this spec and mirrored in
`BACKLOG.md`.

| Proposed ID | Title | Purpose | Dependencies | Risk | Review Need |
|-------------|-------|---------|--------------|------|-------------|
| BOOT-009 | Approve scaffold intake and governance spec | Review and approve this governing spec before implementation. | SPEC-BOOT-002 reviewed | high | adversarial review |
| BOOT-010 | Implement intake migration and source registry | Add canonical intake folders and migrate `INPUT/` to a legacy alias. | BOOT-009 | medium | standard |
| BOOT-011 | Implement product context and requirements control | Add product context files and requirement, assumption, and risk registers. | BOOT-010 | high | deep |
| BOOT-012 | Update workflow policy, templates, and traceability | Add the narrow direct-`main` documentation exception plus evidence, assumption, readiness, and test mapping fields. | BOOT-011 | high | deep |
| BOOT-013 | Improve validator with red-check examples | Add enforceable checks after defining failure examples. | BOOT-012 | high | deep |
| BOOT-014 | Add context packs and command prompt framework | Add subordinate context packs and safe command prompt scaffolding after validator rules can check authority limits. | BOOT-013 | medium | standard |
| BOOT-015 | Migrate onboarding RTF files | Convert useful RTF content to Markdown and register legacy lifecycle status. | BOOT-009 | medium | standard |

## Artifact Inventory For Implementation

The implementation spec review confirmed this artifact inventory before files
were created.

| Artifact | Required In Slice | Registry Requirement |
|----------|-------------------|----------------------|
| `00_intake/raw/.gitkeep` | Intake migration | Register directory placeholder |
| `00_intake/summaries/.gitkeep` | Intake migration | Register directory placeholder |
| `00_intake/SOURCE_REGISTRY.md` | Intake migration | Register as active registry |
| `00_intake/INTAKE_INDEX.md` | Intake migration | Register as active index |
| `INPUT/README.md` | Intake migration | Register as legacy alias guide |
| `CONTEXT_INDEX.md` | Intake migration | Update existing registered authoritative guide for intake path migration |
| `BOOTSTRAP_USAGE.md` | Intake migration | Update existing registered authoritative guide for intake path migration |
| `01_context/PROJECT_BRIEF.md` | Product context | Register as active product context |
| `01_context/PROJECT_CHARTER.md` | Product context | Register as active product context |
| `01_context/GLOSSARY.md` | Product context | Register as active glossary |
| `01_context/CONSTRAINTS.md` | Product context | Register as active constraints |
| `02_requirements/REQUIREMENTS_INDEX.md` | Requirements control | Register as active requirements registry |
| `02_requirements/ASSUMPTIONS_REGISTER.md` | Requirements control | Register as active assumptions registry |
| `02_requirements/RISK_REGISTER.md` | Requirements control | Register as active risk registry |
| `BRANCH_AND_WORKTREE_GUIDE.md` | Workflow policy and template updates | Update existing registered authoritative guide |
| `GOVERNANCE.md` | Workflow policy and template updates | Update existing registered authoritative governance |
| `BACKLOG.md` | Workflow policy and template updates | Update existing registered authoritative backlog with ticket evidence guidance |
| `SPECS/templates/SPEC_TEMPLATE.md` | Workflow policy and template updates | Update existing registered template |
| `ADR/templates/ADR_TEMPLATE.md` | Workflow policy and template updates | Update existing registered template |
| `BACKLOG/templates/BACKLOG_ITEM_TEMPLATE.md` | Workflow policy and template updates | Update existing registered template |
| `TRACEABILITY_MATRIX.md` | Workflow policy and template updates | Update existing registered authoritative traceability matrix |
| `SCRIPTS/validate-bootstrap.sh` | Validator red-checks | Update existing registered validator |
| `SCRIPTS/validate-bootstrap-red-checks.sh` | Validator red-checks | Register as active validation helper if created |
| `.githooks/pre-commit` | Validator red-checks | Inspect or update existing registered hook if validator command contract changes |
| `.githooks/pre-push` | Validator red-checks | Inspect or update existing registered hook if validator command contract changes |
| `.github/workflows/bootstrap-validation.yml` | Validator red-checks | Inspect or update existing registered CI template if validator command contract changes |
| `TEST_RESULTS.md` | Validator red-checks | Update existing registered test results after red-check and validation runs |
| `CONTEXT_PACKS/README.md` | Context packs | Register as active guide |
| `CONTEXT_PACKS/*.md` | Context packs | Register each pack or register a controlled pack family |
| `COMMANDS/COMMAND_INDEX.md` | Command prompts | Register as active command index |
| `COMMANDS/COMMAND_TEMPLATE.md` | Command prompts | Register as active template |
| `GETTING_STARTED.md` | Onboarding cleanup | Register as authoritative or active guide |
| `NEW_PROJECT_INITIALIZATION.md` | Onboarding cleanup | Register as authoritative or active guide |

## Acceptance Criteria

| ID | Given | When | Then | Test Mapping |
|----|-------|------|------|--------------|
| SBG-AC-001 | The adjusted plan exists only in chat and review artifacts | A future agent starts work | The agent reads this spec and does not implement from chat text alone | Spec review |
| SBG-AC-002 | `INPUT/` exists and `00_intake/raw/` is proposed | Intake migration is implemented | `00_intake/raw/` is canonical and `INPUT/` is documented as a legacy alias | Validator and manual review |
| SBG-AC-003 | Raw source material is added to the scaffold | Intake processing runs | Each source has a stable `SRC-*` ID, registry row, freshness status, and processing state | Validator and manual review |
| SBG-AC-004 | A source is processed | The product analyst summarizes it | A summary exists and the registry links source to summary | Validator and manual review |
| SBG-AC-005 | A product brief, charter, glossary, or constraint is generated | The source evidence is mixed confirmed and inferred | The artifact labels each material claim as confirmed, inferred, or assumption | Manual review |
| SBG-AC-006 | A requirement is important | A spec moves toward approval | The requirement has source evidence or an approved assumption | Validator and review |
| SBG-AC-007 | A high-risk assumption exists | Implementation is requested | Implementation remains blocked until the assumption is confirmed | Review gate |
| SBG-AC-008 | A command prompt is added | Validation runs | The command declares required role, required reads, inputs, outputs, stop conditions, validation, and authority limit | Validator |
| SBG-AC-009 | A context pack is added | Review checks authority | The pack states it cannot override mandatory context or role files | Validator and review |
| SBG-AC-010 | A branch exception is used | The change is classified | Only allowed low-risk docs changes happen directly on `main`; source-of-truth changes require a branch | Review gate |
| SBG-AC-011 | Validator rules are expanded | A new rule is implemented | A red-check example fails before the passing implementation is accepted | Test results |
| SBG-AC-012 | RTF onboarding content is migrated | Replacement Markdown exists | Useful content is preserved and legacy RTF files are registered as superseded or archived | Manual review and registry check |
| SBG-AC-013 | An assumption is marked approved | Review checks the assumption register | The assumption has an allowed approval authority, approval evidence, risk, owner, expiry, and linked requirement or spec | Validator and review |
| SBG-AC-014 | A backlog item references Linear, GitHub Issues, or another external tracker | The item claims ticket creation | The ticket has confirmation evidence, otherwise the item remains Markdown-authoritative draft text | Review gate |

## Edge Cases

- A source contradicts a newer source: mark the older source `conflicting` or
  `superseded` and record the conflict in the source registry and open
  questions when needed.
- A low-risk assumption reaches implementation after 30 days: treat it as
  expired and review before use.
- A context pack omits a required role file: the role file remains mandatory.
- A command prompt recommends skipping validation: the command is invalid.
- A small documentation edit touches governance wording: it is not eligible for
  direct `main` editing.
- A legacy `INPUT/` reference remains in docs: it must either point to
  `00_intake/raw/` or be documented as compatibility guidance.

## Dependencies

- This spec must be reviewed before implementation.
- `REVIEWS/REVIEW-2026-05-13-scaffold-improvement-plan.md` must remain linked
  as review input.
- Existing bootstrap validation must remain passing after each slice.
- Artifact registry and traceability updates are required for every new
  meaningful artifact.

## Risks

- Governance can become heavy if every simple task requires the full process.
  Mitigation: preserve risk-based review paths and direct `main` exception only
  for narrow low-risk docs changes.
- Context packs can become a shortcut around required reading. Mitigation:
  enforce authority limits in every pack.
- Validator parsing can become brittle. Mitigation: define exact fields,
  statuses, and red-check examples before script edits.
- `INPUT/` migration can create duplicate intake paths. Mitigation: keep
  `INPUT/` as a legacy alias until all references are updated.
- Command prompts can drift into shadow governance. Mitigation: command
  template must declare source-of-truth limits.

## Assumptions

- The bootstrap remains stack-neutral.
- Markdown remains the authoritative storage layer for scaffold governance.
- External ticket systems may be unavailable; Markdown remains authoritative
  until confirmed tickets exist under the ticket evidence rules in this spec.
- The spec review can approve, request changes, or split this spec before
  implementation.

## Open Questions

- No implementation-blocking product questions are open for this active spec.
- Final implementation review is required before merge readiness.

## Test Requirements

- Unit: not applicable for this Markdown-only spec.
- Integration: `bash SCRIPTS/validate-bootstrap.sh` must pass after this spec
  and state updates.
- Contract: future validator changes must include red-check examples listed in
  this spec.
- End-to-end: future implementation review must trace source to requirement to
  spec to backlog to tests and review evidence.
- Manual: spec reviewer must check authority limits, migration behavior,
  evidence rules, and staged implementation boundaries.
- Security: review must confirm security, privacy, data, and release-impacting
  requirements are classified as important requirements.
- Performance: validator additions must remain lightweight enough for local
  hooks.

## Observability Requirements

- Logs: validator output should identify failing file paths and fields.
- Metrics: not required for this scaffold change.
- Tracing: not required for this scaffold change.
- Alerts: not required for this scaffold change.

## Security And Privacy Requirements

- Secrets: no secrets are expected in scaffold documentation.
- Authentication: not applicable.
- Authorization: not applicable.
- Sensitive data: future intake guidance must warn agents not to publish
  sensitive source material into generated summaries without review.
- Logging: validator output must not print sensitive raw source content beyond
  minimal failing context.
- Abuse cases: command prompts must not instruct agents to bypass review,
  evidence, or validation.

## Definition Of Ready

- [x] Acceptance criteria are clear.
- [x] Dependencies are documented.
- [x] Architecture impact is known or explicitly not applicable.
- [x] Test expectations are defined.
- [x] Artifact status is clear.
- [x] Stale or conflicting artifacts were checked.
- [x] Branch and worktree strategy is clear.
- [x] Risk level has been assessed.
- [x] Required reviewers are known.
- [x] Parallelization risk has been assessed.

## Definition Of Done For Spec Approval

This checklist tracks readiness to approve or activate this governing spec. It
does not mean the scaffold improvement implementation is complete.

- [x] This spec has completed fresh-context adversarial review.
- [x] Requested changes from review are resolved or explicitly accepted.
- [x] `SPECS/SPEC_INDEX.md` lists this spec.
- [x] `ARTIFACT_REGISTRY.md` registers this spec.
- [x] `TRACEABILITY_MATRIX.md` maps this spec to scaffold
  requirements.
- [x] `CURRENT_STATE.md` and `AI_HANDOFF.md` are updated.
- [x] `WORKLOG/WORKLOG_INDEX.md` records the session.
- [x] `bash SCRIPTS/validate-bootstrap.sh` passes.
- [x] Implementation remained blocked until the spec became active.

## Implementation Notes

Implementation proceeded after this spec was reviewed and activated. Each
staged backlog item was implemented as a clearly bounded slice on the active
review branch. The validator slice includes non-destructive red-check examples
for the new validation rules.

## Change History

| Version | Date | Change | Author |
|---------|------|--------|--------|
| v1.2 | 2026-05-13 | Addressed final review findings by requiring column-aware source evidence checks, stronger approved-assumption evidence checks, canonical intake role alignment, and explicit authority limits in each context pack. | Codex |
| v1.1 | 2026-05-13 | Aligned active spec status tables, approval DoD, open questions, and implementation notes with completed BOOT-010 through BOOT-015 implementation before final review. | Codex |
| v1.0 | 2026-05-13 | Activated after fresh independent review approved v0.4 with minor comments and mapped acceptance criteria. | Codex |
| v0.4 | 2026-05-13 | Addressed second independent review findings by expanding artifact inventory, defining executable temporary red-check fixture behavior, and clarifying spec-approval DoD. | Codex |
| v0.3 | 2026-05-13 | Addressed independent review findings by defining assumption approval authority, external ticket evidence, direct-main validation checks, intake-reference migration scope, and BOOT-014 dependency on validator work. | Codex |
| v0.2 | 2026-05-13 | Clarified that BOOT-012 includes workflow policy updates for the direct-main documentation exception and added branch/governance files to the implementation artifact inventory. | Codex |
| v0.1 | 2026-05-13 | Initial proposed scaffold-improvement spec from adjusted plan and adversarial review. | Codex |
