return {
  { "nvim-neotest/neotest-plenary" },
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        "neotest-go",
        "neotest-rust",
      }
    },
  },
}
