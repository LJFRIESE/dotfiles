return {
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost' },
    main = 'ibl',
    opts = { scope = { include = {
      node_type = { ['*'] = { '*' } },
    } } },
  },
}
