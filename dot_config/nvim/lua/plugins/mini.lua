return {
  {
    'echasnovski/mini.notify',
    version = '*',
    init = function()
      require('mini.notify').setup()
    end
  },
  {
    'echasnovski/mini.misc',
    version = '*',
    init = function()
      -- Force cwd to always be project root
      require('mini.misc').setup()
      MiniMisc.setup_auto_root()
    end,
  },
  {
    'echasnovski/mini.sessions',
    event = 'VimEnter',
    version = '*',
    init = function()
      require('mini.sessions').setup()
    end,
  },
  {
    'echasnovski/mini.starter',
    lazy = false,
    version = '*',
    dependencies = {
      { 'echasnovski/mini.sessions' },
      'nvim-telescope/telescope-file-browser.nvim',
    },
    config = function()
      -- require('mini.sessions').setup()
      local starter = require('mini.starter')
      starter.setup({
        items = {
          starter.sections.sessions,
          starter.sections.telescope(),
        },
        content_hooks = {
          starter.gen_hook.adding_bullet(),
          starter.gen_hook.aligning('center', 'center'),
        },
      })
    end,
  },
  {
    'echasnovski/mini.surround',
    event = 'VeryLazy',
    config = function()
      require('mini.surround').setup({
        highlight_duration = 500,
        mappings = {
          add = 'gsa',
          delete = 'gsd',
          replace = 'gsr',

          update_n_lines = '',
          suffix_last = '',
          suffix_next = '',
        },
        n_lines = 100,
        respect_selection_type = false,
        search_method = 'cover_or_next',
        silent = false,
      })
    end,
  },
  {
    'echasnovski/mini.ai',
    event = 'VeryLazy',
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        init = function()
          require('lazy.core.loader').disable_rtp_plugin('nvim-treesitter-textobjects')
        end,
      },
    },
    opts = function()
      local ai = require('mini.ai')
      return {
        n_lines = 500,
        custom_textobjects = {
          G = function()
            local from = { line = 1, col = 1 }
            local to = {
              line = vim.fn.line('$'),
              col = math.max(vim.fn.getline('$'):len(), 1)
            }
            return { from = from, to = to }
          end
          ,
          o = ai.gen_spec.treesitter({ -- code block
            a = { '@block.outer', '@conditional.outer', '@loop.outer' },
            i = { '@block.inner', '@conditional.inner', '@loop.inner' },
          }),
          f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }), -- function
          m = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }),       -- class
          t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' },           -- tags
          d = { '%f[%d]%d+' },                                                          -- digits
          e = {                                                                         -- Word with case
            { '%u[%l%d]+%f[^%l%d]', '%f[%S][%l%d]+%f[^%l%d]', '%f[%P][%l%d]+%f[^%l%d]', '^[%l%d]+%f[^%l%d]' },
            '^().*()$',
          },
          u = ai.gen_spec.function_call(),                           -- u for "Usage"
          U = ai.gen_spec.function_call({ name_pattern = '[%w_]' }), -- without dot in function name
        },
      }
    end,
    config = function(_, opts)
      require('mini.ai').setup(opts)
      require('which-key').add({
        {
          mode = { 'n', 'v', 'o', 'x' },
          {
            'a',
            group = '[a]round',
            {
              { 'ao', desc = 'Block, conditional, loop' },
              { "a'", desc = 'Quote `, ", \'' },
              { 'at', desc = 'Tag' },
              { 'a ', desc = 'Whitespace' },
              { 'a?', desc = 'User Prompt' },
              { 'aa', desc = 'Argument' },
              { 'ab', desc = 'Balanced ), ], }' },
              { 'am', desc = 'Method' },
              { 'ac', desc = 'Comment' },
              { 'af', desc = 'Function' },
            },
            -- {
            --   { 'al',  group = '[L]ast ...' },
            --   { 'al ', desc = 'Whitespace' },
            --   { 'al?', desc = 'User Prompt' },
            --   { 'al_', desc = 'Underscore' },
            --   { 'al`', desc = 'Balanced `' },
            --   { 'ala', desc = 'Argument' },
            --   { 'alb', desc = 'Balanced ), ], }' },
            --   { 'alc', desc = 'Class' },
            --   { 'alf', desc = 'Function' },
            --   { 'alo', desc = 'Block, conditional, loop' },
            --   { 'alq', desc = 'Quote `, ", \'' },
            --   { 'alt', desc = 'Tag' },
            -- },
            -- {
            --   { 'an',  group = '[N]ext ...' },
            --   { 'an ', desc = 'Whitespace' },
            --   { 'an?', desc = 'User Prompt' },
            --   { 'an_', desc = 'Underscore' },
            --   { 'an`', desc = 'Balanced `' },
            --   { 'ana', desc = 'Argument' },
            --   { 'anb', desc = 'Balanced ), ], }' },
            --   { 'anc', desc = 'Class' },
            --   { 'anf', desc = 'Function' },
            --  { 'ano', desc = 'Block, conditional, loop' },
            --   { 'anq', desc = 'Quote `, ", \'' },
            --   { 'ant', desc = 'Tag' },
            -- },
            {
              'i',
              group = '[i]nside',
              {
                { 'io', desc = 'Block, conditional, loop' },
                { "a'", desc = 'Quote `, ", \'' },
                { 'it', desc = 'Tag' },
                { 'i ', desc = 'Whitespace' },
                { 'i?', desc = 'User Prompt' },
                { 'ia', desc = 'Argument' },
                { 'ib', desc = 'Balanced ), ], }' },
                { 'im', desc = 'Method' },
                { 'ic', desc = 'Comment' },
                { 'if', desc = 'Function' },
              },
              -- {
              --   { 'il',  group = '[L]ast ...' },
              --   { 'il ', desc = 'Whitespace' },
              --   { 'il?', desc = 'User Prompt' },
              --   { 'il_', desc = 'Underscore' },
              --   { 'ila', desc = 'Argument' },
              --   { 'ilb', desc = 'Balanced ), ], }' },
              --   { 'ilc', desc = 'Class' },
              --   { 'ilf', desc = 'Function' },
              --   { 'ilo', desc = 'Block, conditional, loop' },
              --   { 'ilq', desc = 'Quote `, ", \'' },
              --   { 'ilt', desc = 'Tag' },
              -- },
              -- {
              --   { 'in',  group = '[N]ext ...' },
              --   { 'in ', desc = 'Whitespace' },
              --   { 'in?', desc = 'User Prompt' },
              --   { 'in_', desc = 'Underscore' },
              --   { 'in`', desc = 'Balanced `' },
              --   { 'ina', desc = 'Argument' },
              --   { 'inb', desc = 'Balanced ), ], }' },
              --   { 'inc', desc = 'Class' },
              --   { 'inf', desc = 'Function' },
              --   { 'ino', desc = 'Block, conditional, loop' },
              --   { 'inq', desc = 'Quote `, ", \'' },
              --   { 'int', desc = 'Tag' },
              -- },
            },
          },
        },
      })
    end,
  },
  {
    -- Simple and easy statusline.
    'echasnovski/mini.statusline',
    opts = {
      use_icons = vim.g.have_nerd_font,
      content = {
        active = function()
          local MiniStatusline = require('mini.statusline')
          -- local MiniSessions = require('mini.sessions')
          local get_session = function()
            if vim.v.this_session ~= '' then
              return vim.fs.basename(vim.v.this_session)
            else
              return 'No Active Session'
            end
          end

          local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
          local git = MiniStatusline.section_git({ trunc_width = 40 })
          local diff = MiniStatusline.section_diff({ trunc_width = 75 })
          local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
          local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
          -- local filename = MiniStatusline.section_filename({ trunc_width = 140 })
          local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
          local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
          local cwd = vim.fn.getcwd()

          return MiniStatusline.combine_groups({
            { hl = mode_hl,                 strings = { mode } },
            { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
            '%<%=', -- Mark general truncate point
            { hl = 'MiniStatuslineFilename', strings = { cwd .. ' | ' .. '%t' .. ' | ' .. get_session() } },
            '%=',   -- End left alignment
            { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
            { hl = mode_hl,                  strings = { search, '%2l:%-2L' } },
          })
        end,
      },
    },
  },
}
