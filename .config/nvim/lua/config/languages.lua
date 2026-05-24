local M = {}

M.treesitter = {
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

M.treesitter_indent_disabled = {
	python = true,
	yaml = true,
}

M.lsp_servers = {
	"ts_ls",
	"html",
	"cssls",
	"tailwindcss",
	"svelte",
	"lua_ls",
	"graphql",
	"pyright",
	"gopls",
	"yamlls",
	"terraformls",
	"ansiblels",
	"bashls",
	"jsonls",
}

return M
