#!/usr/bin/env bash
set -euo pipefail

repo_root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$repo_root"

mode="${1:-default}"

shared_prompt="memory/ai/SHARED_AGENT_RULES.md"
default_notice=""

case "$mode" in
  default)
    role_prompt=""
    default_notice="## Default Mode

Default mode is orientation-only. It loads shared agent rules but no operating
role. Do not perform meaningful task work until you read the relevant
memory/ai/ROLE_*.md file or restart with an allowlisted role mode."
    ;;
  product)
    role_prompt="memory/ai/ROLE_PRODUCT_ANALYST.md"
    ;;
  spec)
    role_prompt="memory/ai/ROLE_SPEC_AUTHOR.md"
    ;;
  architecture)
    role_prompt="memory/ai/ROLE_ARCHITECT.md"
    ;;
  backlog)
    role_prompt="memory/ai/ROLE_BACKLOG_PLANNER.md"
    ;;
  implementation)
    role_prompt="memory/ai/ROLE_IMPLEMENTATION_AGENT.md"
    ;;
  qa)
    role_prompt="memory/ai/ROLE_QA_REVIEWER.md"
    ;;
  security)
    role_prompt="memory/ai/ROLE_SECURITY_REVIEWER.md"
    ;;
  devops)
    role_prompt="memory/ai/ROLE_DEVOPS_RELEASE_REVIEWER.md"
    ;;
  docs)
    role_prompt="memory/ai/ROLE_DOCUMENTATION_CURATOR.md"
    ;;
  review)
    role_prompt="memory/ai/ROLE_ADVERSARIAL_PR_REVIEWER.md"
    ;;
  handoff)
    role_prompt="memory/ai/ROLE_DOCUMENTATION_CURATOR.md"
    ;;
  *)
    cat >&2 <<'USAGE'
Usage: ./SCRIPTS/start-claude.sh [mode]

Allowed modes:
  default
  product
  spec
  architecture
  backlog
  implementation
  qa
  security
  devops
  docs
  review
  handoff
USAGE
    exit 2
    ;;
esac

for path in "$shared_prompt" ${role_prompt:+"$role_prompt"}; do
  [[ -f "$path" ]] || {
    echo "Missing prompt file: $path" >&2
    exit 1
  }
done

prompt_text="$(cat "$shared_prompt")"

if [[ -n "$role_prompt" ]]; then
  prompt_text="${prompt_text}

---

$(cat "$role_prompt")"
elif [[ -n "$default_notice" ]]; then
  prompt_text="${prompt_text}

---

${default_notice}"
fi

# GEN-17/HAND-7 state injection: append a compact, read-only snapshot of
# current repository state so a fresh session starts oriented without
# re-deriving it. Repository files remain the source of truth; this block
# is convenience context only.
state_block="## Current Repository State (auto-injected by start-claude.sh)
"
if git rev-parse --git-dir >/dev/null 2>&1; then
  current_branch="$(git branch --show-current 2>/dev/null || true)"
  dirty_count="$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')"
  state_block+="
Branch: ${current_branch:-detached}; dirty files: ${dirty_count}."
fi
if [[ -f .ai/SESSION.md ]]; then
  state_block+="

Local session (.ai/SESSION.md, gitignored):
$(head -n 12 .ai/SESSION.md)"
fi
if [[ -f AI_HANDOFF.md ]]; then
  next_action="$(awk '/^## Next Recommended Action/{flag=1; next} /^## /{flag=0} flag && NF' AI_HANDOFF.md | head -n 6)"
  if [[ -n "$next_action" ]]; then
    state_block+="

AI_HANDOFF.md next recommended action:
$next_action"
  fi
fi

prompt_text="${prompt_text}

---

${state_block}"

exec claude --append-system-prompt "$prompt_text"
