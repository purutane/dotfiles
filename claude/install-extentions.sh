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

register_aws_knowledge() {
  remove_if_exists aws-knowledge
  claude mcp add aws-knowledge https://knowledge-mcp.global.api.aws \
    --scope user \
    --transport http
  echo "✅ Registered: aws-knowledge"
}

register_slack() {
  if claude plugin list 2>/dev/null | grep -q 'slack@claude-plugins-official'; then
    echo "⏭  Skipped: slack already installed"
    return 0
  fi
  claude plugin install slack
  echo "✅ Registered: slack"
}

register_backlog
register_newrelic
register_aws_knowledge
register_slack

echo ""
claude mcp list
