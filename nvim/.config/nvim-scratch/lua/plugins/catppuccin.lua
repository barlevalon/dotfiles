return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  opts = {
    background = {
      light = "latte",
      dark = "macchiato",
    },
    transparent_background = true,
  },
  config = function()
    vim.cmd([[colorscheme catppuccin]])
  end,
}
