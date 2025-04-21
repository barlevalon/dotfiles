return {
  "someone-stole-my-name/yaml-companion.nvim",
  dependencies = {
    { "neovim/nvim-lspconfig" },
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope.nvim" },
    { "b0o/schemastore.nvim" },
  },
  config = function()
    local yaml_companion = require("yaml-companion")
    -- Only load the extension, don't reconfigure yamlls
    require("telescope").load_extension("yaml_schema")
    
    -- Add commands for yaml schema selection
    vim.api.nvim_create_user_command("YAMLSchema", function()
      vim.cmd("Telescope yaml_schema")
    end, {})
  end,
}
