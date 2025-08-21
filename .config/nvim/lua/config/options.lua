local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.cmdheight = 0
opt.cursorline = true
opt.clipboard:append("unnamedplus")
opt.ignorecase = true
opt.smartcase = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.swapfile = false
opt.scrolloff = 10
opt.smoothscroll = true  -- Smooth scrolling for <C-d>, <C-u>, etc.
opt.updatetime = 250  -- Faster CursorHold events (default: 4000)
opt.undofile = true
opt.hlsearch = true

vim.g.clipboard = {
	name = "wl",
	copy = {
		["+"] = "wl-copy",
		["*"] = "wl-copy",
	},
	paste = {
		["+"] = "wl-paste",
		["*"] = "wl-paste",
	},
}

local highlight_yank = vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
	end,
	group = highlight_yank,
})
