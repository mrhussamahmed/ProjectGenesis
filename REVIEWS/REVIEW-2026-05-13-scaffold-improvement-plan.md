artifact_id: ART-REVIEW-SCAFFOLD-PLAN-001
title: Scaffold Improvement Plan Adversarial Review
type: pr-review
status: active
version: v1.0
created: 2026-05-13
updated: 2026-05-13
owner: AI Bootstrap Maintainers
source: User-supplied scaffold improvement plan in current session
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Scaffold Improvement Plan Adversarial Review

## Review Decision

request changes

The plan is directionally strong as discovery input, but it is not ready for
implementation. It changes core source-of-truth rules, repository layout,
templates, validation, branch policy, agent roles, and handoff behavior. Treat
it as a high-risk governance refactor until it is converted into an approved
scaffold-improvement spec with acceptance criteria and staged backlog items.

## Risk Level

high

## Model Or Effort Level Used Or Recommended

adversarial deep

## Reviewer

- Agent: Codex
- Role: Adversarial PR Reviewer
- Date: 2026-05-13

## Inputs Reviewed

- Review package: none; user supplied a pre-implementation plan in the current
  session.
- PR diff or local diff: none for the proposed improvement plan.
- Specs: `SPECS/SPEC_INDEX.md`; no active scaffold-improvement spec exists.
- Backlog items or tickets: `BACKLOG.md`; no backlog item exists for this
  specific improvement.
- ADRs: `ADR/ADR_INDEX.md`, `DECISIONS.md`, and
  `ADR/templates/ADR_TEMPLATE.md`.
- Tests: `TEST_RESULTS.md` and `SCRIPTS/validate-bootstrap.sh`.
- Traceability: `TRACEABILITY_MATRIX.md`.
- Artifact registry: `ARTIFACT_REGISTRY.md`.
- Current state and handoff: `CURRENT_STATE.md`, `AI_HANDOFF.md`.
- Branch and governance: `BRANCH_AND_WORKTREE_GUIDE.md`,
  `GOVERNANCE.md`, `AI_PROJECT_BOOTSTRAP.md`, `CONTEXT_INDEX.md`,
  `PR_REVIEW_POLICY.md`, `PR_MERGE_POLICY.md`, and `RISK_MODEL.md`.

## Findings

| Severity | Evidence | Finding | Required Change |
|----------|----------|---------|-----------------|
| P1 | `AI_PROJECT_BOOTSTRAP.md` requires approved or active specs before implementation; `SPECS/SPEC_INDEX.md` has no spec for this change. | The plan is implementation-scale but still exists only as current-session text. Implementing from it would bypass the repository source-of-truth hierarchy. | Create a formal scaffold-improvement spec first, with requirement IDs, acceptance criteria, risk classification, test expectations, and staged backlog items. Keep the pasted plan as source input, not authoritative truth. |
| P1 | `CONTEXT_INDEX.md` points product intake to `INPUT/`; `ARTIFACT_REGISTRY.md` registers `INPUT/.gitkeep`; the plan adds `00_intake/raw/`. | The new intake model duplicates the existing input channel without migration or supersession rules. Agents could disagree about where raw input lives. | Decide whether `INPUT/` is superseded, retained as an alias, or migrated into `00_intake/raw/`. Update `CONTEXT_INDEX.md`, `BOOTSTRAP_USAGE.md`, `ARTIFACT_REGISTRY.md`, `TRACEABILITY_MATRIX.md`, and `STALE_ITEMS.md` consistently. |
| P1 | `CONTEXT_INDEX.md` defines minimum context before work; `memory/ai/SHARED_AGENT_RULES.md` and role files require specific reads. | Context packs that say files are "not to scan unless needed" can accidentally override mandatory reading and role rules. | State that context packs are subordinate to `CONTEXT_INDEX.md`, shared agent rules, and selected role files. Each pack should include required-read invariants and cannot waive role-specific required context. |
| P1 | `BRANCH_AND_WORKTREE_GUIDE.md` says never work directly on `main` unless explicitly allowed; the plan proposes small documentation changes directly on `main`. | The proposed main-branch exception conflicts with current branch policy and is undefined enough to be abused for governance/template changes. | Define the exception before use: allowed file classes, maximum risk level, forbidden areas, required validation, review threshold, and whether governance/template/validator changes are excluded. |
| P1 | `DECISIONS.md` requires ADRs for architecture-sensitive work and every ADR must include options considered; the plan says architecture options are required only for high-impact decisions. | The "high-impact" threshold could weaken ADR quality for expensive-to-change decisions that are not obviously high impact. | Add a decision-impact rubric to `RISK_MODEL.md` or `DECISIONS.md`, and keep options/tradeoff evidence mandatory for irreversible, external, security, deployment, API, persistence, or dependency decisions. |
| P1 | `PR_REVIEW_POLICY.md` blocks missing traceability for important requirements; the plan adds requirement confidence and assumptions but does not define "important" or "approved assumption." | Evidence rules are conceptually right but not enforceable as written. | Define requirement importance, evidence strength, confidence levels, source freshness, assumption approval authority, expiry dates, and status transitions in machine-checkable terms. |
| P2 | `SCRIPTS/validate-bootstrap.sh` already checks required files, metadata, registry references, and unresolved placeholders. | The validation phase lists useful checks but not how Markdown tables, evidence fields, stale handoff, or branch contradictions will be parsed reliably. | Specify validator behavior before implementation: exact files checked, field names, allowed empty values by status, false-positive escape hatches, and local hook or CI coverage. |
| P2 | `ARTIFACT_REGISTRY.md` requires meaningful artifacts to be registered; the plan adds many files and directories. | The plan does not explicitly require metadata and registry entries for every new Markdown artifact and directory placeholder. | Add an artifact inventory table to the spec covering every new file, directory placeholder, lifecycle status, owner, and registry row. |
| P2 | `AI_PROJECT_BOOTSTRAP.md` and `GOVERNANCE.md` make repository files source of truth; command prompts are proposed under `COMMANDS/`. | Reusable command prompts can become shadow governance if they do not declare authority, required reads, outputs, and stop conditions. | Create a command prompt template and command index with metadata, role selection, required inputs, expected outputs, validation, and explicit source-of-truth limits. |
| P2 | `BACKLOG.md` says Linear items are drafts until tickets are confirmed by integration. | The plan adds GitHub Issues and says external tickets are required once available, but "available" and ticket evidence are not defined. | Add a ticket integration rule for both Linear and GitHub Issues: how availability is detected, what confirmation is acceptable, and how Markdown remains authoritative until confirmed. |
| P2 | `start here/Project starting instruction tips.rtf` and `start here/new project initialization prompt.rtf` exist but are outside the registry. | The cleanup phase should not simply replace these files without preserving content, source links, and lifecycle status. | Convert or archive the RTF content through a documented migration, then register replacements and mark legacy files superseded or archived. |

## Required Changes

- Write a formal scaffold-improvement spec before implementation.
- Split implementation into small reviewable slices instead of one broad PR.
- Define migration rules for `INPUT/`, `00_intake/`, and the new numbered
  context directories.
- Make requirement evidence, assumption expiry, and source freshness
  enforceable.
- Clarify context-pack authority so packs cannot bypass mandatory role or
  repository context.
- Define the main-branch documentation exception before any agent relies on it.
- Add a command prompt template before adding many command files.
- Extend validator checks with precise parsing rules and expected failure
  examples.

## Optional Improvements

- Add a `SPECS/SPEC-BOOT-001-intake-requirements-governance.md` style spec ID
  for the scaffold improvement instead of treating it as a product spec.
- Use a staged backlog sequence:
  1. spec and taxonomy only
  2. intake and requirement artifacts
  3. template and traceability updates
  4. validator and hook checks
  5. context packs and command prompts
  6. onboarding cleanup
- Add red-check examples before validator implementation so agents prove each
  new validator rule fails before it passes.
- Add a short "agent correction" section to the spec telling future agents not
  to implement from current-session chat and not to skip mandatory context via
  context packs.

## Evidence For Major Findings

- `bash SCRIPTS/validate-bootstrap.sh` passed before review-state edits on
  2026-05-13.
- `git status --short --branch` showed a clean `main` branch before the review
  branch was created.
- Existing policies require spec readiness, traceability, artifact lifecycle
  updates, fresh review, and handoff updates for meaningful work.

## Final Recommendation

Do not implement the plan directly. Convert it into a formal
scaffold-improvement spec, then review that spec before changing templates,
validators, branch rules, or agent roles.

## Re-Review Conditions

Re-review after the formal spec exists and includes acceptance criteria,
artifact inventory, migration rules, validator requirements, risk
classification, branch strategy, and staged backlog items.
