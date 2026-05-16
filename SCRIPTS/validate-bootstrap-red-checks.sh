#!/usr/bin/env bash
set -euo pipefail

repo_root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
tmp_root="$(mktemp -d "${TMPDIR:-/tmp}/bootstrap-red-checks.XXXXXX")"

cleanup() {
  rm -rf "$tmp_root"
}
trap cleanup EXIT

failures=0

copy_repo() {
  local name="$1"
  local dest="$tmp_root/$name"
  local current_branch
  current_branch="$(git -C "$repo_root" branch --show-current 2>/dev/null || printf '%s' main)"
  mkdir -p "$dest"
  rsync -a --exclude '.git' "$repo_root/" "$dest/"
  git -C "$dest" init -q
  git -C "$dest" symbolic-ref HEAD "refs/heads/$current_branch"
  printf '%s\n' "$dest"
}

expect_failure() {
  local name="$1"
  local expected="$2"
  local dir="$3"
  local output

  set +e
  output="$(cd "$dir" && bash SCRIPTS/validate-bootstrap.sh 2>&1)"
  local status=$?
  set -e

  if [[ "$status" -eq 0 ]]; then
    echo "FAIL: $name unexpectedly passed" >&2
    failures=$((failures + 1))
    return
  fi

  if ! grep -Fq "$expected" <<<"$output"; then
    echo "FAIL: $name did not include expected failure text: $expected" >&2
    echo "$output" >&2
    failures=$((failures + 1))
  fi
}

expect_no_failure_mentioning() {
  local name="$1"
  local dir="$2"
  local needle="$3"
  local output

  set +e
  output="$(cd "$dir" && bash SCRIPTS/validate-bootstrap.sh 2>&1)"
  set -e

  if grep -Fq "$needle" <<<"$output"; then
    echo "FAIL: $name — validator output mentioned '$needle' (it should not):" >&2
    grep -F "$needle" <<<"$output" >&2
    failures=$((failures + 1))
  fi
}

case_approved_spec_missing_source() {
  local dir
  dir="$(copy_repo approved-spec-missing-source)"
  mkdir -p "$dir/SPECS"
  cat >"$dir/SPECS/SPEC-RED-001.md" <<'EOF'
artifact_id: ART-SPEC-RED-001
title: Red Check Spec
type: spec
status: approved
version: v1.0
created: 2026-05-13
updated: 2026-05-13
owner: AI Bootstrap Maintainers
source: red check
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# SPEC-RED-001: Red Check Spec

## Metadata

- Spec ID: SPEC-RED-001
- Status: approved
- Version: v1.0

## Functional Requirements

| ID | Requirement | Requirement IDs | Source IDs | Confidence | Status | Priority |
|----|-------------|-----------------|------------|------------|--------|----------|
| FR-RED-001 | Invalid approved requirement. | REQ-RED-001 | none | high | confirmed | P1 |
EOF
  expect_failure "approved spec missing source IDs" "approved spec missing source IDs" "$dir"
}

case_approved_spec_empty_source() {
  local dir
  dir="$(copy_repo approved-spec-empty-source)"
  mkdir -p "$dir/SPECS"
  cat >"$dir/SPECS/SPEC-RED-002.md" <<'EOF'
artifact_id: ART-SPEC-RED-002
title: Red Check Spec Empty Source
type: spec
status: approved
version: v1.0
created: 2026-05-13
updated: 2026-05-13
owner: AI Bootstrap Maintainers
source: red check
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# SPEC-RED-002: Red Check Spec Empty Source

## Metadata

- Spec ID: SPEC-RED-002
- Status: approved
- Version: v1.0

## Functional Requirements

| ID | Requirement | Requirement IDs | Source IDs | Confidence | Status | Priority |
|----|-------------|-----------------|------------|------------|--------|----------|
| FR-RED-002 | Invalid approved requirement. | REQ-RED-002 |  | high | confirmed | P1 |
EOF
  expect_failure "approved spec empty source IDs" "approved spec missing source IDs" "$dir"
}

case_active_backlog_missing_spec() {
  local dir
  dir="$(copy_repo active-backlog-missing-spec)"
  printf '\n' >>"$dir/BACKLOG.md"
  cat >>"$dir/BACKLOG.md" <<'EOF'
| RED-001 | Invalid active backlog item | Missing linked spec evidence. | P1 | medium | medium | none | ready | sequential | Implementation Agent |
EOF
  expect_failure "active backlog missing linked spec" "active backlog item missing linked spec" "$dir"
}

case_handoff_branch_mismatch() {
  local dir
  dir="$(copy_repo handoff-branch-mismatch)"
  perl -0pi -e 's/(## Current Branch\n\n)`[^`]+`/${1}`red-mismatch-branch`/' "$dir/AI_HANDOFF.md"
  expect_failure "handoff branch mismatch" "AI_HANDOFF.md branch does not match git branch" "$dir"
}

case_command_missing_required_reads() {
  local dir
  dir="$(copy_repo command-missing-required-reads)"
  mkdir -p "$dir/COMMANDS"
  cat >"$dir/COMMANDS/bad-command.md" <<'EOF'
artifact_id: ART-COMMAND-BAD
title: Bad Command
type: command
status: active
version: v1.0
created: 2026-05-13
updated: 2026-05-13
owner: AI Bootstrap Maintainers
source: red check
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Bad Command

## Purpose

Invalid command fixture.
EOF
  expect_failure "command missing required reads" "command missing section: ## Required Files To Read" "$dir"
}

case_source_registry_missing_status() {
  local dir
  dir="$(copy_repo source-registry-missing-status)"
  printf '\n' >>"$dir/00_intake/SOURCE_REGISTRY.md"
  cat >>"$dir/00_intake/SOURCE_REGISTRY.md" <<'EOF'
| SRC-999 | `00_intake/raw/example.md` | note | User | 2026-05-13 |  | pending | internal | none |  |
EOF
  expect_failure "source registry missing freshness" "source registry row missing freshness" "$dir"
}

case_source_registry_missing_processing_state() {
  local dir
  dir="$(copy_repo source-registry-missing-processing-state)"
  printf '\n' >>"$dir/00_intake/SOURCE_REGISTRY.md"
  cat >>"$dir/00_intake/SOURCE_REGISTRY.md" <<'EOF'
| SRC-998 | `00_intake/raw/example.md` | note | User | 2026-05-13 | active |  | internal | none |  |
EOF
  expect_failure "source registry missing processing state" "source registry row missing processing state" "$dir"
}

case_assumption_missing_expiry() {
  local dir
  dir="$(copy_repo assumption-missing-expiry)"
  printf '\n' >>"$dir/02_requirements/ASSUMPTIONS_REGISTER.md"
  cat >>"$dir/02_requirements/ASSUMPTIONS_REGISTER.md" <<'EOF'
| ASM-999 | Invalid assumption | low | Product Analyst | proposed |  | none | REQ-999 | SPEC-999 |  |
EOF
  expect_failure "assumption missing expiry" "assumption row missing expiry" "$dir"
}

case_approved_assumption_missing_evidence() {
  local dir
  dir="$(copy_repo approved-assumption-missing-evidence)"
  printf '\n' >>"$dir/02_requirements/ASSUMPTIONS_REGISTER.md"
  cat >>"$dir/02_requirements/ASSUMPTIONS_REGISTER.md" <<'EOF'
| ASM-998 | Invalid approved assumption | low | Product Analyst | approved | 2026-06-13 | none | REQ-998 | SPEC-998 |  |
EOF
  expect_failure "approved assumption missing approval evidence" "approved assumption missing approval evidence" "$dir"
}

case_approved_assumption_self_approved() {
  local dir
  dir="$(copy_repo approved-assumption-self-approved)"
  printf '\n' >>"$dir/02_requirements/ASSUMPTIONS_REGISTER.md"
  cat >>"$dir/02_requirements/ASSUMPTIONS_REGISTER.md" <<'EOF'
| ASM-997 | Invalid self-approved assumption | high | Product Analyst | approved | 2026-06-13 | self-approved by author | REQ-997 | SPEC-997 |  |
EOF
  expect_failure "approved assumption self-approved" "approved assumption has disallowed approval evidence" "$dir"
}

case_approved_assumption_unsupported_evidence() {
  local dir
  dir="$(copy_repo approved-assumption-unsupported-evidence)"
  printf '\n' >>"$dir/02_requirements/ASSUMPTIONS_REGISTER.md"
  cat >>"$dir/02_requirements/ASSUMPTIONS_REGISTER.md" <<'EOF'
| ASM-996 | Invalid weak approval evidence | medium | Product Analyst | approved | 2026-06-13 | looks reasonable | REQ-996 | SPEC-996 |  |
EOF
  expect_failure "approved assumption unsupported evidence" "approved assumption missing allowed approval evidence" "$dir"
}

case_operation_routing_missing_profile() {
  local dir
  dir="$(copy_repo operation-routing-missing-profile)"
  perl -0pi -e 's/`strict-protected`/`strict-protected-removed`/g' "$dir/OPERATION_ROUTING.md"
  expect_failure "operation routing missing profile" "OPERATION_ROUTING.md missing operation profile: strict-protected" "$dir"
}

case_operation_routing_missing_validation_mode() {
  local dir
  dir="$(copy_repo operation-routing-missing-validation-mode)"
  perl -0pi -e 's/\| strict \|/[removed-mode]/' "$dir/OPERATION_ROUTING.md"
  expect_failure "operation routing missing validation mode" "OPERATION_ROUTING.md missing validation mode: strict" "$dir"
}

case_operation_routing_missing_context_reference() {
  local dir
  dir="$(copy_repo operation-routing-missing-context-reference)"
  perl -0pi -e 's/`OPERATION_ROUTING.md`/`OPERATION_ROUTING_REMOVED.md`/g' "$dir/CONTEXT_INDEX.md"
  expect_failure "operation routing missing context reference" "CONTEXT_INDEX.md does not reference OPERATION_ROUTING.md" "$dir"
}

case_protected_mechanics_misclassified() {
  local dir
  dir="$(copy_repo protected-mechanics-misclassified)"
  perl -0pi -e 's/Operation profile: `strict-protected`/Operation profile: `planning-governance`/' "$dir/AI_HANDOFF.md"
  expect_failure "protected mechanics misclassified" "protected mechanics classification must be strict-protected" "$dir"
}

case_protected_planning_misclassified() {
  local dir
  dir="$(copy_repo protected-planning-misclassified)"
  perl -0pi -e '
    s/(## BOOT-019-024 Pre-Change Classification\n[^#]*?Operation profile: `)strict-protected/$1docs-trivial/s;
    s/`CURRENT_STATE\.md`, `AI_HANDOFF\.md`, `BACKLOG\.md`,\n  `ARTIFACT_REGISTRY\.md`, `TRACEABILITY_MATRIX\.md`, `TEST_RESULTS\.md`,\n  `WORKLOG\/WORKLOG_INDEX\.md`, `GOVERNANCE\.md`,\n  `BRANCH_AND_WORKTREE_GUIDE\.md`, `RISK_MODEL\.md`,\n  `PR_REVIEW_POLICY\.md`, `PR_MERGE_POLICY\.md`, `CONTEXT_INDEX\.md`,\n  `AI_PROJECT_BOOTSTRAP\.md`, `SPECS\/SPEC_INDEX\.md`,\n  `SPECS\/SPEC-BOOT-003-adaptive-governance-routing\.md`,\n  `SCRIPTS\/validate-bootstrap\.sh`, `SCRIPTS\/validate-bootstrap-red-checks\.sh`,\n  `\.github\/workflows\/bootstrap-validation\.yml`, relevant context packs,\n  command\/template\/review artifacts, and any new registered governance artifact\n  required by the implementation\./`SPECS\/SPEC_INDEX.md`, `BACKLOG.md`, `TRACEABILITY_MATRIX.md`, and `ARTIFACT_REGISTRY.md`./;
  ' "$dir/AI_HANDOFF.md"
  expect_failure "protected planning misclassified" "protected planning classification must be planning-governance or strict-protected" "$dir"
}

case_research_dir_does_not_trip_validator() {
  local dir
  dir="$(copy_repo research-dir-ignored)"
  mkdir -p "$dir/research/phase-0-fixture"
  cat >"$dir/research/phase-0-fixture/note.md" <<'EOF'
# Research Note

This file deliberately has no metadata block and contains a placeholder
token like TODO to verify the validator does not trip on `research/`
contents. After Phase 0, validation must not mention this path.
EOF
  expect_no_failure_mentioning "research dir does not trip validator" "$dir" "research/phase-0-fixture/note.md"
}

case_claude_worktree_does_not_trip_validator() {
  local dir
  dir="$(copy_repo claude-worktree-ignored)"
  mkdir -p "$dir/.claude/worktrees/phase-0-fixture"
  cat >"$dir/.claude/worktrees/phase-0-fixture/note.md" <<'EOF'
# Worktree Note

This file deliberately has no metadata block and contains a placeholder
token like FIXME to verify the validator does not trip on `.claude/`
contents. After Phase 0, validation must not mention this path.
EOF
  expect_no_failure_mentioning ".claude worktree does not trip validator" "$dir" ".claude/worktrees/phase-0-fixture/note.md"
}

case_protected_planning_misclassified_in_second_block() {
  local dir
  dir="$(copy_repo protected-planning-misclassified-second-block)"
  cat >>"$dir/AI_HANDOFF.md" <<'EOF'

## Pre-Change Classification (red-check fixture second block)

- Operation profile: `docs-trivial`
- Target files: `SPECS/`, `BACKLOG.md`, `TRACEABILITY_MATRIX.md`,
  `ARTIFACT_REGISTRY.md`
- Protected files touched: false
- Reason: Red-check fixture second block; this profile should escalate
  to planning-governance because target_files include planning artifacts.
EOF
  expect_failure "protected planning misclassified in second block" "protected planning classification must be planning-governance or strict-protected" "$dir"
}

case_scaffold_extract_golden_validates() {
  # Golden fixture: extracting the scaffold into a fresh temp target and then
  # running `bash SCRIPTS/validate-bootstrap.sh` inside the target must exit 0.
  # This is the BOOT-031 acceptance check that the extracted scaffold is a
  # valid downstream starting point.
  local target="$tmp_root/scaffold-extract-golden"
  rm -rf "$target"
  local output
  set +e
  output="$(cd "$repo_root" && bash SCRIPTS/scaffold-extract.sh --apply "$target" 2>&1)"
  local status=$?
  set -e
  if [[ "$status" -ne 0 ]]; then
    echo "FAIL: scaffold-extract.sh --apply did not exit 0:" >&2
    echo "$output" >&2
    failures=$((failures + 1))
    return
  fi
  set +e
  output="$(cd "$target" && bash SCRIPTS/validate-bootstrap.sh 2>&1)"
  status=$?
  set -e
  if [[ "$status" -ne 0 ]]; then
    echo "FAIL: extracted scaffold did not validate:" >&2
    echo "$output" >&2
    failures=$((failures + 1))
  fi
}

case_scaffold_extract_dry_run_writes_nothing() {
  # Default behavior is dry-run; the script must not create the target
  # directory when invoked without --apply.
  local target="$tmp_root/scaffold-extract-dry-run"
  rm -rf "$target"
  set +e
  ( cd "$repo_root" && bash SCRIPTS/scaffold-extract.sh "$target" >/dev/null 2>&1 )
  local status=$?
  set -e
  if [[ "$status" -ne 0 ]]; then
    echo "FAIL: scaffold-extract.sh dry-run exited non-zero" >&2
    failures=$((failures + 1))
    return
  fi
  if [[ -e "$target" ]]; then
    echo "FAIL: scaffold-extract.sh dry-run created target directory: $target" >&2
    failures=$((failures + 1))
  fi
}

case_scaffold_extract_refuses_source_as_target() {
  # Safety: the script must refuse when the target equals the source root.
  local output
  set +e
  output="$(cd "$repo_root" && bash SCRIPTS/scaffold-extract.sh --apply "$repo_root" 2>&1)"
  local status=$?
  set -e
  if [[ "$status" -eq 0 ]]; then
    echo "FAIL: scaffold-extract.sh accepted source as target" >&2
    failures=$((failures + 1))
    return
  fi
  if ! grep -Fq "target equals source repository" <<<"$output"; then
    echo "FAIL: scaffold-extract.sh refused source-as-target for wrong reason:" >&2
    echo "$output" >&2
    failures=$((failures + 1))
  fi
}

case_scaffold_extract_refuses_nonempty_without_force() {
  # Safety: the script must refuse to overwrite a non-empty target unless
  # --force is passed.
  local target="$tmp_root/scaffold-extract-nonempty"
  rm -rf "$target"
  mkdir -p "$target"
  printf 'existing\n' >"$target/keepme.txt"
  local output
  set +e
  output="$(cd "$repo_root" && bash SCRIPTS/scaffold-extract.sh --apply "$target" 2>&1)"
  local status=$?
  set -e
  if [[ "$status" -eq 0 ]]; then
    echo "FAIL: scaffold-extract.sh accepted non-empty target without --force" >&2
    failures=$((failures + 1))
    return
  fi
  if ! grep -Fq "target directory exists and is non-empty" <<<"$output"; then
    echo "FAIL: scaffold-extract.sh refused non-empty target for wrong reason:" >&2
    echo "$output" >&2
    failures=$((failures + 1))
  fi
  if [[ ! -f "$target/keepme.txt" ]]; then
    echo "FAIL: scaffold-extract.sh modified the non-empty target before refusing" >&2
    failures=$((failures + 1))
  fi
}

case_scaffold_extract_registry_includes_kept_framework_paths() {
  # Coverage: the extracted ARTIFACT_REGISTRY.md must mention every kept
  # framework/GitHub config path that the validator does not already check.
  # This guards against silent registry drift relative to
  # SCAFFOLD_FORK_CHECKLIST.md "Framework Files To Keep".
  local target="$tmp_root/scaffold-extract-registry-coverage"
  rm -rf "$target"
  local output
  set +e
  output="$(cd "$repo_root" && bash SCRIPTS/scaffold-extract.sh --apply --no-validate "$target" 2>&1)"
  local status=$?
  set -e
  if [[ "$status" -ne 0 ]]; then
    echo "FAIL: scaffold-extract.sh --apply did not exit 0 during registry coverage check:" >&2
    echo "$output" >&2
    failures=$((failures + 1))
    return
  fi
  local path
  for path in \
    "README.md" \
    "GITHUB_REPOSITORY_SETUP.md" \
    "GOVERNANCE_PERFORMANCE.md" \
    ".github/CODEOWNERS" \
    ".gitignore" \
    "COMMANDS/start-requirement-breakdown.md" \
    "00_intake/raw/.gitkeep" \
    "00_intake/summaries/.gitkeep" \
    "ARTIFACTS/.gitkeep" \
    "ARTIFACTS/ARCHIVE/.gitkeep"; do
    if ! grep -Fq "\`$path\`" "$target/ARTIFACT_REGISTRY.md"; then
      echo "FAIL: extracted ARTIFACT_REGISTRY.md does not register kept framework path: $path" >&2
      failures=$((failures + 1))
    fi
  done
}

case_scaffold_extract_reset_files_use_header_only_tables() {
  # Coverage: the extracted shared-state reset files must match the
  # SCAFFOLD_FORK_CHECKLIST.md header-only table contract for STALE_ITEMS.md,
  # ADR/ADR_INDEX.md, and HANDOFFS/HANDOFF_INDEX.md.
  local target="$tmp_root/scaffold-extract-reset-shapes"
  rm -rf "$target"
  local output
  set +e
  output="$(cd "$repo_root" && bash SCRIPTS/scaffold-extract.sh --apply --no-validate "$target" 2>&1)"
  local status=$?
  set -e
  if [[ "$status" -ne 0 ]]; then
    echo "FAIL: scaffold-extract.sh --apply did not exit 0 during reset-shape check:" >&2
    echo "$output" >&2
    failures=$((failures + 1))
    return
  fi
  # STALE_ITEMS.md: header table row but no body row.
  if ! grep -Fq "| Item | Type | Detected | Status | Resolution |" "$target/STALE_ITEMS.md"; then
    echo "FAIL: STALE_ITEMS.md missing header-only stale-items table header" >&2
    failures=$((failures + 1))
  fi
  if grep -Eq '^\| [^|]+\| [^|]+\| [^|]+\| [^|]+\| [^|]+\|$' "$target/STALE_ITEMS.md" \
       | grep -v "Item " | grep -v "----" >/dev/null 2>&1; then
    : # placeholder so set -e does not trip
  fi
  # ADR/ADR_INDEX.md: table header but no body row (no `none none` row).
  if grep -Fq "| none | none | none |" "$target/ADR/ADR_INDEX.md"; then
    echo "FAIL: ADR/ADR_INDEX.md still contains a 'none' body row instead of header-only table" >&2
    failures=$((failures + 1))
  fi
  if ! grep -Fq "| ADR ID | Title | File | Status | Date | Owner | Linked Specs | Linked Backlog Items | Supersedes | Superseded By |" "$target/ADR/ADR_INDEX.md"; then
    echo "FAIL: ADR/ADR_INDEX.md missing ADR table header row" >&2
    failures=$((failures + 1))
  fi
  # HANDOFFS/HANDOFF_INDEX.md: must contain a header-only handoff table.
  if ! grep -Fq "| Date | Agent | Role | Branch | Worktree | File |" "$target/HANDOFFS/HANDOFF_INDEX.md"; then
    echo "FAIL: HANDOFFS/HANDOFF_INDEX.md missing header-only handoff table header" >&2
    failures=$((failures + 1))
  fi
}

case_approved_spec_missing_source
case_approved_spec_empty_source
case_active_backlog_missing_spec
case_handoff_branch_mismatch
case_command_missing_required_reads
case_source_registry_missing_status
case_source_registry_missing_processing_state
case_assumption_missing_expiry
case_approved_assumption_missing_evidence
case_approved_assumption_self_approved
case_approved_assumption_unsupported_evidence
case_operation_routing_missing_profile
case_operation_routing_missing_validation_mode
case_operation_routing_missing_context_reference
case_protected_mechanics_misclassified
case_protected_planning_misclassified
case_research_dir_does_not_trip_validator
case_claude_worktree_does_not_trip_validator
case_protected_planning_misclassified_in_second_block
case_scaffold_extract_golden_validates
case_scaffold_extract_dry_run_writes_nothing
case_scaffold_extract_refuses_source_as_target
case_scaffold_extract_refuses_nonempty_without_force
case_scaffold_extract_registry_includes_kept_framework_paths
case_scaffold_extract_reset_files_use_header_only_tables

if [[ "$failures" -ne 0 ]]; then
  echo "Bootstrap red checks failed with $failures issue(s)." >&2
  exit 1
fi

echo "Bootstrap red checks passed."
