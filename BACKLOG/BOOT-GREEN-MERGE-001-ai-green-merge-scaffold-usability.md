artifact_id: ART-BACKLOG-BOOT-GREEN-MERGE-001
title: AI Green-Merge For Bootstrap Scaffold Usability
type: backlog-item
status: ready
version: v1.0
created: 2026-05-17
updated: 2026-05-17
owner: AI Bootstrap Maintainers
source: User-requested green-merge plan for new-project bootstrap usability; recurring bootstrap-governance exception in PR_MERGE_POLICY.md
linked_specs: []
linked_tickets: [BOOT-GREEN-MERGE-001]
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# BOOT-GREEN-MERGE-001: AI Green-Merge For Bootstrap Scaffold Usability

## Purpose

Make the bootstrap scaffold usable when a new project starts by removing
low-value ceremony and human-approval gates from active authoritative policy
while preserving objective safety gates: required CI/status checks, required
local validation, resolution of P0/P1/blocking P2 findings, clean scope, and
no failed-check bypass.

## User Or System Value

A new-project consumer of the scaffold should not be blocked by a human or
maintainer approval gate that the AI cannot satisfy. The scaffold remains safe
because objective gates (CI, validation, blocker resolution, scope) still hold.

## Scope

In scope:

- update `PR_MERGE_POLICY.md` to remove human/maintainer/Code Owner approval as
  required merge gates and state explicitly that AI may merge after objective
  gates pass
- update `PR_REVIEW_POLICY.md` to frame adversarial review as defect detection,
  not authorization
- update `GOVERNANCE.md` and the relevant `memory/ai/ROLE_*.md` files to remove
  or reword active rules that block AI green-merge while preserving rules that
  prevent merging with failed checks or unresolved blockers
- update `.github/CODEOWNERS` (and any related setup docs) so Code Owner
  ownership is informational only and never required as a merge gate
- update `SCRIPTS/validate-bootstrap.sh` to remove the previous maintainer-
  approval boundary guard and add a regression guard that fails when active
  authoritative policy reintroduces required human/maintainer/Code Owner
  approval as a merge gate
- update `SCRIPTS/validate-bootstrap-red-checks.sh` with a targeted fixture
  proving the validator fails when required human/maintainer approval returns
- align GitHub branch protection so required approving reviews and required
  Code Owner reviews are not merge gates while required status checks remain;
  document any residual external blocker explicitly

Out of scope:

- database or YAML state-system migration
- red-check performance refactor
- split-state redesign (already shipped via BOOT-STATE-001)
- historical PR cleanup
- new durable PR diary format
- broad governance rewrite
- introducing human approval under another name

## Links

- Linked spec: none; this item uses the recurring bootstrap-governance
  exception in `PR_MERGE_POLICY.md`
- Linked acceptance criteria: see Definition Of Done below; the operational
  green-merge contract is encoded in the updated `PR_MERGE_POLICY.md`
- Linked requirements: `TRACEABILITY_MATRIX.md` row
  `TRACE-AI-GREEN-MERGE-001`
- Source IDs: none
- Approved assumptions: none
- Open questions: none
- Related ADR: none
- Related external ticket: none

## Dependencies

- `PR_MERGE_POLICY.md` recurring bootstrap-governance exception must remain
  available as the no-spec authority surface for bootstrap-governance work.
- GitHub branch protection on `main` must keep required status checks
  enforcing CI green; required approving reviews and Code Owner reviews must
  not gate merge.

## Risks

- Removing human approval gates could weaken oversight; mitigated by keeping
  objective gates (CI, validation, blocker resolution, scope) and by adding a
  validator regression guard that fails if required human/maintainer approval
  returns to active authoritative policy.
- Adversarial review is still required as defect detection; framing it as
  optional approval could create false signal. Mitigated by explicit policy
  language separating defect detection from authorization.

## Suggested Owner Role

Implementation Agent

## Estimated Complexity

medium

## Implementation Phase

Single implementation pass per the user-supplied scope. Policy files,
validator, red checks, CODEOWNERS, governance, role files, and supporting
indices update together.

## Related Files Or Modules

- `PR_MERGE_POLICY.md`
- `PR_REVIEW_POLICY.md`
- `GOVERNANCE.md`
- `memory/ai/ROLE_IMPLEMENTATION_AGENT.md`
- `memory/ai/ROLE_ADVERSARIAL_PR_REVIEWER.md` (if review-as-permission framing
  exists)
- other `memory/ai/ROLE_*.md` files only when an active rule blocks AI
  green-merge
- `.github/CODEOWNERS`
- `SCRIPTS/validate-bootstrap.sh`
- `SCRIPTS/validate-bootstrap-red-checks.sh`
- `ARTIFACT_REGISTRY.md`
- `TRACEABILITY_MATRIX.md`
- `TEST_RESULTS.md`
- `BACKLOG/BACKLOG_INDEX.md`
- `REVIEWS/REVIEW_INDEX.md`
- `WORKLOG/WORKLOG_INDEX.md`

## Linear Ticket

- Should become external ticket: no
- Tracker: none
- Ticket status: not-created
- Ticket ID or URL:
- Confirmation evidence:

## Priority

P1

## Readiness Status

ready

## Readiness Evidence

- Source evidence: user-supplied implementation prompt with full scope, green-
  merge contract, validation commands, adversarial-review prompt, and
  completion requirements
- Spec status: not applicable; uses the recurring bootstrap-governance
  exception in `PR_MERGE_POLICY.md`
- Acceptance criteria: encoded in `PR_MERGE_POLICY.md` after this PR;
  validator regression guard and Codex adversarial review enforce them
- Dependencies: PR_MERGE_POLICY exception availability; GitHub branch
  protection alignment for required status checks
- Architecture impact: bootstrap operating-model mechanics only; no product
  architecture impact
- Test expectations: `bash SCRIPTS/validate-bootstrap.sh`,
  `bash SCRIPTS/validate-bootstrap-red-checks.sh`, `git diff --check`, policy
  scan via `rg`, CI, fresh Codex adversarial review
- Branch/worktree plan: branch `codex/ai-green-merge-plan-review`, repository
  root worktree
- Required reviewers: fresh-context Codex adversarial reviewer; defect-
  detection only, not authorization
- Blocked until: required CI passes and Codex review has no blocking
  findings; no human approval gate

## Test Expectations

- `bash SCRIPTS/validate-bootstrap.sh`
- `bash SCRIPTS/validate-bootstrap-red-checks.sh`
- `git diff --check`
- targeted `rg` policy scan for "human approval | maintainer approval |
  self-approve | self approve | Code Owner review | Require review |
  approving review | required review"
- shell syntax checks when scripts/hooks change
- GitHub Actions `Bootstrap Validation` workflow on the PR head

## Definition Of Done

- [ ] `PR_MERGE_POLICY.md` requires CI/status, validation, blocker resolution,
  clean scope, and no failed-check bypass; human/maintainer/Code Owner
  approval is explicitly not required.
- [ ] `PR_REVIEW_POLICY.md` frames review as defect detection, not
  authorization.
- [ ] `GOVERNANCE.md` and active role files no longer block AI green-merge.
- [ ] `.github/CODEOWNERS` is informational only.
- [ ] `SCRIPTS/validate-bootstrap.sh` fails when active authoritative policy
  reintroduces required human/maintainer/Code Owner approval as a merge gate.
- [ ] `SCRIPTS/validate-bootstrap-red-checks.sh` includes a targeted fixture
  proving the validator fails on that regression.
- [ ] Traceability, artifact registry, test results, backlog index, review
  index, and worklog are updated.
- [ ] GitHub branch protection on `main` keeps required status checks but
  does not require approving reviews or Code Owner reviews, or any remaining
  enforcement mismatch is explicitly documented as an external blocker.
- [ ] Adversarial Codex review has no unresolved P0/P1 or blocking P2
  findings.

## Parallelization

- Status: not-allowed
- File ownership boundaries: this PR touches shared governance, policy,
  validator, role, and registry files
- Shared files requiring coordination: `PR_MERGE_POLICY.md`,
  `PR_REVIEW_POLICY.md`, `GOVERNANCE.md`, `SCRIPTS/`, `memory/ai/`,
  `.github/CODEOWNERS`
- Stop conditions: unresolved P0/P1/blocking P2 review finding, failed
  required validation, scope expansion beyond bootstrap governance, GitHub
  enforcement mismatch that cannot be resolved
  from this environment
