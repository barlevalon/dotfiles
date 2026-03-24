return {
	-- Mason: package manager for LSP servers, formatters, linters
	{
		"mason-org/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
		keys = {
			{ "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
		},
	},

	-- Bridge mason <-> lspconfig: auto-install and auto-enable LSP servers
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
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
				"golangci_lint_ls",
				"jsonls",
			},
			automatic_enable = {
				exclude = { "golangci_lint_ls" },
			},
		},
	},

	-- Auto-install formatters and linters
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = {
				"prettier",
				"stylua",
				"isort",
				"black",
				"ruff",
				"eslint_d",
				"gofumpt",
				"goimports",
				"golangci-lint",
				"tflint",
			},
		},
	},
}
