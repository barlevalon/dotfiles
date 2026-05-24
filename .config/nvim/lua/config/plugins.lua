local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ import = "plugins" },
	-- Omarchy theme files reference LazyVim/LazyVim as a plugin spec to set
	-- colorscheme opts. Since this config doesn't use LazyVim as a base,
	-- disable it to prevent installation and the "bad import order" warning.
	{ "LazyVim/LazyVim", enabled = false },
}, {
	install = {
		colorscheme = { "catppuccin-macchiato" },
	},
	ui = {
		border = "rounded",
	},
})

vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Lazy", silent = true })
