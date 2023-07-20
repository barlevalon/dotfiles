return {
  {
    "zbirenbaum/copilot.lua",
    event = "VeryLazy",
    config = true,
  },

  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    event = "VeryLazy",
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  {
    "nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.mapping = {
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        }),
      }
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
        { name = "copilot" },
      }))
    end,
  },
}
