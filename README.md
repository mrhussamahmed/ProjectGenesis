artifact_id: ART-README
title: ProjectGenesis README
type: public-readme
status: active
version: v3.1
created: 2026-05-13
updated: 2026-06-27
owner: ProjectGenesis Maintainers
source: Public repository publication, tooling prerequisite documentation, public positioning, public launch asset links, Phase 0 validator-scope restoration, v0.2.0 public alpha release notes, BOOT-GREEN-MERGE-001 AI green-merge, GEN-01 canonical quickstart, BOOT-RESEARCH-001 research orchestration layer, and 2026-06-27 README user-guide refresh
linked_specs: [SPEC-BOOT-002]
linked_tickets: [BOOT-GREEN-MERGE-001, BOOT-RESEARCH-001]
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# ProjectGenesis

ProjectGenesis helps you turn rough product input into source-linked research, requirements, specs, backlog items, implementation work, and review evidence that AI agents can use across sessions.

Estimated reading time: 9 minutes

[Release history](RELEASE_NOTES.md) | [Full usage guide](BOOTSTRAP_USAGE.md) | [New project initialization prompt](NEW_PROJECT_INITIALIZATION.md)

## Why teams use it

AI coding agents move quickly, but they can lose the thread when project truth lives only in chat. ProjectGenesis gives agents a file-based operating model: where to read context, where to record decisions, when to stop, what must be validated, and how another agent can resume the work.

Use it when you want AI help without accepting undocumented requirements, hidden assumptions, stale handoffs, or broad unreviewable diffs.

| If this is your problem | ProjectGenesis gives you |
|---|---|
| Your idea is still rough | Intake folders, source IDs, research workflows, assumptions, risks, and open questions |
| Agents keep inventing details | Source-of-truth rules, evidence labels, traceability, and validation checks |
| Work spans many sessions | Shared state, role files, handoff files, and resume commands |
| Specs and backlog drift apart | Linked specs, backlog items, acceptance criteria, and test expectations |
| Implementation starts too early | Definition of Ready gates before coding |
| Reviews depend on memory | Fresh-context review using repository evidence |

ProjectGenesis is not an app framework, package manager, database starter, hosting template, or autonomous project manager. It is a reusable operating scaffold for AI-assisted software delivery.

## Who this is for

ProjectGenesis fits:

- founders and solo builders turning an idea into an implementation-ready plan
- AI-first developers who want agents to work from repository truth, not chat memory
- product and engineering teams that need requirements, architecture, backlog, QA, review, and handoff to stay connected
- teams using Codex, Claude, or another coding agent across repeated sessions

For a one-hour throwaway experiment, this may feel heavier than necessary. For work you expect to revisit, hand off, review, or ship, the structure pays for itself by making decisions traceable.

## What you need before you start

Required:

| Requirement | Why it is needed |
|---|---|
| Git | Branches, diffs, pull requests, and traceable changes |
| Bash | Runs the bundled scripts |
| `rsync` | Used by `SCRIPTS/scaffold-extract.sh` when creating a clean downstream scaffold |
| An AI coding agent | Reads the role files, edits repository artifacts, and runs the workflow commands |
| Product input | Notes, a product idea, a PRD, customer feedback, a feature list, or equivalent source material |

Optional:

| Tool or service | Use it when |
|---|---|
| Agent web research tools | You want `Start research` or `Validate the idea` to gather external evidence |
| GitHub | You want hosted pull requests, branch protection, and GitHub Actions validation |
| GitHub CLI (`gh`) | You want to configure repository protection from the command line |
| Linear | You want a team-facing issue tracker; Markdown remains authoritative until real Linear URLs are written back |
| Claude CLI | You want to use `SCRIPTS/start-claude.sh`; Codex reads role files directly |
| GitHub Spec Kit | You intentionally want Spec Kit alongside this scaffold |
| Document conversion tools | Your input is in PDFs, slides, spreadsheets, or images the agent cannot read directly |

No frontend, backend, database, cloud provider, or deployment stack is selected by default.

## Create a clean project scaffold

Run extraction from a ProjectGenesis checkout. The parent directory of the target must already exist, and the target cannot be inside the source repository.

```sh
bash SCRIPTS/scaffold-extract.sh --apply ../my-product
```

What this does:

1. Copies the reusable operating scaffold.
2. Excludes ProjectGenesis maintainer history.
3. Resets project-owned state files to clean starter content.
4. Writes `.bootstrap-scaffold-mode=downstream`.
5. Runs the extracted scaffold contract check.
6. Runs `bash SCRIPTS/validate-bootstrap.sh` inside the target unless you pass `--no-validate`.

Useful flags:

| Flag | Use |
|---|---|
| no flag | Dry run; previews what would happen |
| `--apply` | Writes files |
| `--force` | Allows overwriting a non-empty target after you inspect it |
| `--no-validate` | Skips only the final in-target validation step |

Manual fallback: follow [TEMPLATE_MANIFEST.md](TEMPLATE_MANIFEST.md). Do not treat a raw copy as clean unless you also apply the starter-reset and maintainer-archive rules.

## Run the first workflow

After extraction, put your source material in `00_intake/raw/`. Plain Markdown or text is easiest, but you can also add exported notes, PRD fragments, feature lists, customer feedback, or converted document text.

### Option 1: research first

Use this when the product space, competitors, feasibility, costs, or risks are still uncertain.

```text
Start research.
```

The agent plans the research depth, runs focused research tracks, sends findings through critic review, synthesizes a research brief, and pauses for your approval. Product definition consumes only an accepted research brief.

Expected outputs:

- `00_intake/research/RESEARCH_PLAN-NNN.md`
- one `00_intake/research/RR-NNN-<track>.md` file per research track
- `00_intake/research/RCR-NNN.md`
- `00_intake/research/RESEARCH_BRIEF-NNN.md`
- source registry, assumption, risk, and open-question updates

If the agent has no web research tools, this workflow must stop instead of fabricating evidence.

### Option 2: start intake directly

Use this when you already have enough product context to begin requirement breakdown.

```text
Start requirement breakdown.
```

The agent registers source files, assigns `SRC-` IDs, summarizes input, extracts requirements, records assumptions and risks, creates open questions, proposes backlog candidates, drafts specs where appropriate, identifies architecture or ADR candidates, and classifies readiness.

Expected outputs:

- `00_intake/SOURCE_REGISTRY.md`
- `00_intake/summaries/`
- `01_context/PROJECT_BRIEF.md`
- `01_context/PROJECT_CHARTER.md`
- `01_context/GLOSSARY.md`
- `01_context/CONSTRAINTS.md`
- `02_requirements/REQUIREMENTS_INDEX.md`
- `02_requirements/ASSUMPTIONS_REGISTER.md`
- `02_requirements/RISK_REGISTER.md`
- backlog candidates, draft specs, traceability rows, and validation evidence when the input is ready

This command does not authorize implementation. Coding waits until a backlog item satisfies Definition of Ready.

## Use the supported prompts

The command index is authoritative for shortcut phrases. Use the exact command prompts below for reusable workflows, and use role prompts for work that does not have a shortcut.

| Goal | Prompt to give your agent | Result |
|---|---|---|
| Run multi-track research | `Start research.` | Research plan, track reports, critic review, user-gated research brief |
| Run product intake | `Start requirement breakdown.` | Source IDs, summaries, context, requirements, assumptions, risks, backlog candidates, readiness |
| Validate high-risk assumptions | `Validate the idea` | Research notes, updated assumption confidence, refreshed project brief sections |
| Design architecture | `Start architecture design` | Tech design, slim ADRs, architecture open questions |
| Implement ready work | `Implement next story` | One scoped branch or PR for the highest-priority ready backlog story |
| Export backlog to Linear | `Export backlog to Linear` | Linear issue URLs written back, or export-ready text if no integration exists |
| Resume interrupted work | `Resume work` | Session summary and continued task execution |

The following are role prompts, not command shortcuts:

```text
Read memory/ai/SHARED_AGENT_RULES.md and memory/ai/ROLE_SPEC_AUTHOR.md.
Use the Spec And Backlog section of CONTEXT_INDEX.md.
Create a draft spec from the confirmed requirements and record open questions for anything not ready.
```

```text
Read memory/ai/SHARED_AGENT_RULES.md and memory/ai/ROLE_BACKLOG_PLANNER.md.
Turn the approved specs into sequenced backlog items, identify the first safe implementation task, and prepare Linear-ready descriptions without claiming tickets exist.
```

```text
Read memory/ai/SHARED_AGENT_RULES.md and memory/ai/ROLE_QA_REVIEWER.md.
Review the relevant specs and backlog items for acceptance-criteria coverage, missing tests, manual checks, and validation risk.
```

Avoid unsupported shortcut phrases such as `Start spec authoring`, `Start backlog planning`, or `Start QA plan` unless matching command files are added to `COMMANDS/COMMAND_INDEX.md`.

## Understand the project flow

| Stage | Owner or trigger | Main artifacts | Exit condition |
|---|---|---|---|
| Research | `Start research.` | Research plan, reports, critic review, research brief | You explicitly accept the brief |
| Intake | `Start requirement breakdown.` | Source registry, summaries, context, requirements, assumptions, risks | Readiness is classified |
| Idea validation | `Validate the idea` | Research notes and updated assumptions | High-risk assumptions have evidence or gaps |
| Spec | Spec Author role | Specs and acceptance criteria | Spec is promoted from draft to approved |
| Architecture | `Start architecture design` | Tech design and ADRs | Design is approved |
| Backlog | Backlog Planner role | Sequenced backlog items | Items are implementation-ready |
| QA | QA Reviewer role | Coverage findings and test evidence | Required coverage exists or blocking gaps are fixed before implementation |
| Implementation | `Implement next story` | Code, tests, PR evidence | PR is merged with an evidence note |
| Handoff | `Resume work` or stop checklist | `.ai/SESSION.md`, PR evidence, state files when durable truth changed | Another agent can continue safely |

## Work with GitHub, Linear, and other external tools

Markdown is the default source of truth. External systems are useful, but they do not become truth until the repository records evidence.

### GitHub

Use GitHub when you want hosted collaboration, pull requests, branch protection, and GitHub Actions validation.

Recommended controls are documented in [GITHUB_REPOSITORY_SETUP.md](GITHUB_REPOSITORY_SETUP.md). The public ProjectGenesis policy expects objective merge gates: required CI/status checks, local validation, clean scope, and no unresolved P0, P1, or blocking P2 review findings. Human, maintainer, and Code Owner approval are not required merge gates in the active policy.

### Linear

Linear is optional. Use it when your team wants a ticketing system for backlog visibility.

Codex setup:

```sh
codex mcp add linear --url https://mcp.linear.app/mcp
codex mcp login linear
```

Then ask:

```text
Export backlog to Linear
```

The export command must verify the integration, avoid duplicates, create or update issues, and write the real Linear ID or URL back to the backlog item. If no integration exists, the agent should provide export-ready text instead of claiming tickets exist.

### GitHub Spec Kit

Spec Kit is optional. Use it only when you intentionally want its external specification-driven development CLI, templates, or commands in a downstream project. If generated files overlap with ProjectGenesis specs or commands, treat that as a governance decision before implementation.

## Validate the scaffold

Run these checks before claiming the scaffold is valid:

```sh
bash SCRIPTS/doctor.sh
git config core.hooksPath .githooks
bash SCRIPTS/validate-bootstrap.sh
git diff --check
```

What they do:

| Check | Purpose |
|---|---|
| `SCRIPTS/doctor.sh` | Read-only orientation: branch, hooks, session, handoff freshness, intake queue |
| `git config core.hooksPath .githooks` | Enables the bundled commit and push hooks once per clone |
| `SCRIPTS/validate-bootstrap.sh` | Checks required files, metadata, source registry shape, assumptions, risks, command structure, traceability, and policy guards |
| `git diff --check` | Finds whitespace errors before commit |

Run the red-check harness when you change validator behavior, hooks, CI, or strict-gate rules:

```sh
bash SCRIPTS/validate-bootstrap-red-checks.sh
```

Downstream product projects should add stack-specific checks after the architecture selects a stack: formatter, linter, type check, unit tests, integration tests, build, security scan, migration checks, accessibility checks, and smoke tests as applicable.

## Keep agents on the rails

At the start of meaningful work, the agent reads:

1. `memory/ai/SHARED_AGENT_RULES.md`
2. the task-specific `memory/ai/ROLE_*.md` file
3. the minimum context and task section in `CONTEXT_INDEX.md`
4. `git status --short --branch`

Before stopping, the agent records local resume context in `.ai/SESSION.md` when unmerged work remains. It updates `CURRENT_STATE.md` and `AI_HANDOFF.md` only when durable project truth changed and should remain true on `main` after merge.

Use this Codex kickoff prompt inside a downstream project:

```text
Read AGENTS.md, then follow AI_PROJECT_BOOTSTRAP.md.
Inspect git status and the minimum context in CONTEXT_INDEX.md before acting.
Keep changes scoped, update traceability and handoff when required, and run SCRIPTS/validate-bootstrap.sh before claiming the scaffold is valid.
```

For Claude, use the role starter when available:

```sh
./SCRIPTS/start-claude.sh product
./SCRIPTS/start-claude.sh research
./SCRIPTS/start-claude.sh architecture
./SCRIPTS/start-claude.sh implementation
```

## Troubleshooting

| Symptom | Likely cause | Fix |
|---|---|---|
| `scaffold-extract.sh` says `rsync` is missing | `rsync` is not installed or not on `PATH` | Install `rsync`, then rerun the command |
| Extraction refuses the target | The target is inside the source repo, the parent directory is missing, or the target is non-empty | Choose a sibling target, create the parent directory, or use `--force` after inspection |
| Hooks do not run | `core.hooksPath` is not configured | Run `git config core.hooksPath .githooks` |
| Validation routes strict during a small task | `.ai/SESSION.md` is absent, stale, branch-mismatched, or the diff touches strict-gate paths | Run `bash SCRIPTS/session.sh start <profile> "task note"` on the branch, or accept strict validation |
| `Start research` stops | No web research tools are available, no idea exists, or the user rejected a gate | Add input under `00_intake/raw/`, enable research tools, or choose intake-first |
| Requirement breakdown stops | `00_intake/raw/` has no source material or the source is unreadable/sensitive | Add source material or provide handling guidance |
| Linear export produces text instead of tickets | No Linear integration is configured | Configure Linear, then rerun `Export backlog to Linear` |
| Implementation does not start | No backlog item satisfies Definition of Ready | Resolve open questions, approve specs, define test expectations, and clear blockers |

## Limits

- It cannot decide product direction for you when source material is unclear.
- It cannot verify external facts without available research or integration tools.
- It does not enforce GitHub branch protection by itself; configure repository settings separately.
- It does not choose your stack, database, hosting, payments provider, analytics, or ticketing system.
- It depends on agents reading and following the repository rules.
- It may be too much structure for very small experiments unless you use the workflow selectively.

## Repository map

| Path | Purpose |
|---|---|
| `00_intake/raw/` | Raw product input |
| `00_intake/research/` | Research plans, reports, critic reviews, and briefs |
| `00_intake/SOURCE_REGISTRY.md` | Source IDs and source metadata |
| `01_context/` | Product brief, charter, glossary, constraints, and UX brief |
| `02_requirements/` | Requirements, assumptions, and risks |
| `SPECS/` | Product, feature, spike, and implementation specs |
| `ADR/` | Architecture decision records |
| `BACKLOG/` | Backlog index and detailed backlog items |
| `COMMANDS/` | Reusable workflow command prompts |
| `CONTEXT_PACKS/` | Scoped read lists for common work |
| `memory/ai/` | Shared rules and role files for AI agents |
| `REVIEWS/` | Review records and review templates |
| `TESTS/` | Acceptance maps and manual validation checklists |
| `SCRIPTS/` | Extraction, validation, session, and orientation scripts |
| `.githooks/` | Local Git hooks |
| `.github/workflows/` | GitHub Actions validation workflow |
| `TEMPLATE_MANIFEST.md` | Clean scaffold extraction contract |

## License

ProjectGenesis is licensed under the GNU Affero General Public License v3.0. See [LICENSE](LICENSE).

AGPLv3 is a strong copyleft license. If you modify and run a covered network service based on this project, review the license obligations carefully. This README is not legal advice.
