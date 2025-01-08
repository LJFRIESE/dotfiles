return { { -- This plugin
  event = 'VeryLazy',
  'Zeioth/compiler.nvim',
  cmd = { 'CompilerOpen', 'CompilerToggleResults', 'CompilerRedo' },
  dependencies = { 'stevearc/overseer.nvim', 'nvim-telescope/telescope.nvim' },
  opts = {},
  keys = {
    { '<leader>cr', '<cmd>CompilerToggleResults<cr>', desc = '[R]esults toggle', noremap = true, silent = true },
    { '<leader>co', '<cmd>CompilerOpen<cr>',          desc = '[O]pen Compiler',  noremap = true, silent = true },
    {
      '<leader>ca',
      '<cmd>CompilerStop<cr>' .. '<cmd>CompilerRedo<cr>',
      desc = 'Compile [A]gain',
      noremap = true,
      silent = true,
    },
  },
}, { -- The task runner we use
  'stevearc/overseer.nvim',
  commit = '6271cab7ccc4ca840faa93f54440ffae3a3918bd',
  cmd = { 'CompilerOpen', 'CompilerToggleResults', 'CompilerRedo' },
  opts = {
    task_list = {
      direction = 'bottom',
      min_height = 25,
      max_height = 25,
      default_detail = 1,
    },
  },
} }
