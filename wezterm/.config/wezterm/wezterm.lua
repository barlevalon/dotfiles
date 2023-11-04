local wezterm = require 'wezterm';

local function scheme_for_appearance(appearance)
  if appearance:find "Dark" then
    return "Catppuccin Mocha"
  else
    return "Catppuccin Mocha"
  end
end

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.font_size = 17
config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

config.window_background_opacity = 0.8
config.macos_window_background_blur = 20

-- and finally, return the configuration to wezterm
return config
