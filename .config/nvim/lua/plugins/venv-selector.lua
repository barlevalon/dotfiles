return {
	"linux-cultist/venv-selector.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
	},
	ft = "python",
	keys = {
		{ ",v", "<cmd>VenvSelect<cr>", desc = "Select Python venv" },
	},
	opts = {
		options = {
			-- Use snacks.nvim as picker since it's already installed
			picker = "snacks",

			-- Enable notifications on venv activation
			notify_user_on_venv_activation = true,

			-- Cache venvs per workspace for automatic reactivation
			enable_cached_venvs = true,
			cached_venv_automatic_activation = true,

			-- Activate venv in new terminals
			activate_venv_in_terminal = true,

			-- Set VIRTUAL_ENV environment variable
			set_environment_variables = true,

			-- Log level for debugging (set to "NONE" after setup is working)
			log_level = "NONE",
		},
		-- Custom searches if needed (defaults work well for uv/poetry/pipenv)
		search = {},
	},
}
