return {
  'ggandor/leap.nvim',
  event = 'VeryLazy',
  config = function()
    vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap-forward)', {desc = 'leap forwards to ...'})
    vim.keymap.set({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-backward)', {desc = 'leap backwards to ...'})
    --too much keybind conflict with surround...
    --vim.keymap.set({ 'n', 'x', 'o' }, 'gs', '<Plug>(leap-from-window)',{desc = 'leap window to  ...'})
  end,
}
