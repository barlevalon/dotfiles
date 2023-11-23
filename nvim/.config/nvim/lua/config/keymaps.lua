-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap

-- Move Lines
keymap.set("n", "<leader>j", "<cmd>m .+1<cr>==", { desc = "Move down" })
keymap.set("n", "<leader>k", "<cmd>m .-2<cr>==", { desc = "Move up" })
-- vim.keymap.set("i", "<leader>j", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
-- vim.keymap.set("i", "<leader>k", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
keymap.set("v", "<leader>j", ":m '>+1<cr>gv=gv", { desc = "Move down" })
keymap.set("v", "<leader>k", ":m '<-2<cr>gv=gv", { desc = "Move up" })

keymap.set("n", "<Tab>", ":bn<CR>", { desc = "Next buffer", silent = true })
keymap.set("n", "<S-Tab>", ":bp<CR>", { desc = "Prev buffer", silent = true })

-- Increment/decrement
keymap.set("n", "+", "<C-a>", { desc = "Increment number under cursor" })
keymap.set("n", "-", "<C-x>", { desc = "Decrement number under cursor" })

-- Select all
keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })
