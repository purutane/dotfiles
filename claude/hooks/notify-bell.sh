#!/usr/bin/env bash
# Ring the terminal bell in the pane where Claude Code is running.
# tmux: write to the pane's own tty so the bell flag lands on the right window
# (backgrounded windows get the red highlight via window-status-bell-style).
{
  if [ -n "${TMUX_PANE:-}" ]; then
    printf '\a' > "$(tmux display -p -t "$TMUX_PANE" '#{pane_tty}')"
  else
    printf '\a' > /dev/tty
  fi
} 2>/dev/null || true
