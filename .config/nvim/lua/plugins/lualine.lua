return {
	"nvim-lualine/lualine.nvim",
	dependencies = { 
		"nvim-tree/nvim-web-devicons",
		"linux-cultist/venv-selector.nvim",
	},
	opts = {
		theme = "catppuccin",
		globalstatus = true,
		sections = {
			lualine_c = { "filename" },
			lualine_x = { 
				"venv-selector",
				"encoding", 
				"fileformat", 
				"filetype" 
			},
		},
	},
}
