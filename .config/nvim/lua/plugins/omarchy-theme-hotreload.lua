-- Helper: parse an omarchy theme spec (neovim.lua) and extract the colorscheme
-- and optional theme plugin name. Omarchy theme files use three patterns:
--   1. String:   { { "plugin/name" }, { "LazyVim/LazyVim", opts = { colorscheme = "name" } } }
--   2. Function: { { "LazyVim/LazyVim", opts = { colorscheme = function() ... end } } }
--   3. Config:   { { "plugin/name", opts = {...}, config = function() ... end }, { "LazyVim/LazyVim", ... } }
local function parse_theme_spec(theme_spec)
	local colorscheme = nil
	local theme_plugin_name = nil
	local theme_plugin_config = nil
	local theme_plugin_opts = nil

	for _, spec in ipairs(theme_spec) do
		-- Extract the colorscheme value from the LazyVim opts
		if spec[1] == "LazyVim/LazyVim" and spec.opts and spec.opts.colorscheme then
			colorscheme = spec.opts.colorscheme
		-- Any non-LazyVim plugin entry is the colorscheme plugin
		elseif spec[1] and spec[1] ~= "LazyVim/LazyVim" then
			theme_plugin_name = spec.name or spec[1]
			theme_plugin_config = spec.config
			theme_plugin_opts = spec.opts
		end
	end

	return colorscheme, theme_plugin_name, theme_plugin_config, theme_plugin_opts
end

-- Helper: apply a colorscheme (string name or function) and handle transparency
local function apply_colorscheme(colorscheme, theme_plugin_name, theme_plugin_config, theme_plugin_opts)
	local transparency_file = vim.fn.stdpath("config") .. "/plugin/after/transparency.lua"

	-- Clear all highlight groups before applying new theme
	vim.cmd("highlight clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end

	-- Reset background so colorscheme can set it properly
	vim.o.background = "dark"

	-- Unload theme plugin modules to force full reload
	if theme_plugin_name then
		local plugin = require("lazy.core.config").plugins[theme_plugin_name]
		if plugin then
			local plugin_dir = plugin.dir .. "/lua"
			require("lazy.core.util").walkmods(plugin_dir, function(modname)
				package.loaded[modname] = nil
				package.preload[modname] = nil
			end)
		end
	end

	if type(colorscheme) == "function" then
		-- Function colorscheme (e.g. blueridge-dark): call it directly
		local ok, err = pcall(colorscheme)
		if not ok then
			vim.notify("Theme function error: " .. tostring(err), vim.log.levels.ERROR)
			return
		end
	elseif type(colorscheme) == "string" then
		-- Ensure the colorscheme plugin is loaded
		pcall(require("lazy.core.loader").colorscheme, colorscheme)

		if type(theme_plugin_config) == "function" then
			-- Theme plugin has its own config function (e.g. aether) that
			-- handles setup + colorscheme application. Call it directly.
			local ok, err = pcall(theme_plugin_config, nil, theme_plugin_opts or {})
			if not ok then
				vim.notify("Theme config error: " .. tostring(err), vim.log.levels.ERROR)
				return
			end
		else
			local ok, err = pcall(vim.cmd.colorscheme, colorscheme)
			if not ok then
				vim.notify("Colorscheme error: " .. tostring(err), vim.log.levels.ERROR)
				return
			end
		end
	end

	-- Force redraw to update all UI elements
	vim.cmd("redraw!")

	-- Reload transparency settings
	if vim.fn.filereadable(transparency_file) == 1 then
		vim.defer_fn(function()
			vim.cmd.source(transparency_file)

			-- Trigger UI updates for various plugins
			vim.api.nvim_exec_autocmds("ColorScheme", { modeline = false })
			vim.api.nvim_exec_autocmds("VimEnter", { modeline = false })

			-- Final redraw
			vim.cmd("redraw!")
		end, 5)
	end
end

return {
	{
		name = "theme-hotreload",
		dir = vim.fn.stdpath("config"),
		lazy = false,
		priority = 1000,
		config = function()
			-- Apply the initial theme on startup. This replaces the role
			-- LazyVim/LazyVim used to play in reading opts.colorscheme.
			local ok, theme_spec = pcall(require, "plugins.theme")
			if ok then
				local colorscheme, theme_plugin_name, theme_plugin_config, theme_plugin_opts =
					parse_theme_spec(theme_spec)
				if colorscheme then
					if type(colorscheme) == "function" then
						pcall(colorscheme)
					elseif type(colorscheme) == "string" then
						pcall(require("lazy.core.loader").colorscheme, colorscheme)
						if type(theme_plugin_config) == "function" then
							pcall(theme_plugin_config, nil, theme_plugin_opts or {})
						else
							pcall(vim.cmd.colorscheme, colorscheme)
						end
					end
				end
			end

			-- Hot-reload: watch for theme changes via lazy.nvim's reloader
			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyReload",
				callback = function()
					-- Unload the theme module so it gets re-read from disk
					package.loaded["plugins.theme"] = nil

					vim.schedule(function()
						local reload_ok, theme_spec_new = pcall(require, "plugins.theme")
						if not reload_ok then
							return
						end

						local colorscheme, theme_plugin_name, theme_plugin_config, theme_plugin_opts =
							parse_theme_spec(theme_spec_new)
						if not colorscheme then
							return
						end

						apply_colorscheme(colorscheme, theme_plugin_name, theme_plugin_config, theme_plugin_opts)
					end)
				end,
			})
		end,
	},
}
