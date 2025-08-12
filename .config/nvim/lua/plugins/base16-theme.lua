-- Base16 theme support for Neovim

return {
	{
		"RRethy/base16-nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- The tinted-vim colorscheme file is copied to base16-current
			-- We just need to set the colorscheme
			vim.cmd.colorscheme("base16-current")
			
			-- Function to reload theme and lualine
			local function reload_theme()
				vim.cmd.colorscheme("base16-current")
				-- Reload lualine to pick up new colors
				local ok, lualine = pcall(require, "lualine")
				if ok then
					lualine.setup({
						options = {
							theme = "auto",
						},
					})
				end
			end
			
			-- Create command to reload theme
			vim.api.nvim_create_user_command("ThemeReload", function()
				reload_theme()
				vim.notify("Theme reloaded", vim.log.levels.INFO)
			end, {})
			
			-- Auto-reload theme when nvim gains focus
			vim.api.nvim_create_autocmd("FocusGained", {
				group = vim.api.nvim_create_augroup("AutoReloadTheme", { clear = true }),
				callback = function()
					-- Silently reload the theme
					pcall(reload_theme)
				end,
			})
		end,
	},
}