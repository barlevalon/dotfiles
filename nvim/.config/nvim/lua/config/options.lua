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
opt.undofile = true
opt.hlsearch = true

vim.g.clipboard = {
	name = "pb",
	copy = {
		["+"] = "pbcopy",
		["*"] = "pbcopy",
	},
	paste = {
		["+"] = "pbpaste",
		["*"] = "pbpaste",
	},
}
