return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-context',
  },
  build = ':TSUpdate',
  opts = {
    ensure_installed = {
      'go',
      'json',
      'diff',
      'html',
      'lua',
      'vimdoc',
      'sql',
      'r',
      'markdown',
      'markdown_inline',
      'sql',
    },
    auto_install = true,
    indent = { enable = true },
  },
  config = function(_, opts)
    require('nvim-treesitter.install').prefer_git = true
    require('nvim-treesitter.configs').setup(opts)
    require('treesitter-context').setup({
      enable = true,
      max_lines = 4,           -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0,   -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 4, -- Maximum number of lines to show for a single context
      trim_scope = 'inner',    -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = 'cursor',         -- Line used to calculate context. Choices: 'cursor', 'topline'
      separator = '-',
      zindex = 20,
    })
  end,
}
