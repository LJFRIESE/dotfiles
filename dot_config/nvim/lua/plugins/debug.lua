return {
  lazy = true,
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'leoluz/nvim-dap-go',
  },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')
    -- vim.keymap.set('n', '<leader>B', function()
    --   dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    -- end, { desc = 'Debug: Set Breakpoint' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup({
      layouts = {
        {
          elements = {
            {
              id = 'breakpoints',
              size = 0.15,
            },
            {
              id = 'watches',
              size = 0.35,
            },
            -- {
            --   id = 'stacks',
            --   size = 0.25,
            -- },
            {
              id = 'repl',
              size = 0.50,
            },
          },
          position = 'left',
          size = 10,
        },
        {
          elements = { {
            id = 'scopes',
            size = .75
          } },
          position = 'bottom',
          size = 15,
        },
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        controls = {
          icons = {
            pause = '⏸',
            play = '▶',
            step_into = '⏎',
            step_over = '⏭',
            step_out = '⏮',
            step_back = 'b',
            run_last = '▶▶',
            terminate = '⏹',
            disconnect = '⏏',
          },
        },
      },
    }
    )


    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup({})
  end,
}
