artifact_id: ART-PLAN-SPLIT-STATE-HANDOFF-001
title: Split-State Handoff Boundary Plan
type: implementation-plan
status: active
version: v0.2
created: 2026-05-17
updated: 2026-05-17
owner: AI Bootstrap Maintainers
source: User-requested planning session after PR #20 post-merge state drift; bootstrap-governance exception permitted by PR_MERGE_POLICY.md; maintainer approval in PR #21 comment 4472356122
linked_specs: []
linked_tickets: [BOOT-STATE-001]
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Split-State Handoff Boundary Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Prevent branch/session-specific AI handoff data from being committed as durable project truth while keeping development fast and multi-agent-friendly.

**Architecture:** Keep committed state files as small stable snapshots that should remain true on `main`; move tactical resume state into a gitignored local session file; move branch-shared state into PR bodies, PR comments, or review packages. Validation should catch only obvious volatile text in active canonical-state sections, and local hooks should continue to support fast-path operation profiles through the local session file.

**Tech Stack:** Markdown governance files, Bash validators and hooks, Git/GitHub PR workflow, gitignored local `.ai/SESSION.md` files.

---

## Context For Adversarial Review

This plan comes from a concrete incident in PR #20:

- PR #20 merged slice 5 reuse-boundary extraction at squash commit `97b6e9a`.
- The PR branch validation was green before merge.
- The first post-merge `main` CI run, `25989064447`, failed because the merged `AI_HANDOFF.md` still named branch `claude/sharp-shockley-6bd7a3`.
- Cleanup commit `05f01f2` reset state to `main`; CI run `25990299701` passed.
- Finalization commit `2fee759` recorded the green cleanup state and acknowledged that Codex review cycles were not durably recorded under `REVIEWS/` or GitHub review objects.

The user explicitly wants to avoid returning to heavy process. The requested solution should reduce recurring ceremony, not add a larger checklist. The high-ROI diagnosis is that committed files currently mix:

- stable project truth, such as "`main` CI is green";
- branch-shared PR truth, such as "this PR touches validators and needs review";
- local session truth, such as "this agent is in `.claude/worktrees/...` and should run the next command."

The current model asks agents to update `CURRENT_STATE.md` and `AI_HANDOFF.md` before stopping. That made sense for bootstrap setup, but it creates merge drift when those committed files contain feature-branch reality. The goal is to keep the repo source-of-truth model while separating volatile state from durable state.

## Recommendation Summary

Implement a split-state model:

| Layer | Storage | Purpose | Shared With Other Agents | Committed |
|---|---|---|---|---|
| Canonical state | `CURRENT_STATE.md`, `AI_HANDOFF.md` | Stable baseline true on `main` after merge | Yes | Yes |
| PR state | PR body/comment or `REVIEWS/templates/PR_REVIEW_PACKAGE_TEMPLATE.md` instance | Branch-specific shared status, review evidence, scope, validation | Yes | Usually no, unless review package is committed |
| Local session state | `.ai/SESSION.md` | One agent's tactical resume notes and operation profile | No | No |

Do not introduce SQLite or a broader YAML state system in this slice. A database or YAML migration may be revisited only if agents keep corrupting Markdown snapshots after this boundary split. The current problem is not file format; it is mixing temporary session facts into committed state.

## Non-Goals

- Do not build a database.
- Do not convert all state files to YAML.
- Do not require every normal PR to add committed review records.
- Do not force post-merge cleanup commits as a normal workflow.
- Do not make canonical state a growing diary.
- Do not weaken review or validation for protected mechanics.

## Readiness Gate

This draft plan is not implementation-ready by itself. Before any agent starts
Task 1 or later, the implementation branch must first establish one of these
authorities:

- an approved or active spec plus a linked backlog item or ticket; or
- an explicit maintainer-approved bootstrap-governance exception recorded in
  `PR_MERGE_POLICY.md`, `BACKLOG.md`, `BACKLOG/BACKLOG_INDEX.md`,
  `TRACEABILITY_MATRIX.md`, and the PR review package.

The selected authority must be linked in this plan's metadata, PR evidence, and
traceability row before implementation starts. This gate exists because the
implementation touches governance, validators, hooks, role files, and review
policy, which route as `strict-protected`.

Recommended path for lowest process overhead: first add a bounded recurring
bootstrap-governance exception to `PR_MERGE_POLICY.md`, then use that exception
and record the work as backlog item
`BACKLOG/BOOT-STATE-001-split-state-handoff.md`, with index rows in
`BACKLOG.md`, `BACKLOG/BACKLOG_INDEX.md`, and `TRACEABILITY_MATRIX.md`.
Path B is not valid until `PR_MERGE_POLICY.md` explicitly permits that
exception class.

Task 0 selected Path B as the lowest-overhead candidate path.
`PR_MERGE_POLICY.md` now permits the bounded recurring bootstrap-governance
exception, and `BOOT-STATE-001` records the backlog authority for this
implementation. Path B maintainer approval evidence is recorded at
PR #21 comment 4472356122.

## Acceptance Criteria

- `CURRENT_STATE.md` and `AI_HANDOFF.md` describe stable repo baseline and do not require updates for every feature branch.
- Branch/worktree/session details can be recorded in `.ai/SESSION.md`, which is gitignored and not source of truth.
- Shared branch state has a clear home in PR body/comments or PR review package fields.
- `SCRIPTS/operation-profile.sh` can read operation profile from `.ai/SESSION.md` for local hooks, falling back safely to strict behavior when absent.
- `SCRIPTS/validate-bootstrap.sh` no longer fails feature-branch validation merely because canonical `AI_HANDOFF.md` says `main`.
- Validator rejects obvious volatile session text in active canonical-state sections.
- Red checks cover local-session ignore behavior, local operation-profile extraction, and canonical volatile-state rejection.
- `AI_HANDOFF.md` is trimmed to a current snapshot rather than accumulated slice history.
- Instructions in `AGENTS.md`, `CLAUDE.md`, `memory/ai/SHARED_AGENT_RULES.md`, and relevant role/policy files do not contradict the split-state model.
- The implementation PR is prepared for fresh-context adversarial review with this plan as required context.
- The implementation has an approved/active spec and backlog item, or an
  explicit maintainer-approved bootstrap-governance exception permitted by
  `PR_MERGE_POLICY.md`, before any protected-file implementation begins.
- Durable operation classification for shared work lives in PR/review evidence,
  not in `.ai/SESSION.md`; local session state is only a hook hint.

## Risk Register And Mitigations

| Risk | Why It Matters | Mitigation In This Plan |
|---|---|---|
| Local session state is invisible to other agents | Parallel agents could duplicate or conflict | Shared/protected work must open a draft PR or issue early; local session is only for private resume notes |
| Important decisions stay local | Future agents cannot recover assumptions or accepted risks | Local session file is forbidden for decisions, accepted risks, review findings, spec changes, and merge evidence |
| Operation profile currently depends on `AI_HANDOFF.md` | Removing branch updates from `AI_HANDOFF.md` could break fast-path hooks | Move profile lookup to `.ai/SESSION.md` first, with safe strict fallback |
| PR comments become noisy | Branch state could scatter across many comments | Use one PR status section/comment or a review package field; update in place when practical |
| Local session file grows stale | Agents may resume from outdated local scratch | Header marks it non-authoritative; include branch and timestamp; agent must verify `git status` |
| Validator false positives | Historical references to old branches could block legitimate docs | Scan only active canonical sections, not all prose |
| Existing instructions conflict | Agents will follow older "always update committed handoff" language | Update all agent entrypoints and shared rules in the same PR |
| Repo history still grows | Moving notes between committed files would not solve bloat | Canonical files become replace-in-place snapshots; historical proof lives in Git, PRs, CI, and rare archives |
| Review evidence becomes chat-only | PR #20 already exposed this gap | Policy says normal reviews may live in GitHub; high-risk/governance reviews need a durable PR review object or committed `REVIEWS/` record |
| Multi-agent coordination becomes weaker | `CURRENT_STATE.md` will not list every active branch | Draft PRs/issues become the coordination board; `CURRENT_STATE.md` remains baseline |
| Overbuilding storage | YAML or DB work could distract from the real boundary issue | Defer file-format changes until there is evidence Markdown snapshots remain unreliable |
| Stale local session selects fast path | A leftover `.ai/SESSION.md` could keep returning `docs-trivial` | Require branch, profile, and epoch timestamp; fall back to strict on missing, mismatched, unrecognized, or stale session data |
| Durable operation evidence disappears | Moving classification out of `AI_HANDOFF.md` could leave no reviewable proof | Move durable classification to PR/review package evidence; update validator to stop requiring it in canonical handoff and add review-template checks |
| Bootstrap exception conflicts with merge policy | A backlog-only exception would still be unmergeable under stricter policy | Path B must first update `PR_MERGE_POLICY.md` with bounded recurring exception criteria; otherwise Path A is mandatory |

## File Ownership Map

The implementation should be a single coordinated PR because it changes policy and validators together.

| File Or Family | Responsibility |
|---|---|
| `.gitignore` | Add `.ai/` so local session files cannot be committed |
| `AGENTS.md`, `CLAUDE.md` | Replace "always update committed state before stopping" with split-state rules |
| `memory/ai/SHARED_AGENT_RULES.md` | Define canonical, PR, and local session state boundaries |
| `memory/ai/ROLE_*.md` | Align every role-specific stopping, review, and planning requirement so no role still requires unconditional committed state updates |
| `BRANCH_AND_WORKTREE_GUIDE.md` | Define local session file behavior and multi-agent draft PR visibility |
| `OPERATION_ROUTING.md` | Define local session as a non-durable hook hint and PR/review evidence as the durable operation-classification surface |
| `PR_REVIEW_POLICY.md`, `PR_MERGE_POLICY.md` | Require branch-specific shared state in PR evidence, not canonical state; add a bounded recurring bootstrap-governance exception before Path B can be used |
| `REVIEWS/templates/PR_REVIEW_PACKAGE_TEMPLATE.md` | Add branch status and review-evidence fields for shared PR state |
| `SCRIPTS/operation-profile.sh` | Read `.ai/SESSION.md` first; fallback to `AI_HANDOFF.md` only for compatibility; default strict |
| `SCRIPTS/validate-bootstrap.sh` | Prune `.ai/`; remove branch-equality check; add active-section volatile-state guard |
| `SCRIPTS/validate-bootstrap-red-checks.sh` | Add fixtures for split-state behavior |
| `AI_HANDOFF.md`, `CURRENT_STATE.md`, `TEST_RESULTS.md` | Final compact snapshot and validation evidence for this change |
| `ARTIFACT_REGISTRY.md`, `TRACEABILITY_MATRIX.md` | Register material policy/validator/template changes |

## Task 0: Establish Implementation Authority

**Files:**
- Create: `BACKLOG/BOOT-STATE-001-split-state-handoff.md`
- Modify: `PR_MERGE_POLICY.md`
- Modify: `BACKLOG.md`
- Modify: `BACKLOG/BACKLOG_INDEX.md`
- Modify: `TRACEABILITY_MATRIX.md`
- Modify: `docs/superpowers/plans/2026-05-17-split-state-handoff.md`

- [x] **Step 1: Choose the authority path**

Use one of these paths before implementation:

```text
Path A: approved/active spec + backlog item
Path B: explicit bootstrap-governance exception approved by maintainers
```

Do not start protected implementation until the selected path is recorded.
The recommended path is Path B because the user explicitly wants to avoid a
large process expansion for a targeted governance ergonomics fix.
Path B is invalid until `PR_MERGE_POLICY.md` is updated to allow it.

Selected candidate authority: Path B, based on the recurring
bootstrap-governance exception added to `PR_MERGE_POLICY.md`. Explicit
maintainer approval for this PR is recorded at
PR #21 comment 4472356122;
the second adversarial re-review is review evidence only and does not satisfy
maintainer approval.

- [x] **Step 2: Add the bounded recurring bootstrap-governance exception**

Before using Path B, update `PR_MERGE_POLICY.md` with a new section after
`## Bootstrap Baseline Exception` named:

```md
## Recurring Bootstrap Governance Exception
```

The exception criteria must be bounded:

```md
A bootstrap-governance PR may merge without an approved or active spec only
when all of these are true:

- a maintainer explicitly approves using this exception for the PR;
- the change is limited to bootstrap governance, agent instructions, review
  policy, merge policy, validation scripts, hooks, CI checks, templates,
  shared-state mechanics, or documentation for the bootstrap operating model;
- the PR links to a backlog item or ticket describing the governance work;
- `TRACEABILITY_MATRIX.md` maps the governance requirement, implementation,
  tests, and review evidence;
- `ARTIFACT_REGISTRY.md`, `CURRENT_STATE.md`, `AI_HANDOFF.md`, and
  `TEST_RESULTS.md` are updated when impacted;
- operation classification and final evidence are durable in PR/review
  evidence, not only in local session files;
- `bash SCRIPTS/validate-bootstrap.sh`, relevant red checks, shell syntax
  checks, `git diff --check`, and CI pass unless a skipped check is explicitly
  documented and accepted;
- fresh adversarial review is complete with no unresolved P0/P1 findings and
  no unresolved blocking P2 findings.

This exception must not be used for product implementation, runtime code,
schemas, APIs, migrations, dependencies, deployment changes, security-sensitive
runtime behavior, or architecture-sensitive product decisions.
```

If maintainers reject this merge-policy exception, stop using Path B and switch
to Path A.

- [x] **Step 3: Record the selected authority**

Create `BACKLOG/BOOT-STATE-001-split-state-handoff.md` using the backlog item
template. Mark it as a bootstrap-governance exception for reducing
state/handoff process overhead, not a product implementation spec. Link it to
the new recurring bootstrap-governance exception section in
`PR_MERGE_POLICY.md`.

- [x] **Step 4: Update this plan metadata**

Update this plan's `linked_tickets` metadata to include `[BOOT-STATE-001]`,
keep `linked_specs: []`, and update the source field to mention the
bootstrap-governance exception permitted by `PR_MERGE_POLICY.md` plus the
per-PR maintainer approval evidence requirement.

- [x] **Step 5: Re-run review readiness check**

Confirm the PR review package can point to the selected authority and that
`PR_MERGE_POLICY.md` requirements are either satisfied by Path A or explicitly
excepted by the new bounded recurring bootstrap-governance exception.

Review readiness check: future PR evidence can point to
`PR_MERGE_POLICY.md`, `BACKLOG/BOOT-STATE-001-split-state-handoff.md`,
`BACKLOG.md`, `BACKLOG/BACKLOG_INDEX.md`, and `TRACEABILITY_MATRIX.md` for
the candidate Path B policy/backlog authority. Explicit maintainer approval
evidence is recorded in PR #21 comment 4472356122.

## Task 1: Create Local Session Boundary

**Files:**
- Modify: `.gitignore`
- Modify: `BRANCH_AND_WORKTREE_GUIDE.md`
- Modify: `AGENTS.md`
- Modify: `CLAUDE.md`

- [x] **Step 1: Add `.ai/` to `.gitignore`**

Add a line:

```gitignore
.ai/
```

Expected effect: `.ai/SESSION.md` and other local AI scratch files cannot be accidentally committed.

- [x] **Step 2: Define the local session file in `BRANCH_AND_WORKTREE_GUIDE.md`**

Add a section named `## Local Session Handoff` with these rules:

```md
## Local Session Handoff

Agents may use `.ai/SESSION.md` as a gitignored local resume aid for one worktree.
It is not source of truth and must not contain decisions, accepted risks,
review findings, spec changes, or merge evidence.

Allowed local-session content:

- current branch and worktree path
- operation profile for local hooks
- next local command
- dirty files observed in this worktree
- short tactical notes needed to resume the same worktree

Shared branch state belongs in the PR body, PR comments, issue, or review
package. Durable project truth belongs in committed repository files.
```

- [x] **Step 3: Update agent entrypoints**

In `AGENTS.md` and `CLAUDE.md`, replace any rule equivalent to "must update `CURRENT_STATE.md` and `AI_HANDOFF.md` before stopping" with:

```md
Before stopping, update `.ai/SESSION.md` for local resume context when there is
unmerged local work. Update committed `CURRENT_STATE.md` and `AI_HANDOFF.md`
only when durable project truth changed and the update should remain true on
`main` after merge.
```

- [x] **Step 4: Validate the local-session boundary**

Run:

```sh
git status --short --branch
git check-ignore .ai/SESSION.md
```

Expected:

```text
.ai/SESSION.md
```

## Task 2: Align Shared Agent Rules And All Roles

**Files:**
- Modify: `memory/ai/SHARED_AGENT_RULES.md`
- Modify: every file matching `memory/ai/ROLE_*.md`

- [x] **Step 1: Add split-state definitions to shared rules**

Add a concise section:

```md
## State Boundary

Committed state files describe durable project truth that should remain true
on `main` after merge. They are not per-agent scratchpads.

Branch-specific shared state belongs in a PR, issue, or review package.
Local resume state belongs in gitignored `.ai/SESSION.md`.

Agents must not record temporary worktree paths, feature-branch "current"
state, or "awaiting merge" instructions as active facts in committed
`CURRENT_STATE.md` or `AI_HANDOFF.md`.
```

- [x] **Step 2: Update every role's stopping requirements**

For every `memory/ai/ROLE_*.md` file, replace unconditional requirements to
update committed `CURRENT_STATE.md` or `AI_HANDOFF.md` before stopping with
split-state language:

```md
For unmerged branch work, record tactical resume details in `.ai/SESSION.md`
and shared branch status in the PR body or review package. Update committed
state only for durable changes that should remain true on `main`.
```

- [x] **Step 3: Keep documentation curator stronger, not contradictory**

Clarify that the curator maintains canonical snapshots and should trim
accumulated diary history:

```md
When curating state, prefer replace-in-place current snapshots. Do not append
session diaries to canonical state files. Link to PRs, commits, CI runs, and
rare archives for history.
```

- [x] **Step 4: Keep adversarial reviewer stronger, not contradictory**

Add a check:

```md
Verify committed state files do not contain active branch/session facts that
will become false after merge. Branch-specific status must be in PR evidence,
not canonical state.
```

- [x] **Step 5: Keep backlog planner parallel-work guidance**

Add a note:

```md
Use PRs or issues to coordinate parallel branches. Do not use
`CURRENT_STATE.md` as a live board of every active branch.
```

- [x] **Step 6: Add a role-file contradiction check**

Add a validator or red-check assertion that fails if any `memory/ai/ROLE_*.md`
still contains an unconditional committed-state stopping rule without the
durable-truth qualifier.

## Task 3: Move Operation Profile To Local Session For Hooks

**Files:**
- Modify: `SCRIPTS/operation-profile.sh`
- Modify: `.githooks/pre-commit`
- Modify: `.githooks/pre-push`

- [x] **Step 1: Change operation profile precedence**

`SCRIPTS/operation-profile.sh` should read profile in this order:

1. valid `.ai/SESSION.md` keys:
   - `operation_profile: docs-trivial`
   - `branch: current-branch-name`
   - `updated_at_epoch: 1770000000`
2. legacy `AI_HANDOFF.md` most recent `Pre-Change Classification`
3. `unknown`

Accepted profile names remain the names listed in `OPERATION_ROUTING.md`.
The local session value is only a hook hint. Durable operation evidence for
shared/protected work must live in PR or review package evidence.

- [x] **Step 2: Add a session parser**

Use a narrow parser that accepts only a simple key:

```sh
extract_profile_from_local_session() {
  local file=".ai/SESSION.md"
  [[ -f "$file" ]] || { echo "unknown"; return; }
  awk -F: '
    /^[[:space:]]*operation_profile[[:space:]]*:/ {
      value = $2
      gsub(/`/, "", value)
      gsub(/^[ \t]+|[ \t]+$/, "", value)
      sub(/[[:space:]].*$/, "", value)
      print value
      found = 1
      exit
    }
    END { if (!found) print "unknown" }
  ' "$file"
}
```

- [x] **Step 3: Enforce branch and freshness checks**

The parser must fall back to `unknown` when:

- `branch:` is absent;
- `branch:` does not match `git branch --show-current`;
- `updated_at_epoch:` is absent, non-numeric, or older than the configured
  local session TTL;
- `operation_profile:` is absent or not one of the known profiles.

Use an epoch-based check to avoid macOS/GNU `date` parsing differences:

```sh
now_epoch="$(date +%s)"
session_ttl_seconds="${BOOTSTRAP_SESSION_TTL_SECONDS:-43200}"
```

If `now_epoch - updated_at_epoch > session_ttl_seconds`, return `unknown`.

- [x] **Step 4: Keep strict fallback**

If profile is missing or unrecognized, hooks and validator must behave as strict. This preserves safety when no local session exists in CI.

- [x] **Step 5: Update hook comments**

Change comments in `.githooks/pre-commit` and `.githooks/pre-push` so they no longer describe `AI_HANDOFF.md` as the primary fast-path signal. They should say local session profile is primary and strict fallback is default.

- [x] **Step 6: Run shell syntax checks**

Run:

```sh
for f in SCRIPTS/operation-profile.sh .githooks/pre-commit .githooks/pre-push; do
  bash -n "$f"
done
```

Expected: no output, exit status `0`.

## Task 4: Make Canonical State Merge-Safe

**Files:**
- Modify: `AI_HANDOFF.md`
- Modify: `CURRENT_STATE.md`
- Modify: `TEST_RESULTS.md`

- [x] **Step 1: Trim `AI_HANDOFF.md` to current snapshot**

Remove accumulated slice envelopes from the active handoff and replace them with compact links to PRs/commits already in Git/GitHub. Keep only current operational facts needed by the next agent.

The active handoff should state:

```md
## Current In-Progress Task

None. Resume normal development from the clean scaffold boundary baseline.
Branch-specific session state belongs outside this committed file per the
split-state rules.
```

- [x] **Step 2: Keep canonical branch stable**

`AI_HANDOFF.md` and `CURRENT_STATE.md` may keep their existing branch/worktree section names for validator compatibility, but their semantics become canonical:

```md
## Current Branch

`main`

## Current Worktree

repository root
```

- [x] **Step 3: Replace history with links**

For historical detail, include only compact references:

```md
Recent baseline: slice 5 merged through PR #20 at `97b6e9a`; post-merge
cleanup and finalization landed at `05f01f2` and `2fee759`.
```

Do not retain multi-paragraph evidence envelopes in active state once their PRs and CI runs are durable elsewhere.

- [x] **Step 4: Update `TEST_RESULTS.md` as latest-pointer table**

Keep the latest green validation pointer and failed-run note only when it remains useful for understanding current state. Avoid appending every local run.

## Task 5: Update PR And Review Surfaces For Branch State

**Files:**
- Modify: `PR_REVIEW_POLICY.md`
- Modify: `PR_MERGE_POLICY.md`
- Modify: `REVIEWS/templates/PR_REVIEW_PACKAGE_TEMPLATE.md`
- Modify: `REVIEWS/templates/ADVERSARIAL_PR_REVIEW_TEMPLATE.md`

- [x] **Step 1: Verify recurring exception criteria are present**

Confirm `PR_MERGE_POLICY.md` contains the bounded recurring
bootstrap-governance exception from Task 0 before the implementation PR uses
Path B. If the section is absent, the implementation must use Path A.

- [x] **Step 2: Move branch-specific status into PR evidence**

Add this rule to PR policy:

```md
Branch-specific current status, active worktree, next branch action, and
temporary validation state belong in the PR body, PR comments, or review
package. They must not be active facts in committed canonical state files.
```

- [x] **Step 3: Keep durable review evidence lightweight**

Add:

```md
Normal low-risk PR review evidence may live in GitHub PR reviews or PR
comments. High-risk, governance, validator, hook, CI, role, or source-of-truth
changes need a durable review object: either a GitHub review object or a
committed review record under `REVIEWS/`.
```

- [x] **Step 4: Add PR status fields to review package template**

Add fields:

```md
## Branch-Specific State

- Branch:
- Worktree:
- Owner agent:
- Current branch status:
- Next branch action:
- Shared/protected files touched:
- Coordination notes for parallel agents:
```

- [x] **Step 5: Add reviewer check**

In the adversarial review template, add:

```md
## Split-State Review

- Canonical state remains merge-safe:
- Branch-specific status is in PR evidence:
- Local session facts are not committed:
- Review evidence durability is appropriate for risk:
```

## Task 6: Add Narrow Validator Guards

**Files:**
- Modify: `SCRIPTS/validate-bootstrap.sh`

- [x] **Step 1: Prune `.ai/` from Markdown scans**

Where the validator prunes `.git`, `.claude`, and `research`, add `.ai` so local session files are never treated as committed artifacts.

- [x] **Step 2: Remove canonical branch-equality check**

Remove or disable the check that compares `AI_HANDOFF.md`'s `Current Branch` section to `git branch --show-current`. That check caused the workflow to require feature-branch facts in committed state.

- [x] **Step 3: Move durable operation-evidence checks out of canonical handoff**

Remove validator requirements that committed `AI_HANDOFF.md` always contains:

- `Pre-Change Classification`
- `Operation profile:`
- protected-file classification sections parsed from `AI_HANDOFF.md`

Replace them with these validations:

- `OPERATION_ROUTING.md` defines valid durable evidence locations: PR body,
  PR comment, committed PR review package, committed review record, or
  explicitly approved bootstrap-governance exception;
- `REVIEWS/templates/PR_REVIEW_PACKAGE_TEMPLATE.md` contains operation
  classification and final evidence fields;
- `REVIEWS/templates/ADVERSARIAL_PR_REVIEW_TEMPLATE.md` contains a check for
  split-state and operation-evidence durability;
- canonical `AI_HANDOFF.md` can be a compact current snapshot with no
  pre-change classification block.

Local `.ai/SESSION.md` must not be accepted as durable evidence by the
validator or review policy. It is only an input to local hook profile selection.

- [x] **Step 4: Add active-section volatile-state guard**

Add a function that scans only active canonical sections, not all prose:

- `## Current Branch`
- `## Current Worktree`
- `## Current In-Progress Task`
- `## Dirty Worktree Status`
- `## Next Recommended Action`

Reject these patterns inside those sections:

- `.claude/worktrees/`
- active branch names beginning with `claude/` or `codex/`
- phrases matching `awaiting .*merge`
- phrases matching `push .*cleanup`
- phrases matching `verify .*CI`
- claims that `.ai/SESSION.md` is canonical source of truth, durable evidence,
  or shared review evidence

The check should not reject historical links, review notes, or examples outside active sections.
It should also allow neutral wording such as "branch-specific session state
belongs outside this committed file per split-state rules."

- [x] **Step 5: Run validator**

Run:

```sh
bash SCRIPTS/validate-bootstrap.sh
```

Expected:

```text
Bootstrap validation passed.
```

## Task 7: Add Red-Check Coverage

**Files:**
- Modify: `SCRIPTS/validate-bootstrap-red-checks.sh`

- [x] **Step 1: Add volatile active-state failure fixture**

Create a copied repo fixture that writes `.claude/worktrees/example` into `AI_HANDOFF.md`'s active `Current Worktree` section and expects validator failure text:

```text
canonical state contains active volatile session text
```

- [x] **Step 2: Add local session ignore fixture**

Create a fixture with `.ai/SESSION.md` containing branch/worktree local data. Expected result: validator passes because `.ai/` is gitignored and pruned.

- [x] **Step 3: Add operation profile extraction fixture**

Create a fixture with:

```sh
fixture_branch="$(git -C "$dir" branch --show-current)"
now_epoch="$(date +%s)"
mkdir -p "$dir/.ai"
cat >"$dir/.ai/SESSION.md" <<EOF
operation_profile: docs-trivial
branch: $fixture_branch
updated_at_epoch: $now_epoch
worktree: local scratch
EOF
```

Run:

```sh
bash SCRIPTS/operation-profile.sh --validator-level
```

Expected:

```text
shape-only
```

- [x] **Step 4: Add strict fallback fixture**

Run operation-profile extraction with no `.ai/SESSION.md` and no current operation profile. Expected validator level:

```text
strict
```

- [x] **Step 5: Add stale local session fixture**

Create a fixture where `.ai/SESSION.md` has a matching branch and recognized
profile but `updated_at_epoch: 1`. Run:

```sh
BOOTSTRAP_SESSION_TTL_SECONDS=60 bash SCRIPTS/operation-profile.sh --validator-level
```

Expected:

```text
strict
```

- [x] **Step 6: Add branch-mismatch local session fixture**

Create a fixture where `.ai/SESSION.md` has `branch: different-branch` and a
fresh timestamp. Expected validator level:

```text
strict
```

- [x] **Step 7: Add canonical allowed-wording fixture**

Create a fixture where `AI_HANDOFF.md` active sections say only:

```md
Branch-specific session state belongs outside this committed file per the
split-state rules.
```

Expected: validator passes. This protects against the `.ai/SESSION.md`
false-positive class from returning later.

- [x] **Step 8: Add canonical handoff-without-classification fixture**

Create a fixture where `AI_HANDOFF.md` has no `Pre-Change Classification` or
`Operation profile:` block. Expected: validator passes as long as required
current snapshot sections exist.

- [x] **Step 9: Run red checks**

Run:

```sh
bash SCRIPTS/validate-bootstrap-red-checks.sh
```

Expected:

```text
Bootstrap red checks passed.
```

## Task 8: Update Routing And Historical Data Policy

**Files:**
- Modify: `OPERATION_ROUTING.md`
- Modify: `GOVERNANCE.md`
- Modify: `WORKLOG/WORKLOG_INDEX.md`

- [x] **Step 1: Define current-state versus history**

Add:

```md
Committed current-state files are replace-in-place snapshots. They should not
accumulate session diaries. Historical proof should live in Git commits,
GitHub PRs, CI run links, review records when risk requires them, and rare
milestone archives.
```

- [x] **Step 2: Define when committed state changes**

Committed state changes only when one of these changes:

- durable project baseline;
- active blocker;
- accepted spec/backlog/ADR status;
- release or validation baseline;
- known risk affecting future work.

Normal branch progress does not change canonical state.

- [x] **Step 3: Preserve operation routing without burden**

Operation classification may be recorded in `.ai/SESSION.md` for local work and in PR evidence for shared review. Only durable policy or project-state changes need committed state updates.

- [x] **Step 4: Define durable operation evidence locations**

Add explicit routing language:

```md
`.ai/SESSION.md` is not durable operation evidence. Durable operation evidence
for shared or protected work must live in one of: PR body, PR comment,
committed PR review package, committed review record, or an explicitly
approved bootstrap-governance exception.
```

## Task 9: Update Registry, Traceability, And Final Evidence

**Files:**
- Modify: `ARTIFACT_REGISTRY.md`
- Modify: `TRACEABILITY_MATRIX.md`
- Modify: `TEST_RESULTS.md`
- Modify: `AI_HANDOFF.md`
- Modify: `CURRENT_STATE.md`

- [x] **Step 1: Register new or changed artifacts**

If the implementation adds a new tracked plan or template file, register it in `ARTIFACT_REGISTRY.md`. Do not register `.ai/SESSION.md` because it is gitignored local scratch.

- [x] **Step 2: Add traceability row**

Add one compact row mapping the split-state requirement to:

- agent entrypoint docs;
- local session boundary;
- operation-profile parser;
- validator guard;
- red-check fixtures.

- [x] **Step 3: Record validation**

Record only the final relevant validation results:

- `bash SCRIPTS/validate-bootstrap.sh`
- `bash SCRIPTS/validate-bootstrap-red-checks.sh`
- `for f in SCRIPTS/operation-profile.sh .githooks/pre-commit .githooks/pre-push SCRIPTS/validate-bootstrap.sh SCRIPTS/validate-bootstrap-red-checks.sh; do bash -n "$f"; done`
- `git diff --check`
- GitHub Actions after PR push

- [x] **Step 4: Final canonical state**

At the end of the implementation PR, committed `CURRENT_STATE.md` and `AI_HANDOFF.md` should remain merge-safe. They should not say the implementation branch is current. Branch status should be in the PR.

## Task 10: Prepare Adversarial Review Package

**Files:**
- Create or modify: `REVIEWS/PR_REVIEW_PACKAGE-split-state-handoff.md` or PR body for context
- Create or modify: `REVIEWS/REVIEW-2026-05-17-split-state-handoff-implementation.md` unless a GitHub PR review object is used

- [x] **Step 1: Include this plan as required context**

The review package must link to this file:

```text
docs/superpowers/plans/2026-05-17-split-state-handoff.md
```

- [x] **Step 2: Include the problem statement**

Include:

```md
Problem: PR #20 showed that committed `AI_HANDOFF.md` can contain feature
branch reality that becomes false on `main`, causing post-merge CI failure.
The fix must prevent recurrence without making normal development process-heavy.
```

- [x] **Step 3: Include anti-goals**

Include:

```md
Anti-goals: no database, no full YAML state migration, no per-PR committed
diary, no mandatory post-merge cleanup, no heavy checklist replacing the
current problem.
```

- [x] **Step 4: Ask adversarial review questions**

Ask the reviewer to answer:

1. Does the plan actually reduce per-PR process compared with current state?
2. Does `.ai/SESSION.md` create unacceptable hidden-state risk for multiple agents?
3. Does moving operation profile out of committed handoff preserve fast-path validation safely?
4. Are canonical state files still useful after branch/session data moves out?
5. Are the validator guards narrow enough to avoid false positives?
6. Is the review evidence policy clear enough to avoid another chat-only review gap?
7. Does the plan avoid repo-history bloat?
8. Are there any contradictions with existing governance, role files, or hook behavior?

- [x] **Step 5: Require durable high-risk review evidence**

Because this implementation touches governance, validators, hooks, role files,
and review policy, PR-body-only evidence is not enough. The implementation PR
must have one of:

- a GitHub PR review object from the adversarial reviewer; or
- a committed review record under `REVIEWS/` registered in
  `REVIEWS/REVIEW_INDEX.md`.

The PR body or PR review package may provide context, but it is not by itself
the review decision.

- [x] **Step 6: Require review decision**

The adversarial reviewer should return one of:

- approve plan;
- approve with minor comments;
- request changes;
- block.

P1 blockers must be resolved before implementation.

## Validation Commands For The Implementation PR

Run these before requesting review:

```sh
git status --short --branch
bash SCRIPTS/validate-bootstrap.sh
bash SCRIPTS/validate-bootstrap-red-checks.sh
for f in SCRIPTS/operation-profile.sh .githooks/pre-commit .githooks/pre-push SCRIPTS/validate-bootstrap.sh SCRIPTS/validate-bootstrap-red-checks.sh; do
  bash -n "$f"
done
git diff --check
```

Expected final tracked status before PR on the recommended implementation branch:

```text
## codex/split-state-handoff
```

Untracked `.ai/` is allowed only if it is local scratch and ignored by Git.

## Self-Review

- Spec coverage: The plan covers split-state storage, multi-agent coordination, local session visibility risk, operation-profile hook dependency, canonical state bloat, review evidence durability, validator false positives, and the decision not to introduce YAML or a database now.
- Placeholder scan: This plan contains no unresolved placeholder markers and uses concrete file paths and expected commands.
- Scope check: This is one governance/validator slice. It should not be split unless adversarial review decides to separate policy edits from script edits.
- Ambiguity check: The boundary rule is explicit: local means one-agent resume, PR means branch-shared, committed means durable `main` truth.

## Recommended Review Disposition

This plan should receive fresh-context adversarial review before implementation because it touches governance, role instructions, hooks, validators, and review policy. The reviewer should be asked to challenge whether the plan is truly lower-friction than the current model. If review finds that the validator/script work is too broad, the first fallback is to implement only the instruction boundary plus `.gitignore` and PR template changes, leaving hook changes for a second PR.
