artifact_id: ART-BACKLOG-INDEX
title: Backlog Index
type: backlog-index
status: active
version: v1.7
created: 2026-05-09
updated: 2026-05-16
owner: AI Bootstrap Maintainers
source: Initial bootstrap scaffold, Phase 1 execution planning, PR #6 merge/post-merge source-of-truth cleanup, BOOT-030 in-review status, PR #7 BOOT-030 merge/post-merge source-of-truth cleanup, BOOT-031 scaffold extraction tool implementation, PR #8 BOOT-031 merge/post-merge source-of-truth cleanup, and BOOT-032 seeded-defect benchmark implementation
linked_specs: [SPEC-BOOT-002, SPEC-BOOT-003]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Backlog Index

Detailed backlog items can be stored in this folder.

## Items

| Item ID | Title | File | Status | Priority | Complexity | Risk | Linked Spec | Parallelization |
|---------|-------|------|--------|----------|------------|------|-------------|-----------------|
| BOOT-029 | Phase 1 Execution Plan | `BACKLOG/BOOT-029-phase-1-execution-plan.md` | done | P0 | medium | medium | SPEC-BOOT-002, SPEC-BOOT-003 | sequential |
| BOOT-030 | Scaffold Extraction Checklist | `BACKLOG/BOOT-030-scaffold-extract-checklist.md` | done | P0 | medium | high | SPEC-BOOT-002, SPEC-BOOT-003 | sequential |
| BOOT-031 | Scaffold Extraction Tool | `BACKLOG/BOOT-031-scaffold-extract-tool.md` | done | P0 | medium | high | SPEC-BOOT-002, SPEC-BOOT-003 | sequential |
| BOOT-032 | Seeded-Defect Benchmark | `BACKLOG/BOOT-032-seeded-defect-benchmark.md` | in-review | P0 | medium | high | SPEC-BOOT-003 | sequential |
| BOOT-033 | SRC And SPEC Cross-Validation | `BACKLOG/BOOT-033-src-spec-cross-validation.md` | queued after BOOT-032 | P1 | medium | high | SPEC-BOOT-002, SPEC-BOOT-003 | sequential |

## Rules

- Every backlog item must link to a spec or explicitly be a discovery task that
  creates one.
- Sequence by dependency and implementation order.
- Mark items as Linear-ready drafts unless a real ticket has been created.
