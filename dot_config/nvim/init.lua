-- Global variables.
vim.g.projects_dir = vim.env.HOME .. '/projects'
vim.g.mapleader = ' '


--Install lazy
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
---@diagnostic disable-next-line
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  ui = {
    border = 'rounded',
    title = 'Lazy',
  },
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  change_detection = { notify = false },
  performance = {
    cache = {
      enabled = true,
    },
  },
})

vim.cmd.colorscheme('rose-akai')
