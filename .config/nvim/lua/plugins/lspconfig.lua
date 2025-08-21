return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"saghen/blink.cmp",
		"b0o/schemastore.nvim",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- Disable default LSP keymaps to avoid conflicts
		vim.keymap.del("n", "grr")
		vim.keymap.del("n", "gra")
		vim.keymap.del("x", "gra")
		vim.keymap.del("n", "grn")
		vim.keymap.del("n", "gri")
		vim.keymap.del("n", "grt")

		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- Configure diagnostic signs (modern approach)
		local signs = {
			Error = " ",
			Warn = " ",
			Hint = "󰌵 ",
			Info = " ",
		}

		local signConf = {
			text = {},
			texthl = {},
			numhl = {},
		}

		for type, icon in pairs(signs) do
			local severityName = string.upper(type)
			local severity = vim.diagnostic.severity[severityName]
			local hl = "DiagnosticSign" .. type
			signConf.text[severity] = icon
			signConf.texthl[severity] = hl
			signConf.numhl[severity] = hl
		end

		vim.diagnostic.config({
			signs = signConf,
		})

		-- Set up keymaps when LSP attaches to a buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
			callback = function(event)
				local opts = { buffer = event.buf, noremap = true, silent = true }

				opts.desc = "Hover"
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Definitions"
				vim.keymap.set("n", "gd", function()
					Snacks.picker.lsp_definitions()
				end, opts)

				opts.desc = "Implementations"
				vim.keymap.set("n", "gi", function()
					Snacks.picker.lsp_implementations()
				end, opts)

				opts.desc = "References"
				vim.keymap.set("n", "gr", function()
					Snacks.picker.lsp_references()
				end, opts)

				opts.desc = "Actions"
				vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Rename"
				vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)

				opts.desc = "File Diagnostics"
				vim.keymap.set("n", "<leader>D", function()
					Snacks.picker.diagnostics({ current = true })
				end, opts)

				opts.desc = "Line diagnostics"
				vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Prev diagnostic"
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

				opts.desc = "Next diagnostic"
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

				opts.desc = "Restart LSP"
				vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
			end,
		})

		-- Configure specific servers with custom settings
		-- These will be picked up automatically when servers are enabled
		local lspconfig = require("lspconfig")

		-- Configure servers that need special settings
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
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

		lspconfig.yamlls.setup({
			capabilities = capabilities,
			settings = {
				yaml = {
					schemaStore = {
						enable = false,
						url = "",
					},
					schemas = require("schemastore").yaml.schemas(),
				},
			},
		})

		lspconfig.jsonls.setup({
			capabilities = capabilities,
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
		})
	end,
}
