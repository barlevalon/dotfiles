return {
  "alexghergh/nvim-tmux-navigation",
  opts = {
    disable_when_zoomed = true,
    keybindings = {
      left = "<C-h>",
      down = "<C-j>",
      up = "<C-k>",
      right = "<C-l>",
      last_active = "<C-\\>",
      next = "<A-Space>",
    },
  },
  keys = {
    { "<C-h>", "<cmd>NvimTmuxNavigateLeft<cr>", desc = "Move to left window" },
    { "<C-j>", "<cmd>NvimTmuxNavigateDown<cr>", desc = "Move to down window" },
    { "<C-k>", "<cmd>NvimTmuxNavigateUp<cr>", desc = "Move to up window" },
    { "<C-l>", "<cmd>NvimTmuxNavigateRight<cr>", "Move to Right window" },
    { "<C-\\>", "<cmd>NvimTmuxNavigateLastActive<cr>", desc = "Move to last active window" },
    { "<A-Space>", "<cmd>NvimTmuxNavigateNext<cr>", desc = "Move to next window" },
  },
}
