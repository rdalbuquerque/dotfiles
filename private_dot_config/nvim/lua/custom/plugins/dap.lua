return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'leoluz/nvim-dap-go',
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      local dap, dapui, dapgo = require 'dap', require 'dapui', require 'dap-go'
      dapui.setup {
        layouts = {
          {
            elements = {
              { id = 'scopes', size = 0.6 }, -- Give more space for scopes/variables
              { id = 'watches', size = 0.4 },
            },
            position = 'left',
            size = 60, -- Increase the width of the left panel
          },
          {
            elements = {
              'repl',
              'console',
            },
            position = 'bottom',
            size = 10,
          },
        },
      }
      dapgo.setup()

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

      vim.keymap.set('n', '<F5>', function()
        require('dap').continue()
      end)
      vim.keymap.set('n', '<F10>', function()
        require('dap').step_over()
      end)
      vim.keymap.set('n', '<F11>', function()
        require('dap').step_into()
      end)
      vim.keymap.set('n', '<F12>', function()
        require('dap').step_out()
      end)
      vim.keymap.set('n', '<Leader>b', function()
        require('dap').toggle_breakpoint()
      end)
      vim.keymap.set('n', '<Leader>B', function()
        require('dap').set_breakpoint()
      end)
      vim.keymap.set('n', '<Leader>lb', function()
        require('dap').set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
      end)
      vim.keymap.set('n', '<Leader>w', function()
        dapui.open()
      end)
      vim.keymap.set('n', '<Leader>W', function()
        dapui.close()
      end)
    end,
  },
}
