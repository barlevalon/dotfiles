-- Everforest theme configuration
require("everforest").setup({
	background = "medium", -- "hard", "medium", "soft"
	transparent_background_level = 2, -- 0, 1 or 2
	italics = true,
	disable_italic_comments = false,
	sign_column_background = "none", -- "none" or "grey"
	ui_contrast = "low", -- "low", "high"
	dim_inactive_windows = false,
	diagnostic_text_highlight = true,
	diagnostic_virtual_text = "coloured", -- "grey" or "coloured"
	diagnostic_line_highlight = false,
	spell_foreground = false,
	show_eob = true,
	float_style = "bright", -- "bright" or "dim"
	inlay_hints_background = "none", -- "none" or "dimmed"
	on_highlights = function(hl, palette)
		-- Custom highlights can be added here
	end,
})

vim.cmd.colorscheme("everforest")
