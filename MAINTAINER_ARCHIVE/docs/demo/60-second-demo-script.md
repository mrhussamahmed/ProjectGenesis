artifact_id: ART-DEMO-SCRIPT-001
title: 60-Second Demo Script
type: demo-script
status: active
version: v1.0
created: 2026-05-14
updated: 2026-05-14
owner: ProjectGenesis Maintainers
source: Public launch readiness and adoption packaging task
linked_specs: [SPEC-BOOT-004]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# 60-Second Demo Script

## Screen Plan

1. Show `README.md` title and first paragraphs.
2. Show `examples/simple-saas-demo/00_raw_input/freelancer-invoice-app.md`.
3. Show `COMMANDS/start-requirement-breakdown.md`.
4. Show the expected illustrative outputs under
   `examples/simple-saas-demo/01_expected_outputs/`.
5. Show validation command output.

## Exact Agent Instruction

```text
Start requirement breakdown.
```

For the demo example, say that the checked-in outputs are illustrative and show
the shape of the expected result.

## Suggested Terminal Commands

```sh
ls examples/simple-saas-demo
sed -n '1,120p' examples/simple-saas-demo/00_raw_input/freelancer-invoice-app.md
sed -n '1,120p' examples/simple-saas-demo/01_expected_outputs/requirements.md
bash SCRIPTS/validate-bootstrap.sh
```

## Before And After Shots

- Before: one rough sentence in
  `examples/simple-saas-demo/00_raw_input/freelancer-invoice-app.md`.
- After: product brief, requirements, assumptions and open questions, backlog
  candidates, and validation checklist in `01_expected_outputs/`.

## Spoken Script

"ProjectGenesis is a Markdown-first scaffold for working with AI agents without
making chat history the project memory.

Here is a rough product idea: a freelancer invoice app with expenses, late
payments, and possible AI reminders later.

The agent instruction is short: Start requirement breakdown.

The scaffold tells the agent what to read, how to classify the work, and how to
separate confirmed facts from inferences, assumptions, open questions, risks,
backlog candidates, and validation needs.

This example output is illustrative. Notice that invoice tracking is in the
initial scope, while AI reminders are deferred until the product owner confirms
requirements and risk.

Before work is considered complete, the repository expects validation and
handoff updates.

Project truth lives in the repo, not in chat memory."
