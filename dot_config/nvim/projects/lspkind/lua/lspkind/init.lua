
local M = {}
local fmt = string.format

local kind_presets = {
  default = {
    -- if you change or add symbol here
    -- replace corresponding line in readme
    Snippet = '',
    Method = '󰆧',
    Function = '󰊕',
    Constructor = '',
    Field = '󰜢',
    Variable = '󰀫',
    Class = '󰠱',
    Interface = '',
    Module = '',
    Property = '',
    Unit = '󰑭',
    Value = '󰎠',
    Enum = '',
    Text = '󰉿',
    Keyword = '󰌋',
    Color = '󰏘',
    File = '󰈙',
    Reference = '󰈇',
    Folder = '󰉋',
    EnumMember = '',
    Constant = '󰏿',
    Struct = '󰙅',
    Event = '',
    Operator = '󰆕',
    TypeParameter = '',
  },
}

local kind_order = {
  'Snippet',
  'Method',
  'Function',
  'Constructor',
  'Field',
  'Variable',
  'Class',
  'Interface',
  'Module',
  'Property',
  'Unit',
  'Value',
  'Enum',
  'Text',
  'Keyword',
  'Color',
  'File',
  'Reference',
  'Folder',
  'EnumMember',
  'Constant',
  'Struct',
  'Event',
  'Operator',
  'TypeParameter',
}
local kind_len = 25

local function get_symbol(kind)
  local symbol = M.symbol_map[kind]
  return symbol or ''
end

local modes = {
  ['text'] = function(kind)
    return kind
  end,
  ['text_symbol'] = function(kind)
    local symbol = get_symbol(kind)
    return fmt('%s %s', kind, symbol)
  end,
  ['symbol_text'] = function(kind)
    local symbol = get_symbol(kind)
    return fmt('%s %s', symbol, kind)
  end,
  ['symbol'] = function(kind)
    local symbol = get_symbol(kind)
    return fmt('%s', symbol)
  end,
}

-- default 'symbol'
local function opt_mode(opts)
  local mode = 'symbol'
  if opts ~= nil and opts['mode'] ~= nil then
    mode = opts['mode']
  end
  return mode
end

-- default 'default'
local function opt_preset(opts)
  local preset
  if opts == nil or opts['preset'] == nil then
    preset = 'default'
  else
    preset = opts['preset']
  end
  return preset
end

function M.init(opts)
  local preset = opt_preset(opts)

  local symbol_map = kind_presets[preset]
  M.symbol_map = (opts and opts['symbol_map'] and
  vim.tbl_extend('force', symbol_map, opts['symbol_map'])) or symbol_map

  local symbols = {}
  local len = kind_len
  for i = 1, len do
    local name = kind_order[i]
    symbols[i] = M.symbolic(name, opts)
  end

  for k, v in pairs(symbols) do
    require('vim.lsp.protocol').CompletionItemKind[k] = v
  end
end

M.setup = M.init
M.presets = kind_presets
M.symbol_map = kind_presets.default

function M.symbolic(kind, opts)
  local mode = opt_mode(opts)
  local formatter = modes[mode]

  -- if someone enters an invalid mode, default to symbol
  if formatter == nil then
    formatter = modes['symbol']
  end

  return formatter(kind)
end

function M.cmp_format(opts)
  if opts == nil then
    opts = {}
  end
  if opts.preset or opts.symbol_map then
    M.init(opts)
  end

  return function(entry, vim_item)
    if opts.before then
      vim_item = opts.before(entry, vim_item)
    end

    vim_item.kind = M.symbolic(vim_item.kind, opts)

    if opts.menu ~= nil then
      if opts.menu[entry.source.name] == '[LSP]' then
        opts.menu[entry.source.name] = '['..entry.source.source.client.name..']'
      end
      vim_item.menu = (opts.menu[entry.source.name] ~= nil and
      opts.menu[entry.source.name] or '')
      .. ((opts.show_labelDetails and vim_item.menu ~= nil) and vim_item.menu or '')
    end

    if opts.maxwidth ~= nil then
      local maxwidth = type(opts.maxwidth) == 'function' and
      opts.maxwidth() or opts.maxwidth
      if vim.fn.strchars(vim_item.abbr) > maxwidth then
        vim_item.abbr = vim.fn.strcharpart(vim_item.abbr, 0, maxwidth-(vim.fn.strchars(opts.ellipsis_char))+1) ..
        ' ' .. (opts.ellipsis_char ~= nil and opts.ellipsis_char or '')
      end
    end
    return vim_item
  end
end

return M
