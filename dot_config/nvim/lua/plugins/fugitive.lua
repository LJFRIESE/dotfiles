return {
  event = 'VeryLazy',
  'tpope/vim-fugitive',
  config = function()
    vim.keymap.set('n', 'gt', vim.cmd.Git, { desc = 'Git' })
    local ljfries_Fugitive = vim.api.nvim_create_augroup('ljfries_Fugitive', {})

    local autocmd = vim.api.nvim_create_autocmd
    autocmd('BufWinEnter', {
      group = ljfries_Fugitive,
      pattern = '*',
      callback = function()
        if vim.bo.ft ~= 'fugitive' then
          return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set('n', '<leader>p', function()
          vim.cmd.Git('push')
        end, opts)

        -- rebase always
        vim.keymap.set('n', '<leader>P', function()
          vim.cmd.Git({ 'pull', '--rebase' })
        end, opts)
      end,
    })
  end,
}
