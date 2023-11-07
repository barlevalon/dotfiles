-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Move Lines
vim.keymap.set("n", "<leader>j", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("n", "<leader>k", "<cmd>m .-2<cr>==", { desc = "Move up" })
-- vim.keymap.set("i", "<leader>j", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
-- vim.keymap.set("i", "<leader>k", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "<leader>j", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "<leader>k", ":m '<-2<cr>gv=gv", { desc = "Move up" })
vim.keymap.set("n", "<A-\\>", ":silent !tmux neww tmux-sessionizer<CR>", { silent=true, desc = "tmux session" })

vim.keymap.set("n", "<Tab>", ":bn<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":bp<CR>", { desc = "Prev buffer" })
