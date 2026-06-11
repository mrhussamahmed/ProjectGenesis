artifact_id: ART-README
title: ProjectGenesis README
type: public-readme
status: active
version: v3.0
created: 2026-05-13
updated: 2026-06-11
owner: ProjectGenesis Maintainers
source: Public repository publication, tooling prerequisite documentation, public positioning, public launch asset links, Phase 0 validator-scope restoration, v0.2.0 public alpha release notes, BOOT-GREEN-MERGE-001 AI green-merge, GEN-01 canonical quickstart, BOOT-RESEARCH-001 research orchestration layer
linked_specs: [SPEC-BOOT-002]
linked_tickets: [BOOT-GREEN-MERGE-001, BOOT-RESEARCH-001]
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# ProjectGenesis

**Build with AI speed without losing project control.**

ProjectGenesis is a reusable, AI-native software delivery scaffold for founders,
solo builders, vibe coders, product teams, and engineering teams who want AI
agents to help plan and build software without turning rough ideas into
unverifiable guesses.

Latest release: [ProjectGenesis v0.2.0 Public Alpha](https://github.com/mrhussamahmed/ProjectGenesis/releases/tag/v0.2.0-public-alpha).

See [RELEASE_NOTES.md](RELEASE_NOTES.md) for release history.

---

## The Problem

AI-assisted development often breaks down when agents:

- invent requirements or architecture from weak context
- forget decisions across sessions
- make large unreviewable changes
- skip validation or handoff updates
- create specs, backlog, and reviews that do not trace back to evidence

ProjectGenesis reduces those risks by putting project truth in versioned files
that every agent reads, updates, and traces before doing meaningful work.

---

## What It Covers

ProjectGenesis covers the full upstream pipeline — from raw idea to
implementation-ready tasks:

| Stage | Command | What Happens |
|-------|---------|-------------|
| **Research** (optional) | `Start research.` | AI researches the market, competitors, user needs, feasibility, and risks. A critic challenges the findings. You approve the brief before it feeds product definition. |
| **Intake** | `Start requirement breakdown.` | Raw notes and ideas are registered, summarized, and labeled — confirmed, inferred, or assumption. |
| **Requirements** | (part of intake) | Requirements are extracted with source IDs, confidence levels, and traceability links. Assumptions and risks are recorded explicitly. |
| **Specs** | `Start spec authoring.` | Draft specs are written when appropriate. Specs gate backlog items and block implementation for unclear or high-risk requirements. |
| **Backlog** | `Start backlog planning.` | Epics, features, stories, spikes, and validation tasks are created with acceptance criteria and Definition of Ready. |
| **Architecture** | `Start architecture design.` | High-impact decisions go into Architecture Decision Records with options, evidence, trade-offs, and approval status. |
| **Validation** | `Start QA plan.` | Acceptance criteria, manual checklists, and test expectations are mapped before coding. |
| **Implementation** | (your agent) | Code is written only after the task satisfies Definition of Ready. Fresh-context adversarial review is required before merging. |

---

## Quick Start

### Option A — Research-first (recommended for new product ideas)

```sh
# 1. Extract a clean scaffold into your new project
bash SCRIPTS/scaffold-extract.sh --apply <target-directory>
# — or copy manually following TEMPLATE_MANIFEST.md —

# 2. Drop raw material (notes, PRDs, rough ideas, screenshots) into intake
cp your-notes.md 00_intake/raw/

# 3. Run research first to gather evidence before defining requirements
# (tell your AI agent:)
Start research.

# 4. Review and approve the Research Brief when the agent asks for approval
#    (the agent pauses; you write your approval into the brief)

# 5. Run requirement breakdown — it reads the accepted brief automatically
Start requirement breakdown.
```

### Option B — Intake-first (when you have enough context already)

```sh
# 1. Extract or copy the scaffold
bash SCRIPTS/scaffold-extract.sh --apply <target-directory>

# 2. Drop raw material into intake
cp your-notes.md 00_intake/raw/

# 3. Start requirement breakdown directly
Start requirement breakdown.

# 4. Validate the scaffold
bash SCRIPTS/validate-bootstrap.sh
```

For the full initialization prompt, see `NEW_PROJECT_INITIALIZATION.md`. For
agent prompt recipes, see `BOOTSTRAP_USAGE.md`. For a worked example, see
`examples/simple-saas-demo/`.

---

## How It Works (Step by Step)

### Step 1 — Set up the scaffold

Extract a clean scaffold into your new project:

```sh
bash SCRIPTS/scaffold-extract.sh --apply <target-directory>
```

Or copy manually following the manifest-mediated rules in `TEMPLATE_MANIFEST.md`.

This gives you a clean workspace. ProjectGenesis maintainer state (backlog,
review records, architecture decisions for the scaffold itself) does not carry
over to your downstream project.

### Step 2 — Drop raw material into intake

Put any raw project material into `00_intake/raw/`: product notes, feature
lists, PRD fragments, screenshots, customer feedback, research exports. Format
does not matter. The agent handles registration and summarization.

### Step 3 — Run research (optional but recommended)

If you want evidence-backed market, competitor, user, or feasibility research
before defining requirements, ask an agent:

```text
Start research.
```

The agent will:

1. Inspect your intake material and decide research depth (quick / standard / deep)
2. Select which research tracks apply from the track catalog
3. Spawn focused evidence-collection agents — one per assigned track
4. An independent critic agent (fresh context required) challenges every finding
5. A synthesizer merges accepted findings into a draft Research Brief
6. **The agent pauses and asks for your explicit approval**

Only after you write your approval into the brief does it become `status: accepted`.
The accepted Research Brief is the only path from research evidence into product
definition. Raw research reports are audit evidence and never become requirement
sources directly.

**Research tracks available:**

| Track | What It Covers |
|-------|---------------|
| Market | Size, growth trends, segments, timing signals |
| Competitors | Features, pricing, positioning, gaps, moats |
| User needs | Target user problems, jobs-to-be-done, workflows, pain points |
| Technical feasibility | Stack viability, integrations, build vs. buy, technical risks |
| Regulatory | Compliance requirements, legal constraints, jurisdiction rules |
| Costs and free tiers | Infrastructure costs, tool pricing, viable free tiers |
| Risks | High-impact unknowns that could change direction |
| Differentiation | Underserved gaps, positioning opportunities |

**Research depth:**

| Depth | When | Tracks |
|-------|------|--------|
| Quick | Familiar domain, time-boxed validation | 1–3 tracks |
| Standard | New product space, moderate uncertainty | 4–7 tracks |
| Deep | Novel market, high uncertainty, regulatory complexity | 8–12 tracks |

### Step 4 — Run requirement breakdown

Ask an agent:

```text
Start requirement breakdown.
```

The agent will:

1. Register raw sources and assign stable source IDs (`SRC-001`, `SRC-002`, …)
2. Summarize each source
3. Extract and label requirements as confirmed, inferred, or assumption
4. Record assumptions, risks, and open questions
5. Generate product context (brief, charter, value proposition, workflows)
6. Create backlog candidates, draft specs, and ADR candidates where appropriate
7. Map acceptance criteria and validation needs
8. Update traceability, handoffs, and state files
9. Run scaffold validation
10. Classify project readiness: `intake-incomplete` → `discovery-ready` → `spec-draft-ready` → `backlog-draft-ready` → `implementation-blocked` → `implementation-ready`

If an accepted Research Brief exists, the agent reads it and uses it as an
evidence input. Research claims enter requirements only through the brief — the
single-door rule.

### Step 5 — Review and gate

Before implementation, verify:

- Requirements trace to sources or approved assumptions
- Open questions that block implementation are resolved or explicitly accepted
- Backlog items satisfy Definition of Ready
- Specs exist for features that need them
- Architecture decisions are captured in ADRs

### Step 6 — Implement

Each implementation task has a linked spec and Definition of Ready. After
implementation, a fresh-context agent (not the implementer) runs an adversarial
review before the PR is merged.

---

## All Commands

| Phrase | What It Runs | When To Use |
|--------|-------------|-------------|
| `Start research.` | `COMMANDS/start-research.md` | Optional first step — collects market, competitor, and feasibility evidence before defining requirements. |
| `Start requirement breakdown.` | `COMMANDS/start-requirement-breakdown.md` | Primary intake command. Turns raw material into structured product context. |
| `Validate idea.` | `COMMANDS/validate-idea.md` | Lightweight check on a rough idea before committing to full intake or research. |
| `Start spec authoring.` | `COMMANDS/start-spec-authoring.md` | When a feature needs a formal spec before backlog or implementation. |
| `Start architecture design.` | `COMMANDS/start-architecture-design.md` | When technical direction needs capturing in ADRs. |
| `Start backlog planning.` | `COMMANDS/start-backlog-planning.md` | Converts context and specs into a prioritized backlog. |
| `Start QA plan.` | `COMMANDS/start-qa-plan.md` | Explicit test and validation plan for a feature or release. |

See `COMMANDS/COMMAND_INDEX.md` for the full list of trigger phrases.

---

## How Agents Should Work

Agents start from `AGENTS.md` or `CLAUDE.md`, read
`memory/ai/SHARED_AGENT_RULES.md` and the relevant `memory/ai/ROLE_*.md` file,
then follow the `CONTEXT_INDEX.md` section for the task. `CONTEXT_INDEX.md` is
the single read-list authority.

**Claude startup shortcut:**

```sh
./SCRIPTS/start-claude.sh research       # Research Planner role
./SCRIPTS/start-claude.sh product        # Product Analyst role
./SCRIPTS/start-claude.sh spec           # Spec Author role
./SCRIPTS/start-claude.sh architecture   # Architect role
./SCRIPTS/start-claude.sh backlog        # Backlog Planner role
./SCRIPTS/start-claude.sh implementation # Implementation Agent role
./SCRIPTS/start-claude.sh qa             # QA Reviewer role
./SCRIPTS/start-claude.sh review         # Reviewer role
./SCRIPTS/start-claude.sh ux             # UX Designer role
./SCRIPTS/start-claude.sh docs           # Docs role
./SCRIPTS/start-claude.sh handoff        # Handoff role
```

Agents must not treat chat history as durable truth. If facts matter, they
belong in repository artifacts.

---

## Repository Structure

| Path | Purpose |
|------|---------|
| `00_intake/raw/` | Drop raw project notes, PRDs, screenshots, exports, rough ideas, and references here. |
| `00_intake/research/` | Research plans, evidence reports, critic reviews, and the accepted Research Brief. |
| `00_intake/SOURCE_REGISTRY.md` | Assigns stable source IDs such as `SRC-001`. |
| `00_intake/summaries/` | Source summaries created during intake. |
| `01_context/` | Product brief, charter, glossary, constraints, and UX brief. |
| `02_requirements/` | Requirements, assumptions register, and risk register. |
| `SPECS/` | Product, feature, spike, and implementation specs. |
| `ADR/` | Architecture decision records. |
| `BACKLOG/` | Backlog items; `BACKLOG/BACKLOG_INDEX.md` is the status truth. |
| `CONTEXT_PACKS/` | Scoped read manifests for common tasks. |
| `COMMANDS/` | Reusable workflow command prompts. |
| `REVIEWS/` | Review records and PR review packages. |
| `TESTS/` | Acceptance maps and manual validation checklists. |
| `memory/ai/` | Shared role definitions for AI agents. |
| `TEMPLATE_MANIFEST.md` | Defines which files are copied, reset, excluded, or treated as maintainer archive when creating a clean scaffold. |
| `TEMPLATE_STARTERS/` | Starter-reset content for new downstream projects. |
| `MAINTAINER_ARCHIVE/` | ProjectGenesis maintainer history kept out of the active required-reading path. |
| `RELEASE_NOTES.md` | Release history and operational changes. |

---

## Anti-Hallucination Controls

| Control | Where It Lives |
|---------|---------------|
| Source IDs on all raw claims | `00_intake/SOURCE_REGISTRY.md` |
| Confidence levels on requirements | `02_requirements/` |
| Explicit assumptions register | `02_requirements/ASSUMPTIONS_REGISTER.md` |
| Risk register with mitigations | `02_requirements/RISK_REGISTER.md` |
| Open questions for unclear material | `OPEN_QUESTIONS.md` |
| Evidence IDs (`EV-NNN`) on research claims | `00_intake/research/` reports |
| Single-door rule — only accepted briefs feed product | `COMMANDS/start-research.md` |
| Independent critic review of research findings | `memory/ai/ROLE_RESEARCH_CRITIC.md` |
| Explicit user approval gate before brief is accepted | `00_intake/research/RESEARCH_BRIEF_TEMPLATE.md` |
| Fresh-context adversarial review before merge | `PR_REVIEW_POLICY.md` |
| Seeded-defect benchmark (82/82 passing) | `TESTS/ADVERSARIAL_SEED_BENCHMARK.md` |
| Traceability matrix | `TRACEABILITY_MATRIX.md` |

---

## Quality Gates

ProjectGenesis expects:

- source-linked requirements
- explicit assumptions and expiry/review status
- open questions for unclear or conflicting material
- specs before implementation on non-trivial features
- backlog items linked to specs or discovery tasks
- test expectations before coding
- traceability from source to requirement to spec to backlog to test/review
- review depth routed by operation profile (`OPERATION_ROUTING.md` and
  `PR_REVIEW_POLICY.md`): self-check for low-risk docs/state changes,
  fresh-context adversarial review for planning-governance and
  strict-protected changes
- one validation-evidence note per PR; durable state files updated only when
  durable truth changed

Run the baseline validator:

```sh
bash SCRIPTS/validate-bootstrap.sh
```

Run validator rule checks (red-check harness):

```sh
bash SCRIPTS/validate-bootstrap-red-checks.sh
```

---

## Core Ideas

- Repository files are source of truth. Chat history is context only.
- Research is evidence collection, not feature definition.
- Product intake is evidence-linked from raw source material.
- Requirements are confirmed, inferred, or assumptions.
- Important requirements must trace to sources or approved assumptions.
- Architecture decisions use ADRs when they are high-impact.
- Implementation waits until a task satisfies Definition of Ready.
- Reviews use fresh context and repository evidence, not implementer memory.
- Handoffs are written to files so another agent can resume later.
- Commands are reusable workflow shortcuts, not hidden governance.

---

## GitHub Repository Controls

This public repository is governed through pull requests. The `main` branch is
protected by objective status-check enforcement, not by human/maintainer/Code
Owner approval gates. AI may merge after required CI/status checks pass,
required local validation passes, scope is clean, and no P0/P1/blocking P2
findings remain. See `PR_MERGE_POLICY.md` for the green-merge contract.

Recommended GitHub settings:

- require the `validate` GitHub Actions status check to pass once the workflow exists on `main`
- leave `required_pull_request_reviews` disabled — do not require approving reviews on `main`
- leave `require_code_owner_reviews` disabled — do not require Code Owner review on `main`
- leave `required_approving_review_count` at 0 — no approving review is required
- conversation resolution before merge is optional but recommended
- disallow force pushes and branch deletion
- keep `.github/CODEOWNERS` as informational ownership only; do not wire it up as a required-review gate

See `GITHUB_REPOSITORY_SETUP.md` for setup commands and verification steps.

---

## External Backlog Storage

Local Markdown is the default backlog source of truth
(`BACKLOG/BACKLOG_INDEX.md` plus item files under `BACKLOG/`). External
trackers are optional. Markdown remains authoritative until a real external
issue ID or URL is recorded.

### Supported External Tracker: Linear

Linear is the recommended external backlog store when you want a team-facing
issue tracker. Setup:

1. Create or choose a Linear workspace, the team that will own the issues, and
   optionally a project for the product or release.
2. Configure workflow statuses (`Backlog`, `Todo`, `In Progress`, `In Review`,
   `Done`) and labels matching the scaffold vocabulary (`type:<item_type>`,
   `status:blocked`, `risk:high`).
3. Connect the agent to Linear. For Codex:
   `codex mcp add linear --url https://mcp.linear.app/mcp`, then
   `codex mcp login linear`. For other agents, use the official Linear
   connector or MCP setup. Do not commit API keys, tokens, OAuth credentials,
   or exported private Linear data.

Field mapping from scaffold backlog items to Linear:

| Scaffold field | Linear |
|----------------|--------|
| priority `P0` / `P1` / `P2` / `P3` | `Urgent` / `High` / `Medium` / `Low` |
| readiness `not-ready` | `Backlog` |
| readiness `ready` | `Todo` |
| readiness `in-progress` | `In Progress` |
| readiness `in-review` | `In Review` |
| readiness `done` | `Done` |
| readiness `blocked` | label `status:blocked` |
| estimate `1` / `2` / `3` / `5` / `8` | Linear points |
| `item_type` and high risk | labels `type:<item_type>`, `risk:high` |

Export workflow and operating rules: `COMMANDS/export-backlog-to-linear.md`.

---

## Optional Spec Kit Integration

ProjectGenesis is already spec-first and does not require GitHub Spec Kit. Use
Spec Kit only when you want its external specification-driven development CLI,
templates, or agent commands for a downstream project.

Official Spec Kit reference: [github/spec-kit](https://github.com/github/spec-kit)

If you adopt Spec Kit:

- install only from the official `github/spec-kit` repository
- pin a release for repeatability when possible
- review generated files before accepting them
- register generated or adopted artifacts in `ARTIFACT_REGISTRY.md`
- keep ProjectGenesis source-of-truth rules in force unless an approved
  migration spec says otherwise

The official Spec Kit CLI can be installed with `uv`:

```sh
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
specify version
```

One-time use is also possible:

```sh
uvx --from git+https://github.com/github/spec-kit.git specify init .
```

Do not run `specify init` blindly in an established ProjectGenesis repository.
First decide whether Spec Kit should create separate `.specify/` artifacts,
augment the existing `SPECS/` and `COMMANDS/` workflow, or be skipped for that
project. If Spec Kit creates overlapping specs, tasks, or command files, treat
that as a governance decision and reconcile it before implementation.

---

## Requirements

ProjectGenesis itself is mostly Markdown and shell. To use the scaffold, you
need:

- Git
- Bash
- an AI coding agent that can read and edit repository files
- GitHub, if you want hosted collaboration, branch protection, pull requests,
  and GitHub Actions validation
- optional: GitHub CLI for repository setup and branch protection
- optional: Linear workspace and MCP or connector access for external backlog
  storage
- optional: Spec Kit CLI if you intentionally adopt Spec Kit for a downstream
  project
- optional: document conversion tools if your intake material includes PDFs,
  slides, spreadsheets, screenshots, or exported documents that agents cannot
  read directly

No application framework, package manager, database, or cloud provider is
selected by default.

---

## Who It Is For

ProjectGenesis is useful when you want AI to move fast, but you still need a
record of what was decided, why it was decided, what remains uncertain, and what
must be true before code is written.

It is especially useful for:

- AI-first builders who start with rough ideas and want a stronger path to implementation
- founders and solo builders who need structure without a full product team
- engineers who want AI agents to follow the same project truth across sessions
- teams that want requirements, backlog, architecture, testing, reviews, and handoffs to stay synchronized

It is not a replacement for product judgment, engineering review, security
review, user research, or legal review. It gives those activities a place to
live and a process agents can follow.

---

## Strengths

- Works across different AI agents and sessions (Codex, Claude, Gemini, and others).
- Keeps project truth in versioned files, not chat history.
- Research evidence is challenged by an independent critic and gates on your explicit approval before feeding product definition.
- Makes hallucinated requirements harder to introduce.
- Preserves source evidence and decisions with end-to-end traceability.
- Encourages small, reviewable implementation slices.
- Supports future automation without requiring it upfront.

## Limitations

- It is a scaffold, not an autonomous project manager.
- It cannot make unclear product direction clear without user input.
- It depends on agents actually reading and following the repository rules.
- It does not enforce GitHub branch protection by itself; repository settings must be configured on GitHub.
- It does not choose your product architecture, stack, database, hosting, or external tools.
- It can feel heavier than necessary for very small experiments unless you use the process pragmatically.

---

## Contribution Policy

Public contributions should come through pull requests. Direct changes to
`main` should be blocked by repository settings except for maintainer-controlled
administrative cases.

Before opening a PR:

1. Read `CONTRIBUTING.md`.
2. Link your change to a spec, backlog item, ADR, or documented discovery task.
3. Keep the change scoped.
4. Run `bash SCRIPTS/validate-bootstrap.sh`.
5. Record one validation-evidence note in the PR body; update durable state,
   registry, or traceability files only when durable truth changed.
6. Provide review evidence under `REVIEWS/` when the operation profile
   requires it.

---

## License

ProjectGenesis is licensed under the GNU Affero General Public License v3.0.
See `LICENSE` for the full license text.

AGPLv3 is a strong copyleft license. If you modify and run a covered network
service based on this project, review the license obligations carefully. This
README is not legal advice.
