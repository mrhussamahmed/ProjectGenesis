artifact_id: ART-PR-PACKAGE-README-TOOLING-PREREQS
title: README Positioning And Tooling Prerequisites Review Package
type: pr-review-package
status: active
version: v1.1
created: 2026-05-13
updated: 2026-05-13
owner: AI Bootstrap Maintainers
source: User request for stronger public README positioning plus Linear, Spec Kit, and tooling prerequisite documentation
linked_specs: [SPEC-BOOT-002]
linked_tickets: [BOOT-017]
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# README Positioning And Tooling Prerequisites Review Package

## Scope

Update the public README so new users understand what ProjectGenesis does, why
it is useful, what capabilities it provides, and which required or optional
tools should be prepared before using it for a downstream project.

This is a compatible documentation follow-up under active `SPEC-BOOT-002`,
which governs the scaffold command framework, source-of-truth hierarchy,
external ticket evidence rules, and downstream intake workflow.

## User Request

- Explain supported backlog storage, especially Linear.
- Explain what Linear setup is needed before work starts.
- Consider Spec Kit installation if needed.
- Mention other setup or tooling prerequisites that are important for public
  users.
- Make the README less dull and more adoption-friendly for AI-first builders,
  including less experienced developers who want stronger confidence in AI
  planning output.

## Intended Changes

- Add Linear as the recommended optional external backlog store.
- Clarify that Markdown backlog files remain authoritative until real external
  ticket evidence exists.
- Improve the opening README positioning, audience fit, capabilities overview,
  and "how it works" explanation.
- Document Linear workspace, team, project, workflow, label, template, access,
  and MCP setup expectations.
- Document optional GitHub Spec Kit use and its source-of-truth boundary.
- Expand README requirements to include GitHub, Linear, Spec Kit, and document
  conversion tooling where relevant.
- Update backlog, registry, traceability, state, handoff, test results, and
  worklog records.

## Out Of Scope

- Creating or configuring a Linear workspace.
- Installing Spec Kit into this repository.
- Creating external Linear issues.
- Changing ProjectGenesis governance or replacing Markdown source-of-truth
  files with external tools.

## Review Focus

- README does not imply Linear is required for all users.
- README clearly explains when Linear must be configured.
- README does not claim external tickets exist without evidence.
- Spec Kit guidance does not conflict with ProjectGenesis `SPECS/`, `COMMANDS/`,
  or source-of-truth rules.
- External setup guidance is grounded in official Linear and Spec Kit docs.
- Marketing-oriented language does not overclaim correctness, replace human
  judgment, or weaken the documented limitations.
- README explains the full scaffold capabilities without implying every
  downstream project needs every optional tool.

## Validation Plan

- `bash SCRIPTS/validate-bootstrap.sh`
- `bash SCRIPTS/validate-bootstrap-red-checks.sh`
- `git diff --check`
- `bash -n SCRIPTS/validate-bootstrap.sh && bash -n SCRIPTS/validate-bootstrap-red-checks.sh`
