return {
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
	},
	{
		"b0o/incline.nvim",
		opts = {},
		event = "VeryLazy",
	},
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			delay = 200,
			large_file_cutoff = 2000,
			large_file_overrides = {
				providers = { "lsp" },
			},
		},
		config = function(_, opts)
			require("illuminate").configure(opts)
		end,
	},
}