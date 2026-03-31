return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local query = require("vim.treesitter.query")
		local directive_opts = vim.fn.has("nvim-0.10") == 1 and { force = true, all = false } or true

		-- Work around nvim-treesitter on Neovim 0.12 passing markdown info-string captures
		-- as a list in set-lang-from-info-string!, which breaks fenced code block injections.
		query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
			local node = match[pred[2]]
			if type(node) == "table" then
				node = node[1]
			end
			if not node then
				return
			end

			local injection_alias = vim.treesitter.get_node_text(node, bufnr):lower()
			local language = vim.filetype.match({ filename = "a." .. injection_alias })
				or ({ ex = "elixir", pl = "perl", sh = "bash", uxn = "uxntal", ts = "typescript" })[injection_alias]
				or injection_alias
			metadata["injection.language"] = language
		end, directive_opts)

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
