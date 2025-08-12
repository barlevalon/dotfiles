return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"markdown",
				"markdown_inline",
				"hcl",
				"terraform",
			},
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
