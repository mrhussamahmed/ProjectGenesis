---
artifact_id: ART-STARTER-SESSION
title: Local Session Starter
type: template-starter
status: active
version: v1.0
created: 2026-06-10
updated: 2026-06-10
owner: AI Bootstrap Maintainers
source: Fast-path reachability (session.sh + operation-profile.sh contract)
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false
---

# Local Session (gitignored; local resume aid only, never source of truth)

Exact format of `.ai/SESSION.md`. Do not hand-copy this file: run
`bash SCRIPTS/session.sh start <profile> [task-note]` to stamp the machine
keys. `SCRIPTS/operation-profile.sh` fail-closes to strict validation when
the branch mismatches, the epoch exceeds the 12-hour TTL, or the file is
absent. The three machine keys, one per line, exactly as below:

operation_profile: docs-trivial
branch: stamped-from-git-branch-show-current
updated_at_epoch: 0
task: one-line note about the work in flight

--- free notes below; session.sh preserves this section ---

Optional local resume notes: dirty files observed, next local command,
short tactical context for resuming this worktree. Keep decisions, risks,
and review findings in committed files or PR evidence instead.
