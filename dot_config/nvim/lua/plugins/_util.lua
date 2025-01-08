return {
  { 'nvim-lua/plenary.nvim' },
  { 'tpope/vim-sleuth',     event = 'VeryLazy' }, -- Detect tabstop and shiftwidth automatically
  {
    'brenoprata10/nvim-highlight-colors',
    event = 'VeryLazy',
  },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      highlight = {
        comments_only = false,
      },
    },
    init = function()
      require('todo-comments').setup()
    end,
  },
}
