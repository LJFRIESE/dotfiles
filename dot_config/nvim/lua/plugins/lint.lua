return
  {
    'mfussenegger/nvim-lint',
    config = function()
      local sqlfluff = require('lint').linters.sqlfluff
      sqlfluff.args = {
        'lint',
        '--format=json',
        '--dialect=oracle',
        '--processes=-1',
      }
    end,
  }
