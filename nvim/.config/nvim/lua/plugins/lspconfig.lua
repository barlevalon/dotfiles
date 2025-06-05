return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- Disable default LSP keymaps to avoid conflicts
		vim.keymap.del("n", "grr")
		vim.keymap.del("n", "gra")
		vim.keymap.del("x", "gra")
		vim.keymap.del("n", "grn")
		vim.keymap.del("n", "gri")

		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local keymap = vim.keymap

		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			opts.desc = "Hover"
			keymap.set("n", "K", vim.lsp.buf.hover, opts)

			opts.desc = "Definitions"
			keymap.set("n", "gd", function()
				Snacks.picker.lsp_definitions()
			end, opts)

			opts.desc = "Implementations"
			keymap.set("n", "gi", function()
				Snacks.picker.lsp_implementations()
			end, opts)

			opts.desc = "References"
			keymap.set("n", "gr", function()
				Snacks.picker.lsp_references()
			end, opts)

			opts.desc = "Actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

			opts.desc = "Rename"
			keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)

			opts.desc = "File Diagnostics"
			keymap.set("n", "<leader>D", function()
				Snacks.picker.diagnostics({ current = true })
			end, opts)

			opts.desc = "Line diagnostics"
			keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

			opts.desc = "Prev diagnostic"
			keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

			opts.desc = "Next diagnostic"
			keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
		end

		local capabilities = cmp_nvim_lsp.default_capabilities()

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		lspconfig.terraformls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig.ts_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})

		-- Disable golangci_lint_ls entirely
		lspconfig.golangci_lint_ls = nil

		-- Set default handler for auto-started servers to use our on_attach
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(event)
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.name == "gopls" then
					on_attach(client, event.buf)
				end
			end,
		})
	end,
}
