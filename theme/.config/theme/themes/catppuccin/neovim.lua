-- Catppuccin theme configuration
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
