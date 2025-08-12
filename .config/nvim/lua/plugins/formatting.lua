return {
	"stevearc/conform.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
				go = { "gofumpt", "goimports" },
				terraform = { "terraform_fmt" },
				tf = { "terraform_fmt" },
				["terraform-vars"] = { "terraform_fmt" },
			},
			-- only format changed lines on save
			format_on_save = function(bufnr)
				local ignore_filetypes = { "lua" }
				if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
					return { timeout_ms = 500, lsp_fallback = true }
				end
				local lines = vim.fn.system("git diff --unified=0 " .. vim.fn.bufname(bufnr)):gmatch("[^\n\r]+")
				local ranges = {}
				for line in lines do
					if line:find("^@@") then
						local line_nums = line:match("%+.- ")
						if line_nums:find(",") then
							local _, _, first, second = line_nums:find("(%d+),(%d+)")
							table.insert(ranges, {
								start = { tonumber(first), 0 },
								["end"] = { tonumber(first) + tonumber(second), 0 },
							})
						else
							local first = tonumber(line_nums:match("%d+"))
							table.insert(ranges, {
								start = { first, 0 },
								["end"] = { first + 1, 0 },
							})
						end
					end
				end
				local format = require("conform").format
				for _, range in pairs(ranges) do
					format({ range = range })
				end
			end,
		})

		vim.keymap.set({ "n", "v" }, "<leader>cf", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format" })
	end,
}
