local wezterm = require("wezterm")

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Macchiato"
	else
		return "Catppuccin Latte"
	end
end

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.font_size = 18
config.font = wezterm.font({
	family = "JetBrainsMono Nerd Font",
})
config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

config.window_background_opacity = 0.8
config.macos_window_background_blur = 10

config.default_cursor_style = "BlinkingBar"

config.keys = {
	{ key = "L", mods = "CTRL|ALT", action = wezterm.action.ShowDebugOverlay },
}

return config
