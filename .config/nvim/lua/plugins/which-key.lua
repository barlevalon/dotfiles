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
			{ "<leader>g", group = "git" },
			{ "<leader>gh", group = "hunk" },
			{ "<leader>q", group = "quit" },
			{ "<leader>s", group = "split" },
			{ "<leader>t", group = "tab" },
			{ "<leader>u", group = "ui" },
			{ "<leader>x", group = "trouble" },
			{ "gs", group = "surround" },
		})
	end,
}
