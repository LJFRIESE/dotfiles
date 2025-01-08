return {
  'stevearc/conform.nvim',
  opts = {
    -- log_level = vim.log.levels.DEBUG,
    notify_on_error = true,
    formatters = {
      sqlfluff = {
        args = {
          'fix',
          '--dialect=oracle',
          '--processes=-1',
        },
      },
      styler = {
        -- hijacking "https://github.com/devOpifex/r.nvim",
        args = { '-s', '-e', 'styler::style_file(commandArgs(TRUE))', '--args', '$FILENAME' },
        stdin = false,
      },
    },
    formatters_by_ft = {
      go = { 'gofmt' },
      markdown = { 'prettierd' },
      python = { 'ruff_format' },
      lua = { 'stylua' },
      sql = { 'sqlfluff' },
      r = { 'styler' },
      quarto = { 'styler' },
      json = { 'jq' },

      default_format_opts = {
        lsp_format = 'fallback',
      },

      -- format_on_save = { timeout_ms = 500, lsp_format = 'fallback' },
    },
  },
}
