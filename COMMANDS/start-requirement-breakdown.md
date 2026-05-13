artifact_id: ART-COMMAND-START-REQUIREMENT-BREAKDOWN
title: Start Requirement Breakdown
type: command
status: active
version: v1.1
created: 2026-05-13
updated: 2026-05-14
owner: AI Bootstrap Maintainers
source: User request on 2026-05-13, SPEC-BOOT-002 command framework, and SPEC-BOOT-003 routing
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
plans, traceability, and a readiness classification.

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

- `AGENTS.md` or `CLAUDE.md`, depending on the active agent
- `memory/ai/SHARED_AGENT_RULES.md`
- selected role file
- `AI_PROJECT_BOOTSTRAP.md`
- `CONTEXT_INDEX.md`
- `OPERATION_ROUTING.md`
- `BOOTSTRAP_USAGE.md`
- `CURRENT_STATE.md`
- `AI_HANDOFF.md`
- `ARTIFACT_REGISTRY.md`
- `TRACEABILITY_MATRIX.md`
- `GOVERNANCE.md`
- `BRANCH_AND_WORKTREE_GUIDE.md`
- `PROJECT_MEMORY.md`
- `OPEN_QUESTIONS.md`
- `STALE_ITEMS.md`
- `00_intake/INTAKE_INDEX.md`
- `00_intake/SOURCE_REGISTRY.md`
- `CONTEXT_PACKS/product-intake.md`
- `SPECS/SPEC_INDEX.md`
- `SPECS/templates/SPEC_TEMPLATE.md`
- `BACKLOG.md`
- `BACKLOG/BACKLOG_INDEX.md`
- `BACKLOG/templates/BACKLOG_ITEM_TEMPLATE.md`
- `ARCHITECTURE.md`
- `DECISIONS.md`
- `ADR/ADR_INDEX.md`
- `TEST_STRATEGY.md`
- `TEST_PLAN.md`
- `TESTS/ACCEPTANCE_CRITERIA_MAP.md`
- `TESTS/MANUAL_TEST_CHECKLIST.md`
- `TEST_RESULTS.md`
- `PR_REVIEW_POLICY.md`
- `REVIEWS/REVIEW_INDEX.md`

Also inspect:

- `git status --short --branch`
- non-placeholder files under `00_intake/raw/`
- existing summaries under `00_intake/summaries/`
- `INPUT/README.md`
- files under `INPUT/` only when present, treating `INPUT/` as a legacy alias

## Inputs

- The user command, usually `Start requirement breakdown`.
- Raw downstream project materials under `00_intake/raw/`.
- Optional compatibility input under `INPUT/`.
- Existing source, requirement, backlog, spec, architecture, test, and review
  artifacts in the repository.

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
- If the branch changes, immediately update `CURRENT_STATE.md` and
  `AI_HANDOFF.md` with the active branch and worktree before running validation.
- If the worktree is dirty, inspect changes and preserve unrelated user or agent
  work. Do not overwrite unrelated dirty files.
- If `00_intake/raw/` has no non-placeholder files, stop, classify the state as
  `intake-incomplete`, and ask for source material.
- Use only scaffold-supported paths and statuses unless a separate approved
  scaffold-change spec changes them.

### 2. Register Intake Sources

- Read every non-placeholder file in `00_intake/raw/`.
- If files exist under `INPUT/`, treat `INPUT/` as a legacy alias and register
  those files through `00_intake/SOURCE_REGISTRY.md`.
- Assign stable source IDs using `SRC-001`, `SRC-002`, and so on.
- Update `00_intake/SOURCE_REGISTRY.md` with source ID, file path, type, owner,
  added date, freshness, processing state, sensitivity, summary link, and notes.
- Use only allowed freshness values: `active`, `stale`, `superseded`,
  `archived`, `ignored`, `conflicting`.
- Use only allowed processing states: `pending`, `summarized`, `extracted`,
  `blocked`, `ignored`.
- Put details like duplicate, unreadable, partial, or unclear in notes,
  `OPEN_QUESTIONS.md`, or `STALE_ITEMS.md`.

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

Create or update:

- `01_context/PROJECT_BRIEF.md`
- `01_context/PROJECT_CHARTER.md`
- `01_context/GLOSSARY.md`
- `01_context/CONSTRAINTS.md`
- `PROJECT_MEMORY.md` as a concise durable summary only
- `OPEN_QUESTIONS.md`

Produce product description, value proposition, target users, user problems,
jobs-to-be-done, primary workflows, business context, success metrics, MVP
boundary, non-goals, constraints, dependencies, risks, and open questions.

Use only these product fact labels where applicable:

- `confirmed`
- `inferred`
- `assumption`

If something is a possible direction but not decided, record it as an option in
notes or open questions, not as a confirmed requirement.

### 5. Extract Requirements

Create or update:

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

### 6. Build Draft Backlog Candidates

Create or update backlog candidates without starting implementation.

Use:

- `BACKLOG.md`
- `BACKLOG/BACKLOG_INDEX.md`
- `BACKLOG/templates/BACKLOG_ITEM_TEMPLATE.md`
- detailed files under `BACKLOG/` only when useful

Generate candidate epics, features, user stories, spikes, validation tasks,
architecture decision tasks, and research tasks.

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

### 7. Draft Specs Only When Appropriate

If requirements are clear enough, create draft specs using
`SPECS/templates/SPEC_TEMPLATE.md`.

Rules:

- Draft specs are allowed.
- Do not mark specs approved or active unless readiness criteria are satisfied
  and approval evidence exists.
- Do not use draft specs to authorize implementation.
- If requirements are too uncertain, create open questions, spikes, or discovery
  backlog items instead.

### 8. Architecture And ADR Readiness

If architecture implications appear:

- Read `ARCHITECTURE.md`, `DECISIONS.md`, `ADR/ADR_INDEX.md`, and
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

### 9. QA And Validation Planning

Review requirements, stories, and specs for testability.

Update where useful:

- `TEST_STRATEGY.md`
- `TEST_PLAN.md`
- `TESTS/ACCEPTANCE_CRITERIA_MAP.md`
- `TESTS/MANUAL_TEST_CHECKLIST.md`

For each meaningful requirement or story, identify acceptance criteria, expected
test type, manual validation if automation is not practical, edge cases, and
missing testability details.

### 10. Traceability

Update `TRACEABILITY_MATRIX.md` to map source files, source IDs, summaries,
requirements, assumptions, risks, open questions, specs, backlog candidates,
acceptance criteria, validation needs, and review findings.

No important claim should be untraceable.

### 11. Review

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

When a durable final review is performed, create or update:

- `REVIEWS/REVIEW-<date>-product-intake-readiness.md`
- `REVIEWS/REVIEW_INDEX.md`
- `ARTIFACT_REGISTRY.md`
- `TRACEABILITY_MATRIX.md`

### 12. Readiness Classification

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

### 13. Validation And State Updates

Before stopping, update:

- `CURRENT_STATE.md`
- `AI_HANDOFF.md`
- `ARTIFACT_REGISTRY.md`
- `TRACEABILITY_MATRIX.md`
- `TEST_RESULTS.md`
- `WORKLOG/WORKLOG_INDEX.md`
- `OPEN_QUESTIONS.md`
- `STALE_ITEMS.md` if needed
- `REVIEWS/REVIEW_INDEX.md` if review records were created
- `SPECS/SPEC_INDEX.md` if specs were created or changed
- `BACKLOG.md` and `BACKLOG/BACKLOG_INDEX.md` if backlog changed
- `00_intake/INTAKE_INDEX.md`
- `00_intake/SOURCE_REGISTRY.md`

Run:

- `bash SCRIPTS/validate-bootstrap.sh`
- `git diff --check`

If relevant and safe, also run:

- `bash SCRIPTS/validate-bootstrap-red-checks.sh`

Record passed, failed, and skipped checks honestly in `TEST_RESULTS.md` and
`AI_HANDOFF.md`.

## Outputs

- Registered source IDs and updated intake index.
- Source summaries.
- Product context updates.
- Controlled requirements, assumptions, risks, and open questions.
- Backlog candidates and draft specs when appropriate.
- Architecture or ADR candidates when appropriate.
- QA/testability findings.
- Traceability updates.
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
