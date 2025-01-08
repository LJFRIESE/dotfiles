return {
  enabled = false,
  { 'williamboman/mason.nvim', opts = { ui = { title = 'Mason', border = 'rounded' }, log_level = vim.log.levels.DEBUG } },
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  opts = function()
    local ensure_installed = {
      'lua_ls',
      'sqls',
      'prettierd',
      'gopls',
      'markdownsman',
      'stylua',
      'sqlfluff',
      'tree-sitter-cli',
    }
    require('mason-tool-installer').setup({ ensure_installed = ensure_installed })
  end,
}
