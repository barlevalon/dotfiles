return {
  "nvim-telescope/telescope.nvim",
  opts = {
    pickers = {
      find_files = {
        -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
      },
      live_grep = {
        cmd = { "rg", "--column", "--line-number", "--no-heading", "--color=never", "--hidden", "-g", "!**/.git/*" },
      },
    },
  },
}
