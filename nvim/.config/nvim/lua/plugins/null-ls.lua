return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufRead", "BufNewFile" },
    dependencies = {"mason.nvim"},
    opts = function ()
      local nls = require("null-ls")
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          nls.builtins.diagnostics.shellcheck,
          nls.builtins.diagnostics.markdownlint,
          nls.builtins.diagnostics.terraform_validate,
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.shfmt,
          nls.builtins.formatting.terraform_fmt,
        },
      }
    end,
  },
}

