# Repository Instructions For Claude

This project uses the AI Project Bootstrap operating model. Repository files
are source of truth. Chat history is non-authoritative context.

## Shared Role System

Claude follows the same shared role files as Codex:

1. Read `memory/ai/SHARED_AGENT_RULES.md`.
2. Read the relevant `memory/ai/ROLE_*.md` file for the task.
3. Read the `CONTEXT_INDEX.md` section for your task. `CONTEXT_INDEX.md` is
   the single read-list authority; do not read beyond it unless
   `OPERATION_ROUTING.md` read tiers require escalation.

Claude can optionally use `SCRIPTS/start-claude.sh` to load the role files at
startup. Claude-specific startup is convenience only. The source of truth
remains the repo files.

Before stopping, update `.ai/SESSION.md` for local resume context when there
is unmerged local work. Update committed `CURRENT_STATE.md` and
`AI_HANDOFF.md` only when durable project truth changed and the update should
remain true on `main` after merge.

`./SCRIPTS/start-claude.sh` without a mode starts default orientation-only mode.
Default mode loads shared rules but no operating role. Do not use default mode
for task work until the relevant `memory/ai/ROLE_*.md` file is read or Claude
is restarted with an allowlisted role mode.

## Claude Startup Examples

```sh
./SCRIPTS/start-claude.sh # orientation only
./SCRIPTS/start-claude.sh product
./SCRIPTS/start-claude.sh research
./SCRIPTS/start-claude.sh ux
./SCRIPTS/start-claude.sh spec
./SCRIPTS/start-claude.sh architecture
./SCRIPTS/start-claude.sh backlog
./SCRIPTS/start-claude.sh implementation
./SCRIPTS/start-claude.sh qa
./SCRIPTS/start-claude.sh security
./SCRIPTS/start-claude.sh devops
./SCRIPTS/start-claude.sh docs
./SCRIPTS/start-claude.sh review
./SCRIPTS/start-claude.sh handoff
```

## Required Reading

Read `memory/ai/SHARED_AGENT_RULES.md`, then the relevant `memory/ai/ROLE_*.md`
file, then the `CONTEXT_INDEX.md` section for your task. `CONTEXT_INDEX.md` is
the single read-list authority. Also inspect `git status --short --branch`
when Git is available.

Run SCRIPTS/session.sh start <profile> to enable scoped validation for the
session; run SCRIPTS/doctor.sh for instant orientation.

## Validation

Run `bash SCRIPTS/validate-bootstrap.sh` for bootstrap consistency. For product
implementation, also run the stack-specific checks defined in the active spec,
test strategy, or CI configuration.
