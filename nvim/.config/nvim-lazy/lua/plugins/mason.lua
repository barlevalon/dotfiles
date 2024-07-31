return {
  "williamboman/mason.nvim",
    opts = function (_, opts)
      vim.list_extend(opts.ensure_installed, {
        "terraform-ls",
        "tflint",
        "markdownlint",
        "gopls",
        "bash-language-server",
        "ansible-language-server",
        "ansible-lint",
        "json-lsp",
        "lua-language-server",
        "markdownlint",
        "rust-analyzer",
        "typescript-language-server"
      })
    end,
}
