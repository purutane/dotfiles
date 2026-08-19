#!/usr/bin/env bash
# Ring the terminal bell in the pane where Claude Code is running.
# tmux: write to the pane's own tty so the bell flag lands on the right window
# (backgrounded windows get the red highlight via window-status-bell-style).
#
# The hook payload arrives as JSON on stdin. Stop events always ring;
# Notification events ring only for permission requests (idle "waiting
# for input" and other informational notifications stay silent).

payload=$(cat 2>/dev/null || true)
if [ -n "$payload" ] && command -v jq >/dev/null 2>&1; then
  event=$(printf '%s' "$payload" | jq -r '.hook_event_name // empty' 2>/dev/null)
  if [ "$event" = "Notification" ]; then
    message=$(printf '%s' "$payload" | jq -r '.message // empty' 2>/dev/null)
    case "$message" in
      *[Pp]ermission*) ;;
      *) exit 0 ;;
    esac
  fi
fi

{
  if [ -n "${TMUX_PANE:-}" ]; then
    printf '\a' > "$(tmux display -p -t "$TMUX_PANE" '#{pane_tty}')"
  else
    printf '\a' > /dev/tty
  fi
} 2>/dev/null || true
