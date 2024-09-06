return {
	"pwntester/octo.nvim",
	cmd = "Octo",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("octo").setup({
			enable_builtin = true,
			gh_env = function()
				local github_token = require("op").get_secret("Github", "token")
				if not github_token or not vim.startswith(github_token, "ghp_") then
					error("Failed to get GitHub token.")
				end
				return { GITHUB_TOKEN = github_token }
			end,
		})
		vim.cmd([[hi OctoEditable guibg=none]])
	end,
	keys = {
		{ "<leader>O", ":Octo<CR>", desc = "Octo" },
	},
}
