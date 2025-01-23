return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		-- bigfile = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		-- statuscolumn = { enabled = true },
		-- words = { enabled = true },
		lazygit = {},
	},
	keys = {
		{
			"<leader>gg",
			function()
				Snacks.lazygit.open()
			end,
			desc = "LazyGit",
			silent = true,
		},
		{
			"<leader>gf",
			function()
				Snacks.lazygit.log_file()
			end,
			desc = "LazyGit file history",
			silent = true,
		},
		{
			"<leader>gl",
			function()
				Snacks.lazygit.log()
			end,
			desc = "LazyGit log",
			silent = true,
		},
	},
}
