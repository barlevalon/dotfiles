return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	config = function()
		local wk = require("which-key")
		wk.register({
			["<leader>"] = {
				c = { name = "+code" },
				d = { name = "+debug" },
				g = { name = "+git", h = { name = "+hunk" } },
				s = { name = "+split" },
				t = { name = "+tab" },
				b = { name = "+buffer" },
				u = { name = "+ui" },
				x = { name = "+trouble" },
				q = { name = "+quit" },
			},
			["g"] = {
				s = { name = "+surround" },
			},
		})
	end,
}
