return {
	"mfussenegger/nvim-lint",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
	config = function()
		local lint = require("lint")
		local golint = require("lint").linters.golangcilint

		golint.args = {
			"run",
			"--output.json.path=stdout",
			"--issues-exit-code=0",
			"--show-stats=false",
			function()
				return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
			end,
		}

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
			python = { "ruff" },
			terraform = { "terraform_validate" },
			tf = { "terraform_validate" },
			go = { "golangcilint" },
			yaml = { "yamllint" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		local function lint_opts(bufnr)
			if vim.bo[bufnr].filetype ~= "go" then
				return nil
			end

			local buf = vim.api.nvim_buf_get_name(bufnr)
			local root = vim.fs.root(buf, { "go.work", "go.mod", ".golangci.yml", ".golangci.yaml", ".git" })
			if not root then
				return nil
			end

			return { cwd = root }
		end

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint(nil, lint_opts(vim.api.nvim_get_current_buf()))
			end,
		})

		vim.keymap.set("n", "<leader>cl", function()
			lint.try_lint(nil, lint_opts(vim.api.nvim_get_current_buf()))
		end, { desc = "Lint" })
	end,
}
