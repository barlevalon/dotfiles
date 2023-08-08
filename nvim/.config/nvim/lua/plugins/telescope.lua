return {
  "nvim-telescope/telescope.nvim",
  opts = {
    pickers = {
      find_files = {
        -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
        additional_args = { "--hidden", "-g=!**/.git/*" },
      },
      live_grep = {
        additional_args = { "--hidden", "-g=!**/.git/*" },
      },
    },
  },
}
