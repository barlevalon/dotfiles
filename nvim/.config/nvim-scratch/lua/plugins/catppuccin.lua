return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	opts = {
		background = {
			light = "latte",
			dark = "macchiato",
		},
		transparent_background = true,
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
		},
	},
	config = function()
		vim.cmd([[colorscheme catppuccin]])
	end,
}
