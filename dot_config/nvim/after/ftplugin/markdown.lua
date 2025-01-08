-- Using `vim.cmd` instead of `vim.wo` because it is yet more reliable
vim.cmd('setlocal spell')
vim.cmd('setlocal wrap')
-- require('todo-comments').setup({opts = {highlight = {comments_only = false}}})

-- -- Enable break indent
-- vim.opt.wrap = true
-- vim.opt.linebreak = true

--         -- interesting idea to explore for formatting documentation
-- vim.lsp.util.stylize_markdown = function(bufnr, contents, opts)
--     contents = vim.lsp.util._normalize_markdown(contents, {
--         width = vim.lsp.util._make_floating_popup_size(contents, opts),
--     })
--     vim.bo[bufnr].filetype = 'markdown'
--     vim.treesitter.start(bufnr)
--     vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)
    --
    -- return contents
--- end
