return {
	"vim-test/vim-test",
	dependencies = {
		"preservim/vimux",
	},
	config = function()
		vim.cmd("let test#strategy = 'vimux'")
	end,

	keys = {
		{
			"<leader>tt",
			"<cmd>TestNearest<cr>",
			desc = "Test Nearest",
		},
		{
			"<leader>tT",
			"<cmd>TestFile<cr>",
			desc = "Test File",
		},
		{
			"<leader>ta",
			"<cmd>TestSuite<cr>",
			desc = "Test Suite",
		},
		{
			"<leader>tl",
			"<cmd>TestLast<cr>",
			desc = "Test Last",
		},
		{
			"<leader>tg",
			"<cmd>TestVisit<cr>",
			desc = "Test Visit",
		},
	},
	-- "nvim-neotest/neotest",
	-- dependencies = {
	-- 	"nvim-lua/plenary.nvim",
	-- 	"antoinemadec/FixCursorHold.nvim",
	-- 	"nvim-treesitter/nvim-treesitter",
	-- 	"nvim-neotest/neotest-go",
	-- },
	-- ft = "go",
	--
	-- config = function()
	-- 	local neotest_ns = vim.api.nvim_create_namespace("neotest")
	-- 	vim.diagnostic.config({
	-- 		virtual_text = {
	-- 			format = function(diagnostic)
	-- 				local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
	-- 				return message
	-- 			end,
	-- 		},
	-- 	}, neotest_ns)
	-- 	require("neotest").setup({
	-- 		adapters = {
	-- 			require("neotest-go"),
	-- 		},
	-- 	})
	-- end,
	--
	--  -- stylua: ignore
	--  keys = {
	--    { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
	--    { "<leader>tT", function() require("neotest").run.run(vim.loop.cwd()) end, desc = "Run All Test Files" },
	--    { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
	--    { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
	--    { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
	--    { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
	--    { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
	--  },
}
