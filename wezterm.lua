local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.ssh_domains = {}

-- font size
config.font = wezterm.font_with_fallback({
  "UDEV Gothic 35NFLG",
  "Symbols Nerd Font Mono",
})
if wezterm.target_triple == "x86_64-unknown-linux-gnu" then
  config.font_size = 12.0
else
  config.font_size = 14.0
end

-- window size
config.initial_cols = 120
config.initial_rows = 30

config.color_scheme = "tokyonight_storm"

config.enable_tab_bar = false

config.window_padding = {
  left = 10,
  right = 10,
  top = 10,
  bottom = 10,
}

-- scrollback (mostly managed by tmux; this is for tmux-less usage)
config.scrollback_lines = 20000

-- Shift+Enter sends ESC+CR = newline in Claude Code (passes through tmux as-is)
config.keys = {
  { key = "Enter", mods = "SHIFT", action = wezterm.action.SendString("\x1b\r") },
}

-- bell -> sound + toast notification (tmux forwards pane bells)
-- wezterm itself has no audio path (the binary links no audio library, and
-- SystemBeep is a no-op under Wayland), so play the sound ourselves.
local is_macos = wezterm.target_triple:find("apple%-darwin") ~= nil
config.audible_bell = "Disabled"

local bell_sound
if is_macos then
  bell_sound = { "afplay", "/System/Library/Sounds/Blow.aiff" }
else
  bell_sound = { "paplay", "/usr/share/sounds/freedesktop/stereo/complete.oga" }
end

wezterm.on("bell", function(window, pane)
  wezterm.background_child_process(bell_sound)
  window:toast_notification("WezTerm", "タスク完了: " .. pane:get_title(), nil, 4000)
end)

return config
