-- Dynamic theme loading based on system theme
return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			-- Try to load theme config
			local theme_file = vim.fn.expand("~/.config/theme/current/theme/neovim.lua")
			if vim.fn.filereadable(theme_file) == 1 then
				dofile(theme_file)
			else
				-- Fallback to default
				require("catppuccin").setup({
					transparent_background = true,
					term_colors = true,
					flavour = "macchiato",
					background = {
						light = "latte",
						dark = "macchiato",
					},
					integrations = {
						alpha = true,
						mason = true,
						neotest = true,
						lsp_trouble = true,
						illuminate = {
							enabled = true,
							lsp = false,
						},
						which_key = true,
						neotree = true,
						notify = true,
					},
				})
				vim.cmd.colorscheme("catppuccin")
			end
		end,
	},
}