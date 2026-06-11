artifact_id: ART-EXAMPLE-SIMPLE-SAAS-README
title: Simple SaaS Demo README
type: example
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

# Simple SaaS Demo

This example shows the shape of a ProjectGenesis intake result for a small SaaS
idea. The expected outputs are illustrative. They are not presented as real
agent-generated output from a live run.

Raw input lives in `00_raw_input/`. Expected illustrative outputs live in
`01_expected_outputs/`.

Use this example to see how ProjectGenesis separates:

- confirmed input
- inferred product understanding
- explicit assumptions
- open questions
- risks
- initial scope
- deferred AI reminder ideas
- backlog candidates
- validation checks
- a tech-design exemplar (`01_expected_outputs/tech-design.md`)
- an ADR exemplar (`01_expected_outputs/adr-001-stack-choice.md`)

The tabular outputs use the canonical schemas from
`02_requirements/REQUIREMENTS_INDEX.md`, `02_requirements/ASSUMPTIONS_REGISTER.md`,
`02_requirements/RISK_REGISTER.md`, and `BACKLOG/BACKLOG_INDEX.md`, so the
example doubles as a golden-path reference for real intake output.

For a real project, place source material in `00_intake/raw/` and run:

```text
Start requirement breakdown.
```
