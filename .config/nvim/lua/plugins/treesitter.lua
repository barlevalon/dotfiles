return {
	"nvim-treesitter/nvim-treesitter",
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

		-- nvim-treesitter main branch API (Neovim 0.11+)
		-- Old configs used `configs.setup()` with highlight.enable
		-- New API: setup() only sets install_dir, highlighting via native vim.treesitter
		require("nvim-treesitter").setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})

		local parsers = {
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
		}

		-- Install parsers asynchronously (background)
		require("nvim-treesitter").install(parsers)

		-- Auto-enable treesitter highlighting for all installed parsers
		-- Note: vim.treesitter.start() is the native Neovim API
		local installed = require("nvim-treesitter").get_installed("parsers")
		vim.api.nvim_create_autocmd("FileType", {
			pattern = installed,
			callback = function() vim.treesitter.start() end,
		})
	end,
}
