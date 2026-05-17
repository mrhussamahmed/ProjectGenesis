artifact_id: ART-OPS-ROUTING-001
title: Operation Routing And Impact Map
type: governance
status: authoritative
version: v1.1
created: 2026-05-14
updated: 2026-05-17
owner: AI Bootstrap Maintainers
source: SPEC-BOOT-003, user authorization for BOOT-019 through BOOT-024, and BOOT-STATE-001
linked_specs: [SPEC-BOOT-003]
linked_tickets: [BOOT-STATE-001]
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Operation Routing And Impact Map

This file is the adaptive governance control plane for ProjectGenesis. It makes
governance proportional to verified impact without weakening source-of-truth
rules, traceability, validation, review, or multi-agent handoff.

Existing stricter rules still win. If this file conflicts with
`GOVERNANCE.md`, `RISK_MODEL.md`, `PR_REVIEW_POLICY.md`,
`PR_MERGE_POLICY.md`, `BRANCH_AND_WORKTREE_GUIDE.md`, an approved or active
spec, or current user instruction, follow the stricter or higher-priority rule
and record the conflict.

## Fast-Path Validator Discipline (Slice 4)

Operation profile may be recorded in gitignored `.ai/SESSION.md` for local
hook hints, with legacy `AI_HANDOFF.md` profile extraction as a compatibility
fallback. Small changes still get a proportionally small validator pass only
when strict gates are not touched:

1. `SCRIPTS/operation-profile.sh` extracts a valid local
   `operation_profile:` value from `.ai/SESSION.md` when the session branch
   matches the current branch and `updated_at_epoch:` is fresh. It falls back
   to legacy `AI_HANDOFF.md` extraction only when no valid local session hint
   exists. It then maps the profile to a validator level:
   - `docs-trivial` and `process-light-exception` → `shape-only`
   - any other profile (including missing or unrecognized) → `strict`
2. `.githooks/pre-commit` and `.githooks/pre-push` read this mapping and
   export `BOOTSTRAP_VALIDATE_PROFILE`. They also enforce a strict-gate
   override: if the staged or pushed file set touches any of `SCRIPTS/`,
   `.github/workflows/`, `.githooks/`, `memory/ai/`, the policy files
   (`PR_REVIEW_POLICY.md`, `PR_MERGE_POLICY.md`, `RISK_MODEL.md`,
   `BRANCH_AND_WORKTREE_GUIDE.md`, `GOVERNANCE.md`,
   `OPERATION_ROUTING.md`), the context packs, the commands, the reusable
   templates under `*/templates/`, `TEMPLATE_MANIFEST.md`,
   `TEMPLATE_STARTERS/`, `HOOKS_AND_GUARDRAILS.md`,
   `SECURITY_AND_PRIVACY.md`, `CI_CD_GUIDE.md`, or `MAINTAINER_ARCHIVE/`,
   the hook forces the validator back to `strict` regardless of the
   recorded profile.
3. `SCRIPTS/validate-bootstrap.sh` honors `BOOTSTRAP_VALIDATE_PROFILE`.
   In `shape-only` mode it runs only the required-files,
   required-dirs, and YAML metadata checks, then exits early with a
   passing message. In `strict` mode (default) it runs every check.

The default everywhere remains strict, so a missing, stale, branch-mismatched,
or unrecognized profile never weakens validation. The fast path is opt-in via
an explicit docs-trivial or process-light-exception local session profile, AND
the hook layer must agree (no strict-gate paths touched) before the lighter
check actually runs.

This implements the "small changes avoid heavyweight validation and
review ceremony" goal of the approved Clean Scaffold Boundary And
Faster AI Development plan without weakening the strict gates for
validators, CI, security, merge/release, governance, role
instructions, or template/export behavior.

## Operating Rule

Every meaningful operation must be classified before target file edits.

Adaptive routing is allowed only when the operation record proves:

- the profile is selected before substantive edits
- dirty worktree state is inspected and isolated
- protected artifacts are identified
- required reads are scoped by impact
- writes are limited to impacted artifacts
- skipped validation has a rule-based reason
- durable evidence exists in PR/review evidence or repository files

Chat-only classification, chat-only review, and chat-only completion evidence
are invalid for meaningful work.

`.ai/SESSION.md` is not durable operation evidence. Durable operation evidence
for shared or protected work must live in one of: PR body, PR comment,
committed PR review package, committed review record, or an explicitly
approved bootstrap-governance exception.

## Operation Profiles

| Profile | Use Only When | Minimum Risk | Branch Rule | Validation | Review |
|---------|---------------|--------------|-------------|------------|--------|
| `review-only` | Read-only analysis, review, or a durable review record. | inherited from target | No branch for pure read-only; branch when writing review/state artifacts unless repository policy allows otherwise. | None for pure read-only; `bash SCRIPTS/validate-bootstrap.sh` and `git diff --check` when writing artifacts. | Review decision or durable review record when formal. |
| `docs-trivial` | Typo, formatting, grammar, or link cleanup with no semantic, claim, setup, process, or governance meaning change. | low | Direct `main` allowed only under the documented direct-main exception. | `git diff --check`; bootstrap validation when the file is registered or context-indexed. | None. |
| `docs-non-authoritative` | Clarity-only documentation that does not alter source-of-truth meaning, public claims, setup, supported tooling, process, or governance behavior. | low to medium | Branch unless the direct-main exception clearly applies. | `bash SCRIPTS/validate-bootstrap.sh`; `git diff --check`. | Optional light review when ambiguity remains. |
| `docs-public-claim` | README, setup, tooling, integration, branch-protection, limitation, capability, or user-trust claim changes. | medium | Branch required unless typo-only. | Bootstrap validation, `git diff --check`, and claim evidence check. | Light fresh-context review; adversarial review when governance, safety, security, release, dependency, external-tool, or source-of-truth expectations change. |
| `state-sync` | State, handoff, worklog, stale-items, test-results, or review-index alignment that records already-reviewed, already-validated, or already-observed facts and does not change policy meaning. | medium | Branch unless post-merge administrative cleanup is explicitly allowed by current policy and branch state. | Bootstrap validation and `git diff --check`. | Review when resolving conflict, stale state, or drift. |
| `planning-governance` | Specs, backlog, traceability, registry, ADRs, requirements, assumptions, risks, acceptance criteria, or governance planning without changing validators, hooks, CI, security, release, role, architecture-authority, command-framework, context-pack authority, or review mechanics. | high | Branch required. | Bootstrap validation and `git diff --check`; red checks only if validation behavior changes. | Fresh-context review before approval, activation, or implementation. |
| `strict-protected` | Validators, hooks, CI, shared rules, role files, security, privacy, release, branch policy, PR/merge policy, risk model, architecture authority, review policy, command-framework rules, context-pack authority rules, source-of-truth hierarchy, or high-risk and critical changes. | high to critical | Branch required. | Bootstrap validation, relevant red checks, shell syntax checks for scripts/hooks, `git diff --check`, and stack-specific checks when applicable. | Adversarial review mandatory; focused role review when triggered by risk. |

## Escalation Precedence

When multiple profiles match, use the highest applicable profile:

1. `strict-protected`
2. `planning-governance`
3. `state-sync`
4. `docs-public-claim`
5. `docs-non-authoritative`
6. `docs-trivial`
7. `review-only`

Deterministic escalation targets:

| Trigger | Target Profile |
|---------|----------------|
| Validator, red-check, hook, CI, shared-rule, role, security, release, branch, PR, merge, risk, architecture-authority, command-framework, context-pack-authority, or source-of-truth hierarchy change | `strict-protected` |
| Spec, backlog, registry, traceability, ADR, requirement, assumption, risk, acceptance, or governance-planning change without protected mechanics | `planning-governance` |
| Current-state, handoff, worklog, stale-item, test-result, or review-index alignment that records reviewed or observed facts only | `state-sync` |
| README, setup, tooling, external-integration, capability, limitation, or public trust claim change | `docs-public-claim` |
| Non-authoritative wording with no claim or source-of-truth meaning change | `docs-non-authoritative` |
| Typo or formatting only | `docs-trivial` |

Uncertainty escalates one level. If uncertainty remains after escalation, use
`strict-protected` or stop for clarification.

## Protected Artifacts

All artifacts marked `authoritative: true` in `ARTIFACT_REGISTRY.md` are
protected by default.

Protected families:

- governance and source-of-truth files
- specs, ADRs, backlog, requirements, assumptions, risks, acceptance maps,
  traceability, and artifact registry
- current state, handoff, stale items, open questions, test results, review
  index, review records, and worklog
- validation scripts, red-check scripts, hooks, CI workflows, Code Owners, and
  repository setup guidance
- shared agent rules, role files, command files, context packs, and templates
- security, privacy, release, observability, CI/CD, contribution, PR, merge,
  risk, branch, and parallel-execution policy files
- public/setup documentation when claims, setup instructions, process guidance,
  supported tooling, governance behavior, or public trust change

Changing a protected file does not always mean `strict-protected`.
Protected planning artifacts may use `planning-governance` when the change is
limited to planning records. Protected mechanics use `strict-protected`.

## Read Tiers

Agents should read the smallest tier that can safely classify and complete the
operation. A higher tier is required when lower tiers cannot explain impact.

| Tier | Purpose | Typical Files |
|------|---------|---------------|
| Tier 1: route | Classify the operation and detect blockers. | `memory/ai/SHARED_AGENT_RULES.md`, selected role file, `CURRENT_STATE.md`, `AI_HANDOFF.md`, `CONTEXT_INDEX.md`, `ARTIFACT_REGISTRY.md`, `SPECS/SPEC_INDEX.md`, `BACKLOG.md`, `git status --short --branch`. |
| Tier 2: operate | Read operation-specific authority and changed artifacts. | Relevant spec, backlog item, risk/review/branch policy, impact map, touched files, related tests. |
| Tier 3: verify | Check supporting evidence and cross-artifact consistency. | Traceability, registry, test results, review package, acceptance map, CI/hook scripts, context packs, templates. |
| Tier 4: history | Resolve disputed facts, regressions, stale state, or review history. | Older review records, worklogs, archived artifacts, legacy intake, Git history. |

Large files should not be opened by default when a table row, metadata block,
or index entry answers the question. If an agent opens a large historical file,
the final evidence envelope must state why.

## Token Budgets

Token budgets are targets, not permission to skip required understanding.

| Profile | Target Read Budget | Target Durable Output Budget |
|---------|--------------------|------------------------------|
| `review-only` | Tier 1 plus target review evidence; expand only for findings. | Review findings only; cite sources instead of copying them. |
| `docs-trivial` | Tier 1 minimal plus touched file section. | Final summary or compact handoff if required. |
| `docs-non-authoritative` | Tier 1 and touched file sections. | Compact handoff/worklog entry when meaningful. |
| `docs-public-claim` | Tier 1, touched file sections, and primary evidence for claims. | Compact claim evidence and validation entry. |
| `state-sync` | Tier 1 and the durable artifact proving the observed fact. | Compact state/handoff/worklog delta. |
| `planning-governance` | Tier 1, relevant spec/backlog/traceability/registry, and touched policy files. | Focused source-of-truth updates; no copied history. |
| `strict-protected` | Tier 1 through Tier 3; Tier 4 only for unresolved risk or drift. | Full evidence envelope, validation evidence, and review package. |

## Write Plan

Before substantive edits, the operation record must list:

- operation profile
- target files
- protected files touched
- expected risk
- branch requirement
- required validation
- required review
- traceability impact
- registry impact
- handoff/state impact
- dirty worktree status
- escalation triggers checked
- files expected to change
- files expected not to change
- protected artifacts touched
- validations to run
- validations intentionally skipped and why
- expected traceability, registry, state, handoff, test-result, and worklog
  impact
- rollback consideration when relevant
- expected time and token impact when the operation is medium or larger

The write plan may live in `AI_HANDOFF.md`, a review package, or the affected
spec/backlog artifact. It is allowed to be the first durable write of the
operation.

Minimum pre-change classification fields:

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

## Impact Map

| Changed File Or Family | Must Check | Usually Update | Validation | Review |
|------------------------|------------|----------------|------------|--------|
| `README.md`, `GETTING_STARTED.md`, setup docs | Claim evidence, `ARTIFACT_REGISTRY.md`, `TRACEABILITY_MATRIX.md` if claims/process change | Registry metadata, test results, handoff/worklog for meaningful edits | Bootstrap validation, `git diff --check`, claim evidence check | Light or adversarial based on claim risk |
| `CURRENT_STATE.md`, `AI_HANDOFF.md`, `WORKLOG/**`, `TEST_RESULTS.md`, `STALE_ITEMS.md` | Source artifact proving the state, branch status, dirty status | Registry metadata when changed; traceability if evidence/release status changes | Bootstrap validation, `git diff --check` | Only when conflict/drift is resolved |
| `SPECS/**`, `BACKLOG.md`, `BACKLOG/**`, `ADR/**`, `02_requirements/**`, `TESTS/ACCEPTANCE_CRITERIA_MAP.md` | Spec index, traceability, registry, risk model, branch policy | Related indexes, traceability, registry, state/handoff, test results | Bootstrap validation, `git diff --check`; red checks only for validator behavior | Fresh-context review before approval/activation/implementation |
| `GOVERNANCE.md`, `OPERATION_ROUTING.md`, `AI_PROJECT_BOOTSTRAP.md`, `CONTEXT_INDEX.md`, `BRANCH_AND_WORKTREE_GUIDE.md`, `RISK_MODEL.md`, PR/merge/review policy | Source-of-truth hierarchy, profile mapping, review policy, risk triggers | Registry, traceability, state/handoff, test results, worklog, review package | Bootstrap validation, `git diff --check`; red checks if validator behavior changes | Adversarial review |
| `SCRIPTS/**`, `.githooks/**`, `.github/workflows/**` | CI/manual boundary, red checks, shell syntax, branch protection assumptions | Registry, traceability, test results, state/handoff, worklog, review package | Bootstrap validation, red checks, shell syntax checks, `git diff --check`, CI validation | Adversarial review; focused QA/release review when high risk |
| `memory/ai/**`, `CONTEXT_PACKS/**`, `COMMANDS/**`, templates | Authority limits, source-of-truth hierarchy, validator structural checks | Registry, traceability, state/handoff, test results, worklog | Bootstrap validation, red checks when structural rules change, `git diff --check` | Adversarial review when authority or workflow changes |
| Product implementation files in a downstream project | Approved/active spec, tests, architecture/ADR, security/privacy, rollback | Traceability, registry when artifacts change, state/handoff, test results | Stack-specific tests plus bootstrap checks as applicable | Risk-based PR review |

An artifact is "not impacted" only when the rule in `SPEC-BOOT-003` is met and
the final evidence envelope states the concrete non-impact reason.

## Validation Modes

| Mode | Use When | Required Checks |
|------|----------|-----------------|
| fast | Low-risk docs-trivial or read-only operations with no protected semantic change. | `git diff --check`; bootstrap validation only when the file is registered or context-indexed. |
| standard | State-sync, docs-public-claim, docs-non-authoritative, and planning-governance changes without validator behavior changes. | `bash SCRIPTS/validate-bootstrap.sh`; `git diff --check`; claim evidence check when relevant. |
| strict | Strict-protected changes, validator/hook/CI changes, review-policy changes, source-of-truth hierarchy changes, or high-risk changes. | Bootstrap validation, red checks when validator behavior changes, shell syntax checks for scripts/hooks, `git diff --check`, stack-specific checks when applicable, and CI before merge. |

Skipped validation must be recorded in `TEST_RESULTS.md` or the final evidence
envelope with a profile rule and reason. Re-running the same check after every
minor edit is not required when a later full validation covers the edited set,
but the final evidence must say which validation covered the full diff.

## Evidence Envelope

Meaningful operations must end with a durable final evidence envelope in the
same artifact family used for classification. Minimum fields:

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

The envelope should cite source artifacts and sections instead of copying long
summaries. It must preserve active risks, blockers, validation failures, dirty
state, next action, unresolved assumptions, and review status.

## Handoff And Current State

Committed current-state files are replace-in-place snapshots. They should not
accumulate session diaries. Historical proof should live in Git commits,
GitHub PRs, CI run links, review records when risk requires them, and rare
milestone archives.

Committed state changes only when one of these changes:

- durable project baseline
- active blocker
- accepted spec, backlog, or ADR status
- release or validation baseline
- known risk affecting future work

Normal branch progress does not change canonical state. Operation
classification may be recorded in `.ai/SESSION.md` for local work and in PR
evidence for shared review. Only durable policy or project-state changes need
committed state updates.

`CURRENT_STATE.md` should contain current operational truth only:

- active specs and branches
- current implementation/review phase
- blockers and stale items
- current source-of-truth files
- next recommended action
- latest meaningful validation

`AI_HANDOFF.md` should contain resume-critical operational facts:

- active role, branch, and worktree
- current task and changed files
- classification and final evidence envelope
- validation run and skipped checks
- known risks and dirty worktree status
- next safe action and required first reads

Historical detail belongs in review records, worklogs, test results, or
archived artifacts. Active facts may be removed from state/handoff only when
resolved or cited to a durable artifact and section. Git history alone is not a
valid replacement for active operational facts.

## Claim Evidence

Public, setup, tooling, or external-integration claims need evidence when they
affect setup, governance, safety, external tool use, public trust,
source-of-truth expectations, or downstream user behavior.

Accepted evidence:

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

## Measurement

BOOT-024 performance measurement uses representative operation estimates rather
than weakening governance:

- small operation: docs-trivial, state-sync, or claim-free wording update
- medium operation: planning-governance or docs-public-claim update
- strict operation: validator, CI, role, review, or source-of-truth mechanics

Target improvements:

- small operations: at least 60% less execution time versus full-governance
  treatment when eligible for fast or state-sync routing
- medium operations: 40% to 50% less execution time through scoped reads,
  impact-based writes, batched validation, and compact evidence
- strict operations: no speed target that weakens review; savings come from
  clearer routing, fewer repeated reads, and less duplicated handoff text

Measurement must record:

- profile used
- files read by tier
- files changed
- validations run or batched
- review required or skipped with rule
- estimated or observed time impact
- estimated token impact
- safety checks preserved
