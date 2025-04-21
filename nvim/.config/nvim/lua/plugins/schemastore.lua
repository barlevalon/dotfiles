return {
	"b0o/schemastore.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
	},
	config = function()
		local lspconfig = require("lspconfig")
		
		-- Configure YAML language server
		lspconfig.yamlls.setup({
			settings = {
				yaml = {
					schemaStore = {
						-- Disable built-in schemaStore support
						enable = false,
						-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
						url = "",
					},
					-- Use schemastore.nvim instead
					schemas = require("schemastore").yaml.schemas(),
				},
			},
		})
		
		-- Configure JSON language server
		lspconfig.jsonls.setup({
			settings = {
				json = {
					-- Use schemastore.nvim for JSON schemas
					schemas = require("schemastore").json.schemas(),
					-- Enable validation
					validate = { enable = true },
				},
			},
		})
	end,
}
