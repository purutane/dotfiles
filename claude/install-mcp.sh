#!/usr/bin/env bash
# ~/dotfiles/claude/install-mcp.sh
set -euo pipefail

require_env() {
  local missing=()
  for var in "$@"; do
    [ -z "${!var:-}" ] && missing+=("$var")
  done
  if [ ${#missing[@]} -gt 0 ]; then
    echo "⏭  Skipped: missing env vars: ${missing[*]}" >&2
    return 1
  fi
}

remove_if_exists() {
  claude mcp remove "$1" --scope user 2>/dev/null || true
}

register_backlog() {
  require_env BACKLOG_DOMAIN BACKLOG_API_KEY || return 0
  remove_if_exists backlog
  claude mcp add backlog --scope user \
    --env 'BACKLOG_DOMAIN=${BACKLOG_DOMAIN}' \
    --env 'BACKLOG_API_KEY=${BACKLOG_API_KEY}' \
    -- npx -y backlog-mcp-server
  echo "✅ Registered: backlog"
}

register_newrelic() {
  require_env NEW_RELIC_API_KEY || return 0
  remove_if_exists newrelic
  claude mcp add newrelic https://mcp.newrelic.com/mcp/ \
    --scope user \
    --transport http \
    --header 'Api-Key: ${NEW_RELIC_API_KEY}'
  echo "✅ Registered: newrelic"
}

register_backlog
register_newrelic

echo ""
claude mcp list
