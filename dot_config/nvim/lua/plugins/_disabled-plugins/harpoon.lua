return {
  'ThePrimeagen/harpoon',
  event = 'VeryLazy',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require('harpoon')
    local wk = require('which-key')
    -- local conf = require('telescope.config'},.values
    -- local function toggle_telescope(harpoon_files)
    --   local file_paths = {}
    --   for _, item in ipairs(harpoon_files.items) do
    --     table.insert(file_paths, item.value)
    --   end
    --
    --   require('telescope.pickers'},
    --     .new({}, {
    --       prompt_title = 'Harpoon',
    --       finder = require('telescope.finders'},.new_table({
    --         results = file_paths,
    --       }),
    --       previewer = conf.file_previewer({}),
    --       sorter = conf.generic_sorter({}),
    --     })
    --     :find()
    -- end
    harpoon:setup()
    wk.add({
      group = 'Harpoon',
      {
        { '<leader>e', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = 'Open harpoon window' },
        { '<leader>a', function() harpoon:list():add() end, desc = 'Add to harpoon' },
        { '<C-m>', function() harpoon:list():select(1) end, desc = 'Select harpoon 1' },
        { '<C-n>', function() harpoon:list():select(2) end, desc = 'Select harpoon 2' },
        { '<C-e>', function() harpoon:list():select(3) end, desc = 'Select harpoon 3' },
        { '<C-i>', function() harpoon:list():select(4) end, desc = 'Select harpoon 4' },
        -- { '<leader>hH', function() harpoon:list():replace_at(1) end, desc = 'Replace harpoon 1' },
        -- { '<leader>hJ', function() harpoon:list():replace_at(2) end, desc = 'Replace harpoon 2' },
        -- { '<leader>hK', function() harpoon:list():replace_at(3) end, desc = 'Replace harpoon 3' },
        -- { '<leader>hL', function() harpoon:list():replace_at(4) end, desc = 'Replace harpoon 4' },
        -- { '<leader>H', function() harpoon:list():prev() end, desc = 'Open prev Harpoon window' },
        -- { '<leader>L', function() harpoon:list():next() end, desc = 'Open next Harpoon window' },
      },
    })
  end,
}
