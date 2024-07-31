return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function (_, opts)
      vim.list_extend(opts.ensure_installed, {
        "hcl",
        "terraform",
        "bash",
        "vimdoc",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "ron",
        "rust",
        "toml"
      })
    end,
  },
}
