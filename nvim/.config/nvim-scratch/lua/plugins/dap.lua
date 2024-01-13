return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"leoluz/nvim-dap-go",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			local keymap = vim.keymap.set

			dapui.setup()
			require("dap-go").setup()

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			keymap("n", "<leader>dc", function()
				dap.continue()
			end, { desc = "Continue" })
			keymap("n", "<leader>ds", function()
				dap.step_over()
			end, { desc = "Step over" })
			keymap("n", "<leader>di", function()
				dap.step_into()
			end, { desc = "Step into" })
			keymap("n", "<leader>do", function()
				dap.step_out()
			end, { desc = "Step out" })
			keymap("n", "<leader>db", function()
				dap.toggle_breakpoint()
			end, { desc = "Toggle breakpoint" })
			keymap("n", "<leader>dl", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "Set breakpoint condition" })
		end,
	},
}
