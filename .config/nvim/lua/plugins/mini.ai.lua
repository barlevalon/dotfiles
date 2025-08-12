return {
	"echasnovski/mini.ai",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	version = false,
	config = function()
		local gen_spec = require("mini.ai").gen_spec
		require("mini.ai").setup({
			custom_textobjects = {
				F = gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
				c = gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
			},
		})
	end,
	opts = {},
}
