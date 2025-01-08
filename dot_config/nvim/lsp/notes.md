
local servers = {
  markdown_oxide = {
    filetypes = { 'markdown' }, --'quarto' },
    server_capabilities = {
      workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
      },
    },
  },
  ruff = {
    filetypes = { 'python' },
  },
  -- SQLS is a little bitch. It will only run with this exact cmd.
  -- config.yml file must be in the /user/{USER}
  -- Anything else and it will break.
  -- SQLS is CASE-SENSITIVE from join snippets. Table names must be matched to
  -- trigger them.
  -- Doesn't compile on pi
  -- sqls = {
  --   cmd = { 'sqls', '-config', 'config.yml' },
  --   server_capabilities = {
  --     documentFormattingProvider = false,
  --   },
  -- },
  -- marksman = {
  --   filetypes = { 'quarto' },
  --   root_dir = util.root_pattern('.git', '.marksman.toml', '_quarto.yml'),
  -- },
  -- r_language_server = {
  --   server_capabilities = {
  --     workspace = {
  --       didChangeWatchedFiles = {
  --         dynamicRegistration = false, -- stops quarto preview fighting with nvim
  --       },
  --     },
  --   },
  --   settings = {
  --     r = {
  --       flags = lsp_flags,
  --       lsp = {
  --         rich_documentation = false,
  --       },
  --     },
  --   },
  -- },
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = { disable = { 'missing-parameter', 'missing-fields' }, globals = { 'vim' } },
      },
    },
  },
}
