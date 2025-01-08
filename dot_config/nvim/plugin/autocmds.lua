function R(name)
  require('plenary.reload').reload_module(name)
end

-- Highlight yanked text
local yank_group = vim.api.nvim_create_augroup('HighlightYank', {})
vim.api.nvim_create_autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 100,
    })
  end,
})

-- Search for word under cursor
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = yank_group,
  pattern = '*',
  command = [[%s/\s\+$//e]],
})

-- Use 'q' to close special buffer types. '' catches a lot of transient plugin windows.
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  callback = function(args)
    local bufnr = args.buf
    local filetype = vim.bo[bufnr].filetype
    local types = { 'help', 'fugitive', 'checkhealth', 'vim', '' }
    for _, b in ipairs(types) do
      if filetype == b then
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<C-]>', { desc = 'Follow link' })
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'q', '', {
          callback = function()
            vim.api.nvim_command('close')
          end,
        })
      end
    end
  end,
})

-- Don't auto-wrap comments and don't insert comment leader after hitting 'o'
-- If don't do this on `FileType`, this keeps reappearing due to being set in
-- filetype plugins.
local formatGroup = vim.api.nvim_create_augroup('Formatting', {})
vim.api.nvim_create_autocmd('FileType', {
  group = formatGroup,
  callback = function()
    vim.cmd('setlocal formatoptions-=c formatoptions-=o')
  end,
  desc = [[Ensure proper 'formatoptions']],
})

-- Lint on save
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  group = formatGroup,
  callback = function()
    require('lint').try_lint()
  end,
})

-- Format on range with LSP
vim.api.nvim_create_autocmd('LspAttach', {
  group = formatGroup,
  callback = function(args)
    vim.api.nvim_create_user_command('FormatRange', function(opts)
      local range = nil
      if opts.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, opts.line2 - 1, opts.line2, true)[1]
        range = {
          start = { opts.line1, 0 },
          ['end'] = { opts.line2, end_line:len() },
        }
      end
      require('conform').format({ async = true, lsp_format = 'fallback', range = range })
    end, { range = true })

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end
  end
})

-- Format on save using LSP for certain filetypes
vim.api.nvim_create_autocmd('LspAttach', {
  group = formatGroup,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    local fileTypes = { 'lua', 'go' }

    for _, f in ipairs(fileTypes) do
      if vim.bo.filetype == f and not vim.g.disable_autoformat then
        -- Format the current buffer on save
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = args.buf,
          callback = function()
            vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
          end,
        })
      end
    end
  end,
})


-- Open trouble when quickfix is opened
-- add cmd :ccl to also auto-close the qf buf. Not sure if I want to yet...
vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  callback = function()
    vim.cmd([[Trouble qflist open]])
    vim.cmd([[ccl]])
  end,
})

local function update_global_mark()
  -- Get all marks
  local marks = vim.fn.getmarklist()
  local current_buf_name = vim.fn.expand('%:p')
  -- Look for global marks (A-Z) in current buffer
  for _, mark_info in ipairs(marks) do
    -- Normalize mark path
    local mark_file = vim.fn.fnamemodify(mark_info.file, ':p')
    -- Extract just the letter from the mark
    local mark_char = mark_info.mark:sub(2)
    -- Check if mark is global (A-Z) and in current buffer
    if mark_file == current_buf_name and
        mark_char:match("%u$") then
      -- Update the mark to current cursor position
      local cursor_pos = vim.api.nvim_win_get_cursor(0)
      vim.api.nvim_buf_set_mark(0, mark_char, cursor_pos[1], cursor_pos[2], {})
      return -- Exit after updating the first matching mark
    end
  end
end

-- Update global mark when leaving buffer
vim.api.nvim_create_autocmd('BufLeave', {
  pattern = '*',
  callback = update_global_mark,
})

-- Set nowrap if window is left than textwidth
vim.api.nvim_create_autocmd('WinResized', {
  pattern = '*',
  callback = function()
    local win_width = vim.api.nvim_win_get_width(0)
    local text_width = vim.opt.textwidth._value
    local wide_enough = win_width < text_width + 1
    vim.api.nvim_set_option_value('wrap', wide_enough, {})
  end,
})
