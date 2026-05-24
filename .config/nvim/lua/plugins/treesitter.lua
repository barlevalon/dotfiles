local languages = require("config.languages")

return {
	"nvim-treesitter/nvim-treesitter",
	url = "https://github.com/neovim-treesitter/nvim-treesitter",
	dependencies = { "neovim-treesitter/treesitter-parser-registry" },
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup()
		require("nvim-treesitter").install(languages.treesitter)

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("user.treesitter", { clear = true }),
			pattern = languages.treesitter,
			callback = function(args)
				if not pcall(vim.treesitter.start, args.buf) then
					return
				end

				vim.wo.foldmethod = "expr"
				vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
				vim.wo.foldlevel = 99

				local ft = vim.bo[args.buf].filetype
				if not languages.treesitter_indent_disabled[ft] then
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
