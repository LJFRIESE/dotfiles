return {
  'Wansmer/treesj',
  event = 'VeryLazy',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('treesj').setup({ max_join_length = 120, use_default_keymaps = false })
    vim.keymap.set('n', '<c-j>', require('treesj').toggle, { desc = 'Toggle [j]oin node' })
  end,
}