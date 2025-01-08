-- Manipulate text
vim.keymap.set('n', '<c-p><c-p>', 'O<c-r>"<esc>', { desc = '[P]aste above' })
vim.keymap.set('n', '<c-p>', 'o<c-r>"<esc>', { desc = '[P]aste below' })

vim.keymap.set('n', '<leader>ok', 'mzO<esc>`z', { desc = 'Above' })
vim.keymap.set('n', '<leader>oj', 'mzo<esc>`z', { desc = 'Below' })

vim.keymap.set('n', 'J', 'mzJ`z', { desc = '[J]oin subsequent line' })
vim.keymap.set('n', '<leader>rg', [[:%s=\\>=<C-r><C-w>=gI<Left><Left><Left>]], { desc = '[g]lobal :s' })
vim.keymap.set('n', '<leader>rl', [[:s=\<<C-r><C-w>\>=<C-r><C-w>=gI<Left><Left><Left>]], { desc = '[l]ine :s' })

vim.keymap.set({ 'n', 'v', 'x' }, 'x', '"_d', { desc = 'Black hole' })
vim.keymap.set({ 'n', 'v', 'x' }, 'X', '"_D', { desc = 'Black hole' })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move text down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move text up' })
vim.keymap.set('v', '<', '<gv', { desc = 'Dedent while remaining in visual mode' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent while remaining in visual mode' })

-- Diagnostic keymaps
-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
local dap = require('dap')
local dapui = require('dapui')
vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })
vim.keymap.set('n', '<leader>de', ":lua require('dapui').eval()", { desc = 'Debug: Hover evaluate' })
vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
vim.keymap.set('n', '<leader>dt', function()
  local render = require('dapui.config').render
  render.max_type_length = (render.max_type_length == nil) and 0 or nil
  require('dapui').update_render(render)
end, { desc = 'Toggle types' })

vim.keymap.set('', '<leader>bl', function()
  require('lsp_lines').toggle()
  vim.diagnostic.config({
    virtual_text = not vim.diagnostic.config().virtual_text,
  })
end, { desc = 'Toggle diagnostic [l]ines' })

vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump({ count = 1 })
end, { desc = '[D]iagnostic' })
vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump({ count = -1 })
end, { desc = '[D]iagnostic' })

vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = '[d]iagnostics' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = '[q]uickfix list' })
vim.keymap.set('n', 'gcd', 'O---@diagnostic disable-next-line<esc>j', { desc = '[d]iagnostic disable' })
vim.keymap.set('n', 'gcl', 'A--no lint<esc>', { desc = '[l]int disable' })

vim.keymap.set('n', 'gw', '<cmd>Format<CR>', { desc = 'Format' })

-- Window navigation
vim.keymap.set('n', '|', '<c-w>v', { desc = 'Virtical split' })

-- vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to below window' })
-- vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to above window' })
vim.keymap.set('n', '<c-w>-', function()
  local height = vim.api.nvim_win_get_height(0)
  local width = vim.api.nvim_win_get_width(0)
  vim.api.nvim_win_set_height(0, math.floor(height * 0.75))
  vim.api.nvim_win_set_width(0, math.floor(width * 0.75))
end)
vim.keymap.set('n', '<c-w>+', function()
  local height = vim.api.nvim_win_get_height(0)
  local width = vim.api.nvim_win_get_width(0)
  vim.api.nvim_win_set_height(0, math.floor(width * 1.25))
  vim.api.nvim_win_set_width(0, math.floor(height * 1.25))
end)

vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next result' })     --Jump centered
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous result' }) --Jump centered

vim.keymap.set('n', '<c-d>', 'zz<c-d>', { desc = 'Jump down and center' })
vim.keymap.set('n', '<c-u>', 'zz<c-u>', { desc = 'Jump up and center' })
vim.keymap.set('n', '<leader>bd', ':%bdelete|edit #|normal`"', { desc = 'Delete all other buffers' })

-- Misc
vim.keymap.set('n', '<leader>O', '<cmd>Oil<CR>', { desc = 'Oil' })
vim.keymap.set('n', '<esc>', '<cmd>nohlsearch<CR>', { desc = 'Kill search highlight' })
vim.keymap.set('n', '<leader>t', '<cmd>ToggleTerminal<CR>', { desc = '[T]erminal' })
vim.keymap.set('n', '<leader>x', ':.lua<CR>', { desc = 'E[x]ecute line' })
vim.keymap.set('n', '<leader>i', ':Inspect<CR>')

vim.keymap.set('n', '<leader>C', function()
  require('nvim-highlight-colors').toggle()
end, { desc = 'Toggle [c]olours' })

vim.keymap.set('i', '<C-c>', '<Esc>', { desc = 'Esc' })
vim.keymap.set('i', '<C-l>', '<esc>A', { desc = 'Jump to end' })
vim.keymap.set('i', '<C-h>', '<esc>I', { desc = 'Jump to start' })

vim.keymap.set('v', '<leader>x', ':lua<CR>', { desc = 'E[x]ecute line' })

vim.keymap.set('t', '<c-c><c-c>', '<c-\\><c-n>', { desc = 'Enter normal mode' })
-- Function to check for a tag and either jump to it or search in help
---@diagnostic disable-next-line
function help_lookup()
  local expr = vim.fn.expand('<cexpr>')
  ---@diagnostic disable-next-line
  local expr_ok = pcall(vim.cmd, 'help ' .. expr)
  if expr_ok then
    print('Help: ' .. expr)
    return
  end

  local word = vim.fn.expand('<cword>')
  ---@diagnostic disable-next-line
  local word_ok = pcall(vim.cmd, 'help ' .. word)
  if word_ok then
    print('Help: ' .. expr)
    return
  end
  vim.lsp.buf.hover()
  print('No entry: ' .. expr)
end

vim.api.nvim_set_keymap('n', '<C-k>', ':lua help_lookup()<CR>', { noremap = true, silent = true })

-- Make U opposite to u.
vim.keymap.set('n', 'U', '<C-r>', { desc = 'Redo' }) -- Make U opposite to u.
vim.keymap.set('n', '<leader>U', vim.cmd.UndotreeToggle, { desc = 'Toggle UndoTree' })

vim.keymap.set('n', '<leader>Z', function()
  require('zen-mode').toggle()
  vim.wo.wrap = false
  vim.wo.number = true
  vim.wo.rnu = true
end, { desc = '[Z]en mode' })

-- Telescope functions
local telescope = require('telescope.builtin')
local utils = require('telescope.utils')
local themes = require('telescope.themes')

-- Search (grep) functions
vim.keymap.set('n', '<leader>sh', telescope.help_tags, { desc = '[H]elp' })
vim.keymap.set('n', '<leader>sk', telescope.keymaps, { desc = '[K]eymaps' })
vim.keymap.set('n', '<leader>sT', telescope.builtin, { desc = '[T]elescopes' })
vim.keymap.set('n', '<leader>sc', telescope.grep_string, { desc = 'Word under [c]ursor' })
vim.keymap.set('n', '<leader>sd', telescope.diagnostics, { desc = '[D]iagnostics' })
vim.keymap.set('n', '<leader>sr', telescope.registers, { desc = '[R]egisters' })
vim.keymap.set('n', '<leader>sa', telescope.resume, { desc = '[A]gain' })
-- vim.keymap.set('n', '<leader>spp', function() builtin.planets({show_pluto = true, show_moon = true}) end, { desc = '' })

-- Grep current buffer
vim.keymap.set('n', '<leader>/', function()
  telescope.current_buffer_fuzzy_find(themes.get_ivy({
    prompt_title = 'Search Current Buffer',
    previewer = false,
  }))
end, { desc = '[/] Current buffer' })

-- Grep in all currently active buffers
vim.keymap.set('n', '<leader>sb', function()
  telescope.live_grep(themes.get_dropdown({
    prompt_title = 'Search Active Buffers',
    grep_open_files = true,
  }))
end, { desc = 'Active [b]uffers' })

-- Grep in all files in same dir as current buf
vim.keymap.set('n', '<leader>sl', function()
  telescope.live_grep(themes.get_ivy({
    prompt_title = 'Search in Local Directory  (Relative to active buffer)',
    cwd = utils.buffer_dir(),
  }))
end, { desc = '[L]ocal diectory' })

-- Grep in current working dir
vim.keymap.set('n', '<leader>sw', function()
  telescope.live_grep(themes.get_ivy({
    prompt_title = 'Search in Current Workspace',
  }))
end, { desc = '[W]orkspace' })

-- Grep in work git dir
vim.keymap.set('n', '<leader>s_', function()
  telescope.live_grep(themes.get_ivy({
    -- previewer = false,
    prompt_title = 'Git Projects Directory',
    cwd = '~/git',
  }))
end, { desc = 'Git (Work)' })

-- Buffer/File-finding functions
-- Base find
vim.keymap.set('n', '<leader><leader>', function()
  telescope.buffers(themes.get_ivy({
    prompt_title = 'Find Active Buffers',
    path_display = { 'tail' },
  }))
end, { desc = '[ ] Find active buffers' })

vim.keymap.set('n', '<leader>f.', function()
  telescope.oldfiles(themes.get_dropdown({
    prompt_title = 'Find Recent Files',
    -- previewer = false,
    path_display = { 'tail' },
  }))
end, { desc = '[.] Recent files' })

-- Find files in workspace
vim.keymap.set('n', '<leader>fw', function()
  telescope.find_files(themes.get_ivy({
    -- previewer = false,
    prompt_title = 'Current Working Directory',
  }))
end, { desc = '[W]orking directory' })

-- Find files in nvim dir
vim.keymap.set('n', '<leader>fn', function()
  telescope.find_files(themes.get_dropdown({
    -- previewer = false,
    prompt_title = 'Neovim Directory',
    cwd = vim.fn.stdpath('config'),
  }))
end, { desc = '[N]eovim' })

vim.keymap.set('n', '<leader>fp', function()
  require('mini.sessions').select()
end, { desc = '[P]roject sessions' })

-- Folder browser
-- vim.keymap.set('n', '<leader>ff', function()
vim.keymap.set('n', '<leader>ff', function()
  require('telescope').extensions.file_browser.file_browser(themes.get_ivy({
    display_stat = { date = true, size = true, mode = true },
    hidden = true,
  }))
end, { desc = '[F]older browser' })

-- open file_browser with the path of the current buffer
vim.keymap.set('n', '<leader>fb', function()
  require('telescope').extensions.file_browser.file_browser(themes.get_ivy({
    select_buffer = true,
    path = '%:p:h',
    display_stat = { date = true, size = true, mode = true },
    hidden = true,
  }))
end, { desc = '[B]uffer local' })

-- Find files in work git dir
vim.keymap.set('n', '<leader>f_', function()
  telescope.find_files(themes.get_dropdown({
    previewer = false,
    prompt_title = 'Git Projects Directory',
    cwd = '~/git',
  }))
end, { desc = 'Git (Work)' })

-- Hover and signature information is decided by LSP creator. Sometimes one is more useful than the other.

vim.keymap.set('n', '<leader>I', function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = 'Toggle Inlay Hints' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })

-- Fuzzy find all the symbols in your current document.
vim.keymap.set('n', '<leader>sS', telescope.lsp_document_symbols, { desc = '[s]ymbols (Buffer)' })
vim.keymap.set('n', '<leader>ss', function()
  telescope.lsp_dynamic_workspace_symbols(themes.get_ivy({ prompt_title = 'Workplace Symbols (filter: <c-l>)' }))
end, { desc = '[S]ymbols (Workspace)' })

vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { desc = '[R]e[n]ame' })
vim.keymap.set({ 'n', 'v' }, 'gra', vim.lsp.buf.code_action, { desc = '[R]un [a]ction' })
vim.keymap.set('n', 'grd', telescope.lsp_definitions, { desc = '[D]efinition' })
vim.keymap.set('n', 'grr', telescope.lsp_references, { desc = '[R]eferences' })
vim.keymap.set('n', 'gri', telescope.lsp_type_definitions, { desc = '[I]mplementations' })
vim.keymap.set('n', 'grt', telescope.lsp_type_definitions, { desc = '[T]ype' })

-- vim.keymap.set('n', '<esc><esc>', '<cmd>ccl<CR>', { desc = 'Close quick fix window' })

-- Which-key groupings
local wk = require('which-key')

wk.add({
  { 'g', group = '[G]o ...' }, -- , icon = "󰈆 "},
  { 'gr', group = 'G[r]ab' },  -- , icon = "󰈆 "},
  { 'gs', group = '[S]urrounding ...', icon = '' },
  { 'gc', group = '[C]omment' },
  { '<leader>d', group = '[D]ebug ...', icon = '' },
  { '<leader>c', group = '[C]ompile ...', icon = '' },
  { '<leader>gt', group = '[T]oggle ...', icon = '' },
  { '<leader>s', group = '[S]earch ...', icon = '' },
  { '<leader>f', group = '[F]ind ...', icon = '' },
  { '<leader>g', group = '[G]it' },
  { '<leader>b', group = '[B]uffer' },
  { '<leader>r', group = '[R]egex replace' },
  { '<leader>o', group = 'Insert linebreak ...' },
  -- { '<leader>p', desc = 'Oil', },
  { 'z', group = 'Fold code' },
  { ']', group = 'Next ...' },
  { '[', group = 'Previous ...' },
})
