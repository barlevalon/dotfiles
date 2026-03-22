return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				-- System languages
				"c",
				"rust",
				"go",
				"gomod",
				"gosum",
				"gowork",

				-- Web/Frontend
				"javascript",
				"typescript",
				"tsx",
				"html",
				"css",
				"scss",
				"json",
				"jsdoc",

				-- Scripting/Dynamic
				"python",
				"ruby",
				"lua",
				"luadoc",
				"bash",
				"fish",

				-- Config/DevOps
				"yaml",
				"toml",
				"dockerfile",
				"terraform",
				"hcl",
				"nix",
				"proto",
				"sql",

				-- Markup/Data
				"markdown",
				"markdown_inline",
				"xml",
				"csv",
				"regex",

				-- Vim internals
				"vim",
				"vimdoc",
				"query",
			},
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
		})
	end,
}
