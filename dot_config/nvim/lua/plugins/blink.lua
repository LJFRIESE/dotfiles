return {
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      'mikavilpas/blink-ripgrep.nvim',
    },
    build = 'cargo build --release',
    opts = {
      sources = {
        default = {
          'lsp',
          'path',
          'snippets',
          'buffer',
          'lazydev',
          'ripgrep',
        },
        providers = {
          ripgrep = { max_items = 3, score_offset = -2, module = 'blink-ripgrep', name = 'ripgrep' },
          buffer = { fallbacks = { "ripgrep" } },
          lsp = { fallbacks = { "buffer" }, name = 'lsp' },
          lazydev = {
            name = 'lazydev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
          path = { opts = { show_hidden_files_by_default = true } },
        },
      },
      keymap = {
        preset = 'super-tab',
        ['<C-k>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-y>'] = { 'select_and_accept' },
      },
      completion = {
        documentation = {
          window = { border = 'rounded', max_height = 100 },
        },
        menu = {
          draw = {
            columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'source_name' } },
            treesitter = { 'lsp' },
          },
          border = 'rounded',
        },
      },
      signature = {
        enabled = true,
        window = { border = 'rounded' },
      },
    },
    opts_extend = { 'sources.default' },
  },
}
