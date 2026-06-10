artifact_id: ART-COMMAND-START-REQUIREMENT-BREAKDOWN
title: Start Requirement Breakdown
type: command
status: active
version: v2.0
created: 2026-05-13
updated: 2026-06-10
owner: AI Bootstrap Maintainers
source: User request on 2026-05-13, SPEC-BOOT-002 command framework, SPEC-BOOT-003 routing, and GEN-01 tiered read/write contract
linked_specs: [SPEC-BOOT-002, SPEC-BOOT-003]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Start Requirement Breakdown

## Purpose

Run the downstream project intake workflow from rough material in
`00_intake/raw/`. This command turns rough ideas into registered sources,
source summaries, product context, controlled requirements, assumptions, risks,
open questions, backlog candidates, draft specs where appropriate, validation
expectations, traceability, and a readiness classification.

Recognized user triggers:

- `Start requirement breakdown`
- `Start requirement breakdown.`
- `Run requirement breakdown`
- `Run project intake`
- `Kick off project intake`

This command does not authorize product implementation.

## Required Role

Primary role:

- `memory/ai/ROLE_PRODUCT_ANALYST.md`

Read additional role files only when the work reaches that role's scope:

- `memory/ai/ROLE_SPEC_AUTHOR.md` for draft specs
- `memory/ai/ROLE_BACKLOG_PLANNER.md` for backlog candidates
- `memory/ai/ROLE_ARCHITECT.md` for architecture options or ADR candidates
- `memory/ai/ROLE_QA_REVIEWER.md` for acceptance criteria and testability review
- `memory/ai/ROLE_ADVERSARIAL_PR_REVIEWER.md` for fresh-context review

## Required Files To Read

Always read:

- `memory/ai/SHARED_AGENT_RULES.md`
- `memory/ai/ROLE_PRODUCT_ANALYST.md`
- `CONTEXT_INDEX.md`
- `CONTEXT_PACKS/product-intake.md`
- `00_intake/INTAKE_INDEX.md`
- `00_intake/SOURCE_REGISTRY.md`
- `01_context/PROJECT_BRIEF.md`
- `02_requirements/REQUIREMENTS_INDEX.md`
- `02_requirements/ASSUMPTIONS_REGISTER.md`
- `OPEN_QUESTIONS.md`
- `CURRENT_STATE.md`

Also inspect:

- `git status --short --branch`
- non-placeholder files under `00_intake/raw/`
- existing summaries under `00_intake/summaries/`

Every other artifact is read on demand at the workflow step that needs it; the
steps below name their own reads. Escalate further only per
`OPERATION_ROUTING.md` read tiers.

## Inputs

- The user command, usually `Start requirement breakdown`.
- Raw downstream project materials under `00_intake/raw/`.
- Existing source, requirement, backlog, spec, architecture, test, and review
  artifacts in the repository, opened on demand.

## Workflow

### 1. Preflight

- Do not start product implementation.
- Treat repository files as source of truth and chat history as
  non-authoritative context.
- Run `git status --short --branch`.
- Classify the operation using `OPERATION_ROUTING.md` before source-of-truth
  edits. Intake normally starts as `planning-governance`; escalate to
  `strict-protected` if the command changes validators, roles, context-pack
  authority, command-framework rules, CI, hooks, security, release, review
  policy, or source-of-truth hierarchy.
- If on `main`, create or switch to a task branch before source-of-truth edits
  unless the user explicitly authorizes direct-main work.
- If the worktree is dirty, inspect changes and preserve unrelated user or agent
  work. Do not overwrite unrelated dirty files.
- If `00_intake/raw/` has no non-placeholder files, stop, classify the state as
  `intake-incomplete`, and ask for source material.
- Use only scaffold-supported paths and statuses unless a separate approved
  scaffold-change spec changes them.

### 2. Register Intake Sources

- Read every non-placeholder file in `00_intake/raw/`.
- Assign stable source IDs using `SRC-001`, `SRC-002`, and so on.
- Update `00_intake/SOURCE_REGISTRY.md` with source ID, file path, type, owner,
  added date, freshness, processing state, sensitivity, summary link, and notes.
- Use only allowed freshness values: `active`, `stale`, `superseded`,
  `archived`, `ignored`, `conflicting`.
- Use only allowed processing states: `pending`, `summarized`, `extracted`,
  `blocked`, `ignored`.
- Put details like duplicate, unreadable, partial, or unclear in notes,
  `OPEN_QUESTIONS.md`, or `STALE_ITEMS.md` (read on demand).

Sensitive-source rule:

- If a source contains secrets, credentials, PII, private customer data, or
  sensitive business material, register only minimal metadata, avoid detailed
  summaries, record a privacy or security risk, and ask for handling guidance
  when needed.

### 3. Summarize Sources

- Create or update summaries in `00_intake/summaries/`.
- Keep summaries factual and source-linked.
- Do not treat rough ideas as confirmed requirements.
- Record source conflicts in `OPEN_QUESTIONS.md` or `STALE_ITEMS.md` when they
  affect scope, security, architecture, data model, release safety, or priority.
- Update `00_intake/INTAKE_INDEX.md`.

### 4. Expand Product Understanding

Use rough input as seed material and enhance it into product context, while
labeling every material claim.

Create or update (read on demand at this step):

- `01_context/PROJECT_BRIEF.md`
- `01_context/PROJECT_CHARTER.md`
- `01_context/GLOSSARY.md`
- `01_context/CONSTRAINTS.md`
- `OPEN_QUESTIONS.md`

Produce product description, value proposition, target users, user problems,
jobs-to-be-done, primary workflows, business context, success metrics, MVP
boundary, non-goals, constraints, dependencies, risks, and open questions.

Fill the Value Proposition in `01_context/PROJECT_BRIEF.md` using the
problem/alternatives/differentiation method: state the user problem, the
existing alternatives, and what makes this product different. List the
Riskiest Assumptions that would invalidate the idea if wrong.

Use only these product fact labels where applicable:

- `confirmed`
- `inferred`
- `assumption`

If something is a possible direction but not decided, record it as an option in
notes or open questions, not as a confirmed requirement.

### 5. Idea Validation (Conditional)

Run this step only when high-risk or scope-defining assumptions block
readiness, or when the user asks for idea validation.

- For each such assumption, run agent web research where tools allow.
- Write one research note per assumption using
  `00_intake/research/RESEARCH_NOTE_TEMPLATE.md`.
- Register each research note as a `SRC-` source in
  `00_intake/SOURCE_REGISTRY.md`.
- Adjust the assumption's confidence and status in
  `02_requirements/ASSUMPTIONS_REGISTER.md` from the evidence.
- If research tools are unavailable, record that on the assumption and
  continue; do not invent evidence.

### 6. Extract Requirements

Create or update (read `02_requirements/RISK_REGISTER.md` on demand):

- `02_requirements/REQUIREMENTS_INDEX.md`
- `02_requirements/ASSUMPTIONS_REGISTER.md`
- `02_requirements/RISK_REGISTER.md`

For each requirement, include stable requirement ID, statement, type, priority,
source IDs or approved assumption link, confidence, status, linked specs, linked
backlog, and notes.

Use only allowed requirement statuses:

- `confirmed`
- `inferred`
- `assumption`
- `needs-clarification`
- `rejected`
- `superseded`

Use only allowed confidence levels:

- `high`
- `medium`
- `low`

Rules:

- Important requirements need source evidence or an approved assumption before
  they can enter approved specs.
- Low-confidence important requirements cannot authorize implementation.
- Missing information that changes scope, security, architecture, data model,
  release safety, or priority must become an open question.
- Agents may propose assumptions but must not approve their own assumptions.

### 7. Build Draft Backlog Candidates

Create or update backlog candidates without starting implementation.

Read on demand at this step: `BACKLOG/BACKLOG_INDEX.md` and
`BACKLOG/templates/BACKLOG_ITEM_TEMPLATE.md`; create detailed files under
`BACKLOG/` only when useful.

Generate candidate epics, features, user stories, spikes, architecture
decision tasks, and research tasks.

Granularity rules:

1. Tests and validation expectations live inside the story (Test Expectations
   + Definition of Done), never as sibling tickets.
2. At most one validation ticket per slice or spec, scoped to cross-story
   integration validation no single story owns.
3. Re-running checks after a change is evidence in the PR body or
   TEST_RESULTS.md baseline, never a new ticket.
4. Before creating any candidate, search the backlog index for an existing
   item covering the same requirement and extend it instead of duplicating.

Every backlog candidate must include ID, title, purpose, value, linked
requirements, source IDs, approved assumptions if any, open questions,
dependencies, risks, priority, readiness status, readiness evidence, test
expectations, definition of done, implementation blockers, and whether it should
become an external ticket later.

Backlog rules:

- Every backlog item must link to a spec or explicitly be a discovery task that
  creates one.
- Do not claim Linear, GitHub Issues, or external tickets exist unless tool or
  command evidence confirms them.
- Markdown remains authoritative until external ticket existence is confirmed.

### 8. Draft Specs Only When Appropriate

If requirements are clear enough, create draft specs. Read on demand:
`SPECS/SPEC_INDEX.md` and `SPECS/templates/SPEC_TEMPLATE.md`.

Rules:

- Draft specs are allowed.
- Do not mark specs approved or active unless readiness criteria are satisfied
  and approval evidence exists.
- Do not use draft specs to authorize implementation.
- If requirements are too uncertain, create open questions, spikes, or discovery
  backlog items instead.

### 9. Architecture And ADR Readiness

If architecture implications appear:

- Read on demand: `ARCHITECTURE.md`, `DECISIONS.md`, `ADR/ADR_INDEX.md`, and
  `ADR/templates/ADR_TEMPLATE.md`.
- Identify architecture concerns.
- List options and trade-offs.
- Identify ADR candidates.
- Do not invent final architecture.
- High-impact decisions require an ADR or explicit user or maintainer approval
  before implementation.

High-impact decisions include irreversible choices, external integrations,
security or privacy decisions, deployment choices, API boundaries,
persistence/data model choices, major dependencies, and expensive-to-change
architecture.

When the project classifies spec-draft-ready or beyond, continue with
'Start architecture design' (COMMANDS/start-architecture-design.md).

### 10. QA And Validation Planning

Review requirements, stories, and specs for testability.

- Write validation expectations into each story's Test Expectations and
  Definition of Done, not into separate validation tickets.
- Create at most one cross-story validation item per slice or spec, scoped to
  integration validation no single story owns.
- Read on demand: `TEST_STRATEGY.md`, `TEST_PLAN.md`,
  `TESTS/ACCEPTANCE_CRITERIA_MAP.md`, `TESTS/MANUAL_TEST_CHECKLIST.md`; update
  them only when the validation approach itself changed.

For each meaningful requirement or story, identify acceptance criteria, expected
test type, manual validation if automation is not practical, edge cases, and
missing testability details.

### 11. Traceability

Update `TRACEABILITY_MATRIX.md` (read on demand) when new source-to-requirement
or requirement-to-spec mappings were created this run.

No important claim should be untraceable.

### 12. Review

Use independent read-only reviewers where supported and authorized. Reviewers
must read repository source-of-truth files directly and must not rely on chat
history.

Recommended review scopes:

- Product interpretation
- Backlog quality and sequencing
- Acceptance criteria and testability
- Architecture risks and ADR candidates
- Fresh-context adversarial review of the intake package

If subagents or external reviewers are unavailable, perform a single-agent
fresh-context review checklist and record why independent review was skipped.
Writing subagents require an approved parallel plan, disjoint file ownership,
separate worktrees, and clear merge order.

When a durable final review is performed, create or update
`REVIEWS/REVIEW-<date>-product-intake-readiness.md` and
`REVIEWS/REVIEW_INDEX.md` (read on demand).

### 13. Readiness Classification

Classify the project as exactly one of:

- `intake-incomplete`
- `discovery-ready`
- `spec-draft-ready`
- `backlog-draft-ready`
- `implementation-blocked`
- `implementation-ready`

Do not classify as `implementation-ready` unless critical requirements are
clear, important requirements have source evidence or approved assumptions,
acceptance criteria exist, assumptions are approved or non-blocking, high-impact
architecture decisions are approved or explicitly deferred, dependencies are
known or documented, test expectations are defined, traceability is updated,
validation passes, fresh-context review has no unresolved blocking findings, and
branch/worktree strategy is clear.

If those conditions are not met, state the next safest action.

### 14. Validation And State Updates

Before stopping, update only the artifacts this run actually changed, plus
`.ai/SESSION.md` when unmerged local work remains. Do not touch state or index
files whose content did not change.

Record one validation-evidence note per PR (in the PR body or review package).
Update TEST_RESULTS.md, TRACEABILITY_MATRIX.md, and ARTIFACT_REGISTRY.md only
when a durable baseline, requirement mapping, or artifact lifecycle changed -
at most once per PR, not per session.

Run:

- `bash SCRIPTS/validate-bootstrap.sh` (or the session-scoped profile from
  `SCRIPTS/session.sh`)
- `git diff --check`

Record passed, failed, and skipped checks honestly in the evidence note.

## Outputs

- Registered source IDs and updated intake index.
- Source summaries.
- Product context updates, including value proposition and riskiest
  assumptions.
- Research notes for validated high-risk assumptions, when step 5 ran.
- Controlled requirements, assumptions, risks, and open questions.
- Backlog candidates and draft specs when appropriate.
- Architecture or ADR candidates when appropriate.
- QA/testability findings inside the affected stories.
- Traceability updates when mappings changed.
- Review findings.
- Validation evidence.
- Readiness classification and next safest action.

Final response must summarize branch/worktree status, dirty files found before
work and how they were handled, source files read, source IDs created or updated,
summaries created, product interpretation, product artifacts updated,
requirements count by status, assumptions and risks, open questions, backlog
candidates, draft specs, architecture or ADR candidates, QA/testability findings,
review findings, validation results, readiness classification, and next safest
action.

## Stop Conditions

- `00_intake/raw/` has no non-placeholder source files.
- Source material is unreadable or too sensitive to summarize safely.
- Authoritative sources conflict in a way that changes scope, security,
  architecture, data model, release safety, or priority.
- Critical requirements are missing or low-confidence.
- An implementation request appears before Definition of Ready is satisfied.
- Architecture decisions require an ADR or explicit approval.
- Dirty worktree changes block safe editing.
- The command trigger or required inputs are ambiguous.

## Validation

- `bash SCRIPTS/validate-bootstrap.sh`
- `git diff --check`
- `bash SCRIPTS/validate-bootstrap-red-checks.sh` when relevant and safe
- Task-specific checks from active specs, backlog items, or selected technology
  stack when a downstream project defines them

## Authority Limit

This command is a workflow shortcut. It cannot override repository governance,
approved or active specs, accepted ADRs, `CONTEXT_INDEX.md`, selected role
files, `ARTIFACT_REGISTRY.md`, `TRACEABILITY_MATRIX.md`, `CURRENT_STATE.md`,
`AI_HANDOFF.md`, `BRANCH_AND_WORKTREE_GUIDE.md`, `PR_REVIEW_POLICY.md`, or
runtime/tool policies for subagents, worktrees, external systems, or
implementation.
