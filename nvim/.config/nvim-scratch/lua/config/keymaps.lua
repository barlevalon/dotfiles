vim.g.mapleader = " "

local map = vim.keymap.set

map("n", "<leader>uh", "<cmd>nohl<CR>", { desc = "Clear search highlights" })

map("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Quit", silent = true })
map("n", "<leader>qw", "<cmd>wqa<CR>", { desc = "Quit (write)", silent = true })

-- window management
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- tabs
map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
map("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
map("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
map("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Navigate panes
map("n", "<C-h>", "<cmd>wincmd h<CR>", { desc = "Pane left", silent = true })
map("n", "<C-j>", "<cmd>wincmd j<CR>", { desc = "Pane down", silent = true })
map("n", "<C-k>", "<cmd>wincmd k<CR>", { desc = "Pane up", silent = true })
map("n", "<C-l>", "<cmd>wincmd l<CR>", { desc = "Pane right", silent = true })

-- Move Lines
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move current line(s) down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move current line(s) up" })

-- Buffers
map("n", "<Tab>", ":bn<CR>", { desc = "Next buffer", silent = true })
map("n", "<S-Tab>", ":bp<CR>", { desc = "Prev buffer", silent = true })

-- Increment/decrement
map("n", "+", "<C-a>", { desc = "Increment number under cursor" })
map("n", "-", "<C-x>", { desc = "Decrement number under cursor" })

-- Select all
map("n", "<C-a>", "ggVG", { desc = "Select all" })

-- Replace all instances of highlighted words
map("v", "<leader>rr", '"hy:%s/<C-r>h//g<left><left>', { desc = "Replace all instances of highlighted words" })

map("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit", silent = true })
