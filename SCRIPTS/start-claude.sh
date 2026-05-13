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
  diagrams)
    role_prompt="memory/ai/ROLE_DIAGRAM_ARCHITECT.md"
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
  diagrams
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

exec claude --append-system-prompt "$prompt_text"
