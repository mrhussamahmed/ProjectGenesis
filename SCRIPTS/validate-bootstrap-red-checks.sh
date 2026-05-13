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
  mkdir -p "$dest"
  rsync -a --exclude '.git' "$repo_root/" "$dest/"
  git -C "$dest" init -q
  git -C "$dest" symbolic-ref HEAD refs/heads/codex/adversarial-plan-review
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

if [[ "$failures" -ne 0 ]]; then
  echo "Bootstrap red checks failed with $failures issue(s)." >&2
  exit 1
fi

echo "Bootstrap red checks passed."
