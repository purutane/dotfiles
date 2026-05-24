local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.ssh_domains = {}

-- font size
config.font = wezterm.font("UDEV Gothic 35NFLG")
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

return config
