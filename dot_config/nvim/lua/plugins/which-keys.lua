return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    delay = 200,
    preset = 'helix',
    -- expand = -1,
    sort = { 'alphanum', 'group', 'local', 'order', 'mod' },
    plugins = {
      presets = {
        operators = true,     -- adds help for operators like d, y, ...
        motions = false,      -- adds help for motions
        text_objects = false, -- help for text objects triggered after entering an operator
        windows = true,       -- default bindings on <c-w>
        nav = true,           -- misc bindings to work with windows
        z = true,             -- bindings for folds, spelling and others prefixed with z
        g = true,             -- bindings for prefixed with g,
      },
    },
  },
}
