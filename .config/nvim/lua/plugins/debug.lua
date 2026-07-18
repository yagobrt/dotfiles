return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',
    },
    keys = {
      -- Basic debugging keymaps, feel free to change to your liking!
      { '<F5>', function() require('dap').continue() end, desc = '[D]ebug: [S]tart/Continue' },
      { '<leader>ds', function() require('dap').continue() end, desc = '[D]ebug: [S]tart/Continue' },

      { '<leader>dx', function() require('dap').terminate() end, desc = '[D]ebug: E[X]it' },

      { '<F1>', function() require('dap').step_into() end, desc = '[D]ebug: Step [I]nto' },
      { '<leader>di', function() require('dap').step_into() end, desc = '[D]ebug: Step [I]nto' },

      { '<F2>', function() require('dap').step_over() end, desc = '[D]ebug: step to [N]ext line' },
      { '<leader>dn', function() require('dap').step_over() end, desc = '[D]ebug: step to [N]ext line' },
      { '<leader>dp', function() require('dap').step_back() end, desc = '[D]ebug: step to [P]revious line' },

      { '<F3>', function() require('dap').step_out() end, desc = '[D]ebug: Step [O]ut' },
      { '<leader>do', function() require('dap').step_out() end, desc = '[D]ebug: Step [O]ut' },

      { '<leader>b', function() require('dap').toggle_breakpoint() end, desc = '[D]ebug: Toggle [B]reakpoint' },

      { '<leader>B', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, desc = '[D]ebug: Set Breakpoint' },
      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      { '<F7>', function() require('dapui').toggle() end, desc = '[D]ebug: See last session [R]esult.' },
      { '<leader>dr', function() require('dapui').toggle() end, desc = '[D]ebug: See last session [R]esult' },
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      require('mason-nvim-dap').setup {
        automatic_installation = true,
        handlers = {},
        ensure_installed = {},
      }

      dapui.setup()

      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close
    end,
  },
  {
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    dependencies = {
      'mfussenegger/nvim-dap',
      'rcarriga/nvim-dap-ui',
    },
    config = function()
      -- local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      local path = '/usr/bin/python'
      require('dap-python').setup(path)
    end,
  },
  {
    'leoluz/nvim-dap-go',
    ft = 'go',
    dependencies = {
      'mfussenegger/nvim-dap',
      'rcarriga/nvim-dap-ui',
    },
    config = function() require('dap-go').setup() end,
  },
}
