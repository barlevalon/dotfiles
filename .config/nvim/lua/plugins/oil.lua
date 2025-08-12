return {
	"stevearc/oil.nvim",
	opts = {
		view_options = {
			show_hidden = true,
		},
		float = {
			preview_split = "right",
		},
		keymaps = {
			["q"] = { "actions.close", mode = "n" },
		},
	},
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "<leader>o", "<cmd>Oil --float<cr>", desc = "Oil" },
	},
}
