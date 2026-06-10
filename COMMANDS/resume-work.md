artifact_id: ART-COMMAND-RESUME-WORK
title: Resume Work
type: command
status: active
version: v1.0
created: 2026-06-10
updated: 2026-06-10
owner: AI Bootstrap Maintainers
source: GEN-16 pipeline commands
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Resume Work

## Purpose

Reconstruct working context after a session break with the minimum reads:
local session state first, then the compact shared state, then only what the
in-flight task actually needs. Replaces ad-hoc full-repo re-reading.

Recognized user triggers: `Resume work`, `Resume`, `Continue where you left
off`.

## Required Role

- The role recorded in `.ai/SESSION.md`, or the role matching the in-flight
  task; default `memory/ai/ROLE_IMPLEMENTATION_AGENT.md`.

## Required Files To Read

- `.ai/SESSION.md` (first; if absent, fall back to shared state)
- `CURRENT_STATE.md`
- `AI_HANDOFF.md`
- `CONTEXT_PACKS/resume.md`
- `git status --short --branch` output

## Inputs

- The user trigger, optionally naming the task to resume.
- `.ai/SESSION.md` profile, branch, and free-form notes.
- Open PRs or dirty worktree state.

## Workflow

1. Read `.ai/SESSION.md`; run `bash SCRIPTS/doctor.sh` for branch, hooks,
   session, handoff freshness, and intake queue in one pass.
2. Cross-check the session branch against `git status`; on mismatch, trust
   git and refresh the session via `bash SCRIPTS/session.sh start <profile>`.
3. Read `CURRENT_STATE.md` and `AI_HANDOFF.md`; identify the next recommended
   action and open threads.
4. Read only the artifacts the in-flight task names (per the
   `CONTEXT_INDEX.md` section for that task); do not expand reads further
   unless evidence demands it.
5. State the reconstructed plan in one short summary, then continue the task.

## Outputs

- A one-paragraph resume summary: branch, task, profile, next action.
- Refreshed `.ai/SESSION.md` epoch.
- Continued task execution.

## Stop Conditions

- Session state contradicts git state in a way reading cannot resolve.
- The in-flight task's authority or spec status changed since the session.
- No resumable work exists; report and ask for direction.

## Validation

- `git diff --check` before any new commit; further checks per the resumed
  task's own requirements.

## Authority Limit

This command is a workflow shortcut. It grants no authority beyond the
resumed task's own, and cannot override repository governance, approved or
active specs, accepted ADRs, `CONTEXT_INDEX.md`, selected role files,
`OPERATION_ROUTING.md`, `ARTIFACT_REGISTRY.md`, `TRACEABILITY_MATRIX.md`,
`CURRENT_STATE.md`, or `AI_HANDOFF.md`.
