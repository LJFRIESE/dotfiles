-- fold commands usually change the foldlevel, which fixes folds, e.g.
-- auto-closing them after leaving insert mode, however ufo does not seem to
-- have equivalents for zr and zm because there is no saved fold level.
-- Consequently, the vim-internal fold levels need to be disabled by setting
-- them to 99.
vim.opt.fillchars = {
    horiz = '─',
    horizup = '┴',
    horizdown = '┬',
    vert = '│',
    vertleft = '┤',
    vertright = '├',
    verthoriz = '┼',
    fold = ' ',
    foldopen =
    '⎧',
    foldclose = '',
    foldsep = '│',
}

local fcs = vim.opt.fillchars:get()

local function get_fold(lnum)
    if vim.fn.foldclosedend(lnum - 1) ~= -1 then
        return ''
    end
    -- series of non-folded lines
    if vim.fn.foldlevel(lnum) == 0 and vim.fn.foldlevel(lnum - 1) == 0 then
        return ''
    end
    -- series of lines within same fold
    if vim.fn.foldlevel(lnum) == vim.fn.foldlevel(lnum - 1) and vim.fn.foldlevel(lnum) == vim.fn.foldlevel(lnum - 1) then
        return '⎜'
    end
    -- line whose prior fold is greater, but subsequent is same
    if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) and vim.fn.foldlevel(lnum) == vim.fn.foldlevel(lnum + 1) then
        return '⎝'
    end
    if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then
        return '⎝'
    end
    -- line is a top-level fold
    if vim.fn.foldlevel(lnum) == 1 then
        return '⯈'
    end
    -- line at the end of a top-level fold. Prior line was inside a fold
    if vim.fn.foldlevel(lnum) == 0 then
        return '⎝'
    end
    -- line is start of a non-top level fold
    return vim.fn.foldclosed(lnum) == -1 and fcs.foldopen or fcs.foldclose
end

local function line_func()
    return vim.v.relnum == 0 and vim.v.lnum or vim.v.relnum
end
_G.get_statuscol = function()
    return '%s%{' .. line_func() .. '}%= ' .. get_fold(vim.v.lnum) .. ' '
end


-- General ====================================================================

vim.opt.autoread  = true  -- sync buffers automatically
vim.opt.backup    = false -- Don't store backup
vim.opt.clipboard = 'unnamedplus'
vim.opt.isfname:append('@-@')
vim.opt.mouse       = 'a'            -- Enable mouse
vim.opt.mousescroll = 'ver:25,hor:6' -- Customize mouse scroll
vim.opt.switchbuf   = 'usetab'       -- Use already opened buffers when switching
vim.opt.startofline = true           -- Jump to first column when jumping in buffer
vim.opt.jumpoptions = "stack,view"   -- Treat jumplist like a tag stack and restor view
vim.opt.swapfile    = false          -- disable neovim generating a swapfile and showing the error
vim.opt.timeoutlen  = 300            -- Decrease mapped sequence wait time
vim.opt.undofile    = true           -- Enable persistent undo
-- vim.g.undotree_DiffCommand = 'FC'

vim.diagnostic.config({
    severity_sort = true,
    virtual_text = true,
    virtual_lines = false,
    jump = {
        wrap = true,
        float = true
    },

})


-- UI =========================================================================
vim.g.have_nerd_font   = true
vim.opt.termguicolors  = true

vim.opt.cursorline     = true
vim.opt.cursorlineopt  = 'screenline,number' -- Show cursor line only screen line when wrapped
vim.opt.guicursor      =
'n-sm:block-Cursor,i-t:ver30-iCursor,v:block-vCursor,r-c:block-cCursor,o:block-oCursor'

vim.opt.statuscolumn   = '%!v:lua.get_statuscol()'
vim.opt.colorcolumn    = '+1'
vim.opt.signcolumn     = 'yes'

vim.opt.breakindentopt = 'list:-1' -- Add padding for lists when 'wrap' is on
vim.opt.rnu            = true
vim.opt.number         = true
vim.opt.textwidth      = 88

vim.opt.hlsearch       = true
vim.opt.incsearch      = true
vim.opt.inccommand     = 'split' -- Preview substitutions live

vim.opt.ignorecase     = true    -- Ignore case when searching (use `\C` to force not doing that)
vim.opt.incsearch      = true    -- Show search results while typing

vim.opt.sidescroll     = 20
vim.opt.scrolloff      = 8

vim.opt.splitright     = true
vim.opt.splitbelow     = true

-- Editing ====================================================================
vim.opt.iskeyword:append('-') -- Treat dash separated words as a word text object-
vim.opt.infercase     = true  -- Infer letter cases for a richer built-in keyword completion

-- Define pattern for a start of 'numbered' list. This is responsible for
-- correct formatting of lists when using `gw`. This basically reads as 'at
-- least one special character (digit, -, +, *) possibly followed some
-- punctuation (. or `)`) followed by at least one space is a start of list item'
vim.opt.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]

vim.opt.tabstop       = 4
vim.opt.softtabstop   = 4
vim.opt.shiftwidth    = 4

vim.opt.autoindent    = true
vim.opt.smartindent   = true
vim.opt.expandtab     = true
vim.opt.formatoptions = 'rqnl1j' -- Improve comment editing. Trust me.

-- Spelling ===================================================================
vim.opt.spelllang     = 'en,uk'                                        -- Define spelling dictionaries
vim.opt.spelloptions  = 'camel'                                        -- Treat parts of camelCase words as seprate words
vim.opt.complete:append('kspell')                                      -- Add spellcheck options for autocomplete
vim.opt.complete:remove('t')                                           -- Don't use tags for completion

vim.opt.dictionary = vim.fn.stdpath('config') .. '/spell/en.utf-8.spl' -- Use specific dictionaries


--- Disable health checks for these providers.
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- LSP ===========================================================================

vim.lsp.config('*', {
    root_markers = { '.git' }, -- Set default root marker for all clients
    capabilities = require('blink.cmp').get_lsp_capabilities(),
})

vim.lsp.enable('luals')
vim.lsp.enable('gopls')
vim.lsp.enable('marksman')
