return {
  -- Conflicting with treesitter in some way.
  -- Seems to be otter, and maybe context?
  enable = true,
  events = 'VeryLazy',

    'quarto-dev/quarto-nvim',
    ft = { 'quarto' },
    dev = false,
    opts = {},
    dependencies = {
      'jmbuhr/otter.nvim',
    },
  config = function()
    local function get_quarto_resource_path()
      local function strsplit(s, delimiter)
        local result = {}
        for match in (s .. delimiter):gmatch('(.-)' .. delimiter) do
          table.insert(result, match)
        end
        return result
      end

      local f = assert(io.popen('quarto --paths', 'r'))
      local s = assert(f:read('*a'))
      f:close()
      return strsplit(s, '\n')[2]
    end

    local lua_library_files = vim.api.nvim_get_runtime_file('', true)
    local lua_plugin_paths = {}
    local resource_path = get_quarto_resource_path()
    if resource_path == nil then
      vim.notify_once('quarto not found, lua library files not loaded')
    else
      table.insert(lua_library_files, resource_path .. '/lua-types')
      table.insert(lua_plugin_paths, resource_path .. '/lua-plugin/plugin.lua')
    end
  end,
}
