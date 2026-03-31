return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	opts = {
		presets = {
			lsp_doc_border = true,
			command_palette = true,
			long_message_to_split = true,
			bottom_search = true,
		},
	},
}
