artifact_id: ART-SPEC-BOOT-003
title: Adaptive Governance Routing
type: spec
status: approved
version: v1.0
created: 2026-05-13
updated: 2026-05-14
owner: AI Bootstrap Maintainers
source: User request, repository performance analysis, fresh-context adversarial review approval on 2026-05-13, and BOOT-019 through BOOT-024 implementation
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# SPEC-BOOT-003: Adaptive Governance Routing

## Metadata

- Spec ID: SPEC-BOOT-003
- Status: approved
- Version: v1.0
- Owner or responsible agent: AI Bootstrap Maintainers
- Created: 2026-05-13
- Last updated: 2026-05-14
- Source input:
  - User request to reduce ProjectGenesis execution time and token cost without
    weakening governance, safety, traceability, validation, or multi-agent
    handoff.
  - Repository-grounded analysis of ProjectGenesis mechanics on 2026-05-13.
  - User approval of the adaptive governance control-plane recommendation.
  - Repository source-of-truth rules requiring durable evidence, branch
    discipline, fresh-context review, traceability, and handoff continuity.
- Related product requirement: bootstrap governance performance and token
  efficiency
- Related backlog item: BOOT-018 through BOOT-024
- Related Linear ticket: none
- Related architecture decision: none yet
- Related code areas: governance policy, operation routing, artifact impact
  mapping, validation policy, current-state and handoff policy, and future
  validator enforcement

## Status And Authority

This approved spec is policy-only. It defines the adaptive governance routing
model that future implementation slices may add to ProjectGenesis after
fresh-context adversarial review.

Approval of this spec authorizes the follow-up BOOT-019 through BOOT-024 slices.
It does not by itself replace existing governance, validator, hook, CI, role,
context-pack, command, template, README, or state-structure mechanics.

This spec does not authorize changes to validators, hooks, CI workflows, shared
role files, context packs, command files, templates, README content, or
state-file structure. Those changes require later reviewed implementation
slices after this spec is approved or activated.

## Implementation Status

BOOT-019 through BOOT-024 are implemented on branch
`codex/boot-019-024-adaptive-governance` and pending fresh-context adversarial
review. The implementation adds the routed governance control plane,
impact map, validation modes, durable evidence rules, current-state and handoff
guidance, validator support, CI red checks, and performance measurement
authorized by this approved spec.

## Goal

Reduce time and token cost for small and medium ProjectGenesis operations by
making governance proportional to verified impact, while preserving the
existing source-of-truth hierarchy, evidence discipline, validation, review,
traceability, and multi-agent handoff model.

The intended outcome is smarter safety, not weaker safety. Agents must prove a
task has limited impact before using a lighter path.

## Non-Goals

- Do not remove source-of-truth hierarchy rules.
- Do not allow implementation without an approved or active spec.
- Do not remove fresh-context review for PR-worthy, risk-bearing, protected, or
  governance-significant work.
- Do not weaken traceability for requirements, specs, backlog, tests, reviews,
  release status, or external-ticket claims.
- Do not make chat history authoritative.
- Do not implement validator, hook, CI, role, command, context-pack, template,
  README, or state-structure changes in the first policy slice.
- Do not use token savings as permission to skip required understanding.

## Problem

ProjectGenesis currently gives agents strong guardrails but no authoritative
operation routing contract. In practice, small changes can trigger broad
context reading, repeated state updates, registry and traceability alignment,
review package creation, independent review, repeated validation, GitHub
operations, and post-merge cleanup even when the actual change is low-risk.

The repository already has risk rules, context packs, direct-main documentation
exceptions, hooks, validation, review policy, and traceability. What is missing
is a deterministic control plane that maps each operation to the minimum safe
governance required for that operation's verified impact.

## Core Principle

Adaptive governance is allowed only when it is durable, pre-declared,
path-aware, risk-mapped, and reviewable.

No agent may retroactively classify work after editing target files. A
pre-change classification record is the first permitted write of a meaningful
operation and does not recursively require a separate classification record.

## Operation Profiles

| Profile | Use Only When | Minimum Risk | Branch Rule | Required Validation | Review Requirement |
|---------|---------------|--------------|-------------|---------------------|--------------------|
| `review-only` | The agent performs read-only analysis or review, or writes only a review artifact. | Inherits reviewed artifact risk | No branch for pure read-only; branch required when writing durable review artifacts unless explicitly allowed by repository policy. | None for pure read-only; `bash SCRIPTS/validate-bootstrap.sh` and `git diff --check` when writing review/state artifacts. | Review output itself; durable review record when review is formal or PR-related. |
| `docs-trivial` | Typo, formatting, grammar, link text, or non-semantic documentation cleanup with no change to claims, instructions, process, setup, public positioning, or source-of-truth meaning. | low | Direct `main` allowed only under `BRANCH_AND_WORKTREE_GUIDE.md` direct-main documentation exception. | `git diff --check`; `bash SCRIPTS/validate-bootstrap.sh` when the touched file is registered or referenced by `CONTEXT_INDEX.md`. | none |
| `docs-non-authoritative` | Documentation wording improves clarity but does not change source-of-truth meaning, public claims, setup instructions, process guidance, supported tooling, or governance behavior. | low to medium | Branch unless the existing direct-main documentation exception clearly applies. | `bash SCRIPTS/validate-bootstrap.sh`; `git diff --check`. | Optional light review when ambiguity remains. |
| `docs-public-claim` | Public-facing or setup documentation changes claims about capabilities, supported tooling, setup, integrations, branch protection, optional tools, limitations, or user trust. | medium | Branch required unless typo-only. | `bash SCRIPTS/validate-bootstrap.sh`; `git diff --check`; claim evidence check. | Light fresh-context review; adversarial review when public claims affect governance, safety, security, release, dependency, external tooling, or source-of-truth expectations. |
| `state-sync` | Current-state, handoff, worklog, stale-items, test-results, or review-index alignment records already-reviewed, already-validated, or already-observed facts and does not change policy meaning. | medium | Branch unless post-merge administrative cleanup is explicitly allowed by existing policy and branch state. | `bash SCRIPTS/validate-bootstrap.sh`; `git diff --check`. | Review only when resolving conflict, stale state, or drift. |
| `planning-governance` | Creating or updating specs, backlog, traceability, artifact registry, ADRs, requirements, assumptions, risks, acceptance criteria, operation policy, or governance planning without changing validator, hook, CI, security, release, role, architecture-authority, or review mechanics. | high | Branch required. | `bash SCRIPTS/validate-bootstrap.sh`; `git diff --check`; red checks only if validation-rule behavior changes. | Fresh-context review before approval, activation, or implementation. |
| `strict-protected` | Validators, hooks, CI, shared rules, role files, security, privacy, release, branch policy, PR/merge policy, risk model, architecture authority, review policy, command-framework rules, context-pack authority rules, source-of-truth hierarchy, or high-risk/critical changes. | high to critical | Branch required. | `bash SCRIPTS/validate-bootstrap.sh`; relevant red checks; shell syntax checks for scripts/hooks; `git diff --check`; stack-specific checks when applicable. | Adversarial review mandatory; focused security, architecture, QA, or release review when triggered by `RISK_MODEL.md`. |

Existing repository rules dominate this table. `GOVERNANCE.md`,
`RISK_MODEL.md`, `PR_REVIEW_POLICY.md`, `PR_MERGE_POLICY.md`, and
`BRANCH_AND_WORKTREE_GUIDE.md` remain authoritative when stricter.

## Escalation Precedence

When multiple profiles match, use the highest-precedence applicable profile:

1. `strict-protected`
2. `planning-governance`
3. `state-sync`
4. `docs-public-claim`
5. `docs-non-authoritative`
6. `docs-trivial`
7. `review-only` for no-change review work

Precedence rules:

- `strict-protected` is required for validators, hooks, CI, shared rules, role
  files, security, privacy, release, branch policy, PR/merge policy, risk
  model, architecture authority, review policy, command-framework rules,
  context-pack authority rules, source-of-truth hierarchy, and high-risk or
  critical changes.
- `planning-governance` is allowed for protected planning artifacts when the
  change creates or updates specs, backlog, traceability, artifact registry,
  ADRs, requirements, assumptions, risks, acceptance criteria, operation
  policy, or governance planning and does not alter validator, hook, CI,
  security, release, role, architecture-authority, or review mechanics.
- `state-sync` is allowed for state, handoff, worklog, stale-items,
  test-results, and review-index alignment only when it records an
  already-reviewed, already-validated, or already-observed fact and does not
  change policy meaning.
- Docs profiles are allowed only when protected policy or source-of-truth
  meaning is not changed.
- Uncertainty escalates one level. If uncertainty remains after escalation,
  use `strict-protected` or stop for clarification.

## Protected Artifacts

All artifacts marked `authoritative: true` in `ARTIFACT_REGISTRY.md` are
protected by default.

The following artifact families are also protected by default:

- governance and source-of-truth files
- specs, ADRs, backlog, requirements, assumptions, risks, acceptance criteria,
  traceability, and artifact registry files
- current state, handoff, stale-item, open-question, test-result, review-index,
  and worklog files
- validation scripts, red-check scripts, hooks, CI workflows, Code Owners, and
  branch/repository setup guidance
- shared agent rules, role files, command files, context packs, and templates
- security, privacy, release, observability, CI/CD, contribution, PR, merge,
  risk, branch, and parallel-execution policy files
- public/setup documentation when the change affects claims, setup
  instructions, process guidance, supported tooling, governance behavior, or
  public trust

Explicit protected paths include:

- `AI_PROJECT_BOOTSTRAP.md`
- `GOVERNANCE.md`
- `CONTEXT_INDEX.md`
- `ARCHITECTURE.md`
- `DECISIONS.md`
- `BRANCH_AND_WORKTREE_GUIDE.md`
- `PARALLEL_EXECUTION_PLAN.md`
- `RISK_MODEL.md`
- `PR_REVIEW_POLICY.md`
- `PR_MERGE_POLICY.md`
- `AI_REVIEW_PROMPTS.md`
- `HOOKS_AND_GUARDRAILS.md`
- `SECURITY_AND_PRIVACY.md`
- `RELEASE_READINESS.md`
- `OBSERVABILITY.md`
- `CI_CD_GUIDE.md`
- `CONTRIBUTING.md`
- `GITHUB_REPOSITORY_SETUP.md`
- `.github/CODEOWNERS`
- `.github/workflows/**`
- `.githooks/**`
- `SCRIPTS/**`
- `memory/ai/**`
- `SPECS/**`
- `ADR/**`
- `BACKLOG.md`
- `BACKLOG/**`
- `TRACEABILITY_MATRIX.md`
- `ARTIFACT_REGISTRY.md`
- `CURRENT_STATE.md`
- `AI_HANDOFF.md`
- `OPEN_QUESTIONS.md`
- `STALE_ITEMS.md`
- `TEST_STRATEGY.md`
- `TEST_PLAN.md`
- `TEST_RESULTS.md`
- `TESTS/**`
- `WORKLOG/**`
- `CONTEXT_PACKS/**`
- `COMMANDS/**`
- `REVIEWS/templates/**`
- `SPECS/templates/**`
- `ADR/templates/**`
- `BACKLOG/templates/**`

## Pre-Change Classification Record

Before touching target files, the agent must record a durable pre-change
classification block. Chat-only classification is invalid.

Minimum required fields:

```text
Operation profile:
Target files:
Protected files touched:
Expected risk:
Branch requirement:
Required validation:
Required review:
Traceability impact:
Registry impact:
Handoff/state impact:
Dirty worktree status:
Escalation triggers checked:
```

The pre-change classification record is the first permitted write of the
operation. It does not require a separate pre-classification record, but dirty
worktree inspection must happen before any substantive file edit.

Durable locations by operation:

| Operation | Durable Record Location |
|-----------|-------------------------|
| `docs-trivial` | `AI_HANDOFF.md` compact entry when a persistent state update is required, otherwise the operation can be summarized in the final response only if no repository artifact changed. |
| `docs-non-authoritative` | `AI_HANDOFF.md`; `WORKLOG/WORKLOG_INDEX.md` when meaningful. |
| `docs-public-claim` | `AI_HANDOFF.md`, `WORKLOG/WORKLOG_INDEX.md`, and `TEST_RESULTS.md` when checks run. |
| `state-sync` | `AI_HANDOFF.md`, `CURRENT_STATE.md`, and `WORKLOG/WORKLOG_INDEX.md`. |
| `planning-governance` | The affected spec/backlog/review artifacts plus `AI_HANDOFF.md`, `CURRENT_STATE.md`, `WORKLOG/WORKLOG_INDEX.md`, `TRACEABILITY_MATRIX.md`, and `ARTIFACT_REGISTRY.md` as applicable. |
| `strict-protected` | Review package or review record, `TEST_RESULTS.md`, `AI_HANDOFF.md`, `CURRENT_STATE.md`, `ARTIFACT_REGISTRY.md`, and `TRACEABILITY_MATRIX.md` as applicable. |
| `review-only` | Review record when durable review is performed; otherwise `AI_HANDOFF.md` or `WORKLOG/WORKLOG_INDEX.md` when no files changed but the review affects next action. |

The phrase "durable handoff record" means a repository artifact such as
`AI_HANDOFF.md`, `CURRENT_STATE.md`, `WORKLOG/WORKLOG_INDEX.md`,
`TEST_RESULTS.md`, or a review record. It never means chat-only text.

## Final Evidence Envelope

After validation, every meaningful operation must record a final evidence
envelope in the same durable artifact family used for the pre-change
classification.

Minimum required fields:

```text
Operation profile:
Classification confidence:
Escalation triggers checked:
Files read:
Files changed:
Files intentionally not read:
Artifacts not impacted:
Validation run:
Validation skipped:
Review required:
Next safe action:
```

Skipped validation, skipped file reads, and skipped artifact updates require a
profile rule and a reason. "Not impacted" is invalid without a concrete
non-impact rationale.

## Dirty Worktree Rule

Unrelated dirty worktree changes block file edits.

Agents may continue only when all of these are true:

- dirty files have been inspected
- ownership is identified or marked unknown
- dirty files are unrelated to the target scope
- the planned work can proceed without touching them
- dirty status is recorded in the pre-change classification

If dirty changes overlap target files, the agent must stop or ask for explicit
direction.

## Traceability, Registry, State, And Handoff Impact Rules

Traceability can be marked not impacted only if the change does not add,
change, or remove any of:

- requirement
- source claim
- assumption
- risk
- acceptance criterion
- spec mapping
- backlog item
- ADR mapping
- planned or changed file mapping
- test evidence
- review evidence
- release status
- external ticket claim

Artifact registry can be marked not impacted only when no artifact is created,
changed, superseded, archived, deprecated, cancelled, or retired, and no
artifact metadata, status, version, authority, or source relationship changes.

Current state and handoff can be marked not impacted only when the operation
does not change branch, active task, current status, changed files, validation,
known risks, blockers, dirty status, next action, or resume instructions.

`TEST_RESULTS.md` can be marked not impacted only when no validation, test,
manual check, review check, or skipped check needs durable evidence.

`WORKLOG/WORKLOG_INDEX.md` can be marked not impacted only for trivial,
non-meaningful operations that do not affect future agent resume, review,
validation, or governance history.

## Handoff And Current-State Compression

Handoff and current-state details may be removed only when they are resolved or
cited from a durable artifact with file and section reference.

Git history alone is not acceptable for active risks, blockers, validation
failures, dirty state, next action, or unresolved assumptions. Future agents
must not need to mine Git history to recover active operational facts.

Compact handoff must still include branch, worktree, active task, changed
files, validation run, skipped checks, known risks, dirty status, next safe
action, and any unresolved blocker or assumption.

## Claim Evidence Check

Public, setup, tooling, or external-integration claims require evidence when
they affect setup, governance, safety, external tool use, public trust,
source-of-truth expectations, or downstream user behavior.

Accepted evidence types:

- repository source-of-truth artifact
- official vendor documentation
- verified CLI or API output
- merged PR or commit evidence
- explicit user instruction recorded in a durable repository artifact
- accepted ADR
- approved or active spec
- maintainer-approved registry or source entry

External tooling claims should use primary sources where practical. Stale or
unverified claims cannot be presented as current fact.

Evidence must be linked in the operation record, review package, traceability
matrix, or relevant source-of-truth artifact when the claim affects setup,
governance, or public trust.

## CI And Manual Enforcement

Initial policy:

- CI continues to run baseline `bash SCRIPTS/validate-bootstrap.sh`.
- Red checks remain mandatory manual evidence for validator-rule changes.
- Shell syntax checks remain mandatory manual evidence for script and hook
  changes.
- A later `strict-protected` implementation slice may add CI enforcement for
  red checks or shell syntax checks, but that is not part of this policy-only
  slice.

Agents must not imply CI enforces red checks or shell syntax checks until a
reviewed CI change actually adds those checks.

## First Slice Scope

The first implementation slice for this spec is policy-only.

Allowed and required files:

- `SPECS/SPEC-BOOT-003-adaptive-governance-routing.md`
- `SPECS/SPEC_INDEX.md`
- `BACKLOG.md`
- `ARTIFACT_REGISTRY.md`
- `TRACEABILITY_MATRIX.md`
- `CURRENT_STATE.md`
- `AI_HANDOFF.md`
- `TEST_RESULTS.md`
- `WORKLOG/WORKLOG_INDEX.md`
- PR review package under `REVIEWS/` before PR creation or formal PR review
- review record under `REVIEWS/` after adversarial review
- `REVIEWS/REVIEW_INDEX.md` after adversarial review

Forbidden in the first slice:

- validator changes
- hook changes
- CI changes
- role or shared-rule changes
- context-pack changes
- command changes
- template changes
- README rewrite
- structural handoff or current-state compression

## Functional Requirements

| ID | Requirement | Source | Priority | Confidence | Status |
|----|-------------|--------|----------|------------|--------|
| AGR-FR-001 | Define operation profiles that map task type to minimum risk, branch rule, validation, review, and durable evidence requirements. | User instruction; `RISK_MODEL.md`; `PR_REVIEW_POLICY.md`; `BRANCH_AND_WORKTREE_GUIDE.md` | P0 | high | approved |
| AGR-FR-002 | Require a durable pre-change classification record before target file edits. | User instruction; `memory/ai/SHARED_AGENT_RULES.md`; `AI_PROJECT_BOOTSTRAP.md`; `GOVERNANCE.md` | P0 | high | approved |
| AGR-FR-003 | Require a final durable evidence envelope after validation for meaningful operations. | User instruction; `memory/ai/SHARED_AGENT_RULES.md`; `AI_PROJECT_BOOTSTRAP.md`; `GOVERNANCE.md` | P0 | high | approved |
| AGR-FR-004 | Define protected artifacts by registry authority plus explicit artifact families and paths. | User instruction; `ARTIFACT_REGISTRY.md`; `GOVERNANCE.md` | P0 | high | approved |
| AGR-FR-005 | Define deterministic escalation precedence across profiles. | User instruction; `RISK_MODEL.md`; `PR_REVIEW_POLICY.md`; `BRANCH_AND_WORKTREE_GUIDE.md` | P0 | high | approved |
| AGR-FR-006 | Block edits when unrelated dirty worktree changes are unexplained or overlap target files. | User instruction; `BRANCH_AND_WORKTREE_GUIDE.md`; `PR_REVIEW_POLICY.md` | P0 | high | approved |
| AGR-FR-007 | Define exact conditions for marking traceability, registry, state, handoff, test results, and worklog not impacted. | User instruction; `TRACEABILITY_MATRIX.md`; `ARTIFACT_REGISTRY.md`; `memory/ai/SHARED_AGENT_RULES.md` | P0 | high | approved |
| AGR-FR-008 | Preserve handoff and current-state continuity during future compression by requiring durable file and section references for removed active facts. | User instruction; `AI_HANDOFF.md`; `CURRENT_STATE.md`; `memory/ai/SHARED_AGENT_RULES.md` | P1 | high | approved |
| AGR-FR-009 | Define claim evidence requirements for public, setup, tooling, and external-integration claims. | User instruction; `GOVERNANCE.md`; `BACKLOG.md`; `TRACEABILITY_MATRIX.md` | P1 | high | approved |
| AGR-FR-010 | Define CI/manual validation boundaries so agents do not overclaim CI coverage. | User instruction; `CI_CD_GUIDE.md`; `TEST_RESULTS.md`; `.github/workflows/bootstrap-validation.yml` | P1 | high | approved |
| AGR-FR-011 | Keep the first slice policy-only and prohibit validators, hooks, CI, roles, context packs, commands, templates, README, and state-structure changes until later reviewed slices. | User instruction; first-slice scope in this spec; `PR_REVIEW_POLICY.md` | P0 | high | approved |

## Non-Functional Requirements

| ID | Requirement | Source | Priority | Confidence | Status |
|----|-------------|--------|----------|------------|--------|
| AGR-NFR-001 | Adaptive routing must not weaken source-of-truth hierarchy, role separation, traceability, validation, review, or multi-agent handoff. | `AI_PROJECT_BOOTSTRAP.md`; `GOVERNANCE.md`; user instruction | P0 | high | approved |
| AGR-NFR-002 | Token and time savings must come from routing, selective reading, selective writing, compact durable evidence, and batched validation, not from guessing or skipping required understanding. | User instruction and repository analysis | P0 | high | approved |
| AGR-NFR-003 | Classification must be reviewable from repository artifacts without relying on chat history. | `memory/ai/SHARED_AGENT_RULES.md`; `AI_PROJECT_BOOTSTRAP.md`; `GOVERNANCE.md`; user instruction | P0 | high | approved |
| AGR-NFR-004 | Initial enforcement should avoid brittle semantic shell validation; structural/path checks can be added later after this policy is reviewed. | User instruction; `SCRIPTS/validate-bootstrap.sh`; `SCRIPTS/validate-bootstrap-red-checks.sh` | P1 | high | approved |

## Acceptance Criteria

| ID | Requirement IDs | Given | When | Then | Test Mapping |
|----|-----------------|-------|------|------|--------------|
| AGR-AC-001 | AGR-FR-001, AGR-FR-005 | An agent classifies a task | Multiple profiles appear possible | The highest-precedence applicable profile wins, and uncertainty escalates. | Fresh-context review |
| AGR-AC-002 | AGR-FR-002, AGR-NFR-003 | A meaningful operation changes repository files | The agent starts work | A durable pre-change classification exists before target file edits. | Review and handoff inspection |
| AGR-AC-003 | AGR-FR-003 | A meaningful operation completes validation | The agent stops or hands off | A durable final evidence envelope records files read, files changed, validation, skipped checks, not-impacted artifacts, and next safe action. | Review and handoff inspection |
| AGR-AC-004 | AGR-FR-004 | A protected artifact is touched | The task is classified | The profile escalates according to protected artifact and precedence rules. | Review |
| AGR-AC-005 | AGR-FR-006 | The worktree is dirty | The agent prepares edits | Unrelated dirty changes are inspected, explained, and isolated, or edits stop. | Review and git status evidence |
| AGR-AC-006 | AGR-FR-007 | An agent marks traceability, registry, state, handoff, test results, or worklog not impacted | Review checks the operation | The record states the exact non-impact reason using this spec's rules. | Review |
| AGR-AC-007 | AGR-FR-008 | Future cleanup shortens handoff/current state | Active facts are removed | Each removed active fact is resolved or cited to a durable artifact and section, not just Git history. | Review |
| AGR-AC-008 | AGR-FR-009 | README, setup, tooling, or external claims change | The agent records evidence | Evidence uses accepted source types and primary sources where practical. | Review |
| AGR-AC-009 | AGR-FR-010 | Protected validation, script, or hook mechanics change in a future slice | Validation is reported | Manual red-check or syntax evidence is recorded unless CI has been reviewed to enforce it. | Review and test results |
| AGR-AC-010 | AGR-FR-011 | The first policy slice is implemented | Review inspects changed files | No validator, hook, CI, role, context-pack, command, template, README, or state-structure change is included. | `git diff --name-only`; review |

## Edge Cases

- A README typo appears in a paragraph that states governance behavior:
  classify as `docs-trivial` only if the meaning does not change. If meaning
  changes, escalate.
- A public-tooling claim cites memory or chat only: reject the claim until
  durable source evidence exists.
- A protected planning file changes only to register an already-reviewed
  operation: `state-sync` may apply when no policy meaning changes.
- A validator file changes one comment: `strict-protected` still applies
  because validator mechanics are protected and semantic impact may be subtle.
- An agent cannot decide whether traceability changed: escalate and update or
  record the uncertainty as a blocker.

## Risks

| Risk | Impact | Mitigation | Detection |
|------|--------|------------|-----------|
| Agent misclassifies governance work as documentation. | Weakened review or validation. | Protected artifact rule, escalation precedence, durable pre-change classification. | Fresh-context review, future path-based validator checks. |
| Evidence envelope becomes chat-only. | Violates repository source-of-truth model. | Require durable artifact locations for each profile. | Review checks handoff, worklog, test results, or review record. |
| Handoff compression loses active risks. | Future agents cannot resume safely. | Removed active facts must be resolved or cited to durable artifact sections. | Resume review and handoff inspection. |
| Validator becomes brittle by trying to infer meaning. | False positives or false safety. | Initial validator enforcement should be structural/path-based only. | Validator red checks in later implementation slice. |
| CI coverage is overclaimed. | Merge protection may not catch required manual checks. | Explicit CI/manual boundary rule. | Review checks `TEST_RESULTS.md` and CI workflow. |
| Token reduction encourages under-reading. | Hallucinated or stale work. | Required minimum classification, escalation, and non-impact rationale. | Review of files read and intentionally not read. |

## Test Requirements

- Unit: not applicable for this policy-only Markdown spec.
- Integration: `bash SCRIPTS/validate-bootstrap.sh` must pass after spec,
  backlog, registry, traceability, current state, handoff, test results, and
  worklog updates.
- Contract: future validator implementation must include red-check examples for
  misclassification and protected-path violations before enforcement is
  accepted.
- End-to-end: future representative benchmarks should measure docs-trivial,
  docs-public-claim, state-sync, planning-governance, and strict-protected
  operations.
- Manual: fresh-context adversarial review must challenge classification,
  escalation, durable evidence, protected artifacts, dirty worktree handling,
  handoff compression, claim evidence, and CI/manual boundaries.
- Security: no security policy behavior changes are included in the first
  policy slice.
- Performance: target small-operation time reduction is at least 60%; target
  medium-operation time reduction is 40% to 50%, without reducing strict review
  for protected/high-risk work.

## Review Preparation

Fresh-context adversarial review must challenge:

- classification cannot be retroactive
- evidence is durable and repository-grounded
- protected artifact precedence is deterministic
- docs paths cannot hide governance changes
- dirty worktree handling blocks unsafe edits
- handoff compaction preserves active risks
- CI/manual validation boundaries are explicit
- claim evidence rules are enforceable
- first-slice scope excludes validators, hooks, CI, roles, context packs,
  commands, templates, README changes, and state-structure compression

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

- [x] This proposed spec has completed fresh-context adversarial review.
- [x] P0, P1, and blocking P2 findings are resolved or explicitly accepted.
- [x] `SPECS/SPEC_INDEX.md` lists this spec.
- [x] `BACKLOG.md` lists BOOT-018 through BOOT-024.
- [x] `ARTIFACT_REGISTRY.md` registers this spec.
- [x] `TRACEABILITY_MATRIX.md` maps this spec to requirements and backlog
  items.
- [x] `CURRENT_STATE.md` and `AI_HANDOFF.md` are updated.
- [x] `TEST_RESULTS.md` records validation.
- [x] `WORKLOG/WORKLOG_INDEX.md` records the session.
- [x] `bash SCRIPTS/validate-bootstrap.sh` and `git diff --check` pass.
- [x] No forbidden first-slice files changed.

## Implementation Notes

This first slice is policy-only. Later implementation should proceed in
separate reviewed slices:

- BOOT-019: define operation profile policy in user-facing governance docs.
- BOOT-020: define artifact impact map.
- BOOT-021: define validation mode guidance and evidence envelope reuse points.
- BOOT-022: update current-state and handoff policy without compressing
  existing state yet.
- BOOT-023: add structural validator support and red-check cases.
- BOOT-024: measure representative operation performance and token impact.

## Change History

| Version | Date | Change | Author |
|---------|------|--------|--------|
| v0.1 | 2026-05-13 | Initial proposed policy-only adaptive governance routing spec. | Codex |
| v0.2 | 2026-05-13 | Removed non-durable prior-review source claims, tightened source evidence, and added PR review package to first-slice review artifacts. | Codex |
| v1.0 | 2026-05-13 | Approved after fresh-context adversarial re-review found no P0, P1, or P2 findings; retained policy-only scope for follow-up slices. | Codex |
