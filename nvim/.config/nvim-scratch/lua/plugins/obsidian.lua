return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	event = {
    -- stylua: ignore
		"BufReadPre " .. vim.fn.expand("~") .. "/notes/**.md",
		"BufNewFile " .. vim.fn.expand("~") .. "/notes/**.md",
	},
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		workspaces = {
			{
				name = "notes",
				path = "~/notes",
			},
		},
		daily_notes = {
			folder = "Daily",
		},
	},
}
