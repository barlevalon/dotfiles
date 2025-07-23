-- Dynamic theme loading based on system theme

-- Function to load theme
local function load_theme()
	local theme_file = vim.fn.expand("~/.config/theme/current/theme/neovim.lua")
	if vim.fn.filereadable(theme_file) == 1 then
		-- Load the theme file
		local ok, err = pcall(dofile, theme_file)
		if not ok then
			vim.notify("Failed to load theme: " .. err, vim.log.levels.ERROR)
			-- Fallback to gruvbox
			pcall(vim.cmd.colorscheme, "gruvbox")
		end
	else
		-- Fallback to gruvbox if no theme file exists
		pcall(vim.cmd.colorscheme, "gruvbox")
	end
end

-- Set up theme loading after plugins are loaded
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		-- Load theme on startup
		load_theme()

		-- Create command to reload theme
		vim.api.nvim_create_user_command("ThemeReload", function()
			load_theme()
			vim.notify("Theme reloaded", vim.log.levels.INFO)
		end, {})

		-- Watch for theme changes (optional, for auto-reload)
		vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
			group = vim.api.nvim_create_augroup("ThemeReload", { clear = true }),
			callback = function()
				-- Check if theme file has changed
				local current_theme = vim.g.current_theme_mtime or 0
				local theme_file = vim.fn.expand("~/.config/theme/current/theme/neovim.lua")
				local stat = vim.loop.fs_stat(theme_file)
				if stat and stat.mtime.sec > current_theme then
					vim.g.current_theme_mtime = stat.mtime.sec
					load_theme()
				end
			end,
		})
	end,
})

return {
	-- Load all possible theme plugins
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
	},
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"neanias/everforest-nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"EdenEast/nightfox.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
	},
}