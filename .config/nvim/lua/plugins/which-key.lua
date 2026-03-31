return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	config = function()
		local wk = require("which-key")
		wk.add({
			{ "<leader>b", group = "buffer" },
			{ "<leader>c", group = "code" },
			{ "<leader>d", group = "debug" },
			{ "<leader>f", group = "find" },
			{ "<leader>g", group = "git" },
			{ "<leader>gh", group = "hunk" },
			{ "<leader>q", group = "quit" },
			{ "<leader>s", group = "split" },
			{ "<leader>t", group = "test" },
			{ "<leader>u", group = "ui" },
			{ "<leader>w", group = "window" },
			{ "<leader>x", group = "trouble" },
			{ "gs", group = "surround" },
		})
	end,
}
