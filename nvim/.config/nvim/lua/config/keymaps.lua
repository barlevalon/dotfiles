-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap

-- Move Lines
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move current line(s) down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move current line(s) up" })

-- Buffers
keymap.set("n", "<Tab>", ":bn<CR>", { desc = "Next buffer", silent = true })
keymap.set("n", "<S-Tab>", ":bp<CR>", { desc = "Prev buffer", silent = true })

-- Increment/decrement
keymap.set("n", "+", "<C-a>", { desc = "Increment number under cursor" })
keymap.set("n", "-", "<C-x>", { desc = "Decrement number under cursor" })

-- Select all
keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })

-- Replace all instances of highlighted words
keymap.set("v", "<leader>rr", '"hy:%s/<C-r>h//g<left><left>', { desc = "Replace all instances of highlighted words" })
