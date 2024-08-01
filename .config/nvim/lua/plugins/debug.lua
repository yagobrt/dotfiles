local map = function(keys, func, desc)
	vim.keymap.set("n", keys, func, { desc = "Debug: " .. desc })
end

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			require("mason-nvim-dap").setup({
				automatic_setup = true,
				handlers = {},
				ensure_installed = {},
			})
			map("<leader>ds", dap.continue, "[D]ebug [S]tart/Continue")
			map("<leader>dx", dap.terminate, "[D]ebug e[X]it")
			map("<leader>di", dap.step_into, "[D]ebug step [I]nto")
			map("<leader>do", dap.step_out, "[D]ebug step [O]ut")
			map("<leader>dn", dap.step_over, "[D]ebug step to [N]ext line")
			map("<leader>dp", dap.step_back, "[D]ebug step to [P]revious line")
			map("<leader>tdb", dap.toggle_breakpoint, "[T]oggle [D]ebug [B]reakpoint")
			map("<leader>tdB", function()
				dap.toggle_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, "[T]oggle conditional [D]ebug [B]reakpoint")

			dapui.setup()
			map("<leader>dr", dapui.toggle, "[D]ebug show last session [R]esult")
			dap.listeners.after.event_initialized["dapui_config"] = dapui.open
			dap.listeners.before.event_terminated["dapui_config"] = dapui.close
			dap.listeners.before.event_exited["dapui_config"] = dapui.close
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
		},
		config = function()
			-- local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
			local path = "/usr/bin/python"
			require("dap-python").setup(path)
		end,
	},
	{
		"leoluz/nvim-dap-go",
		ft = "go",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
		},
		config = function()
			require("dap-go").setup()
		end,
	},
}
