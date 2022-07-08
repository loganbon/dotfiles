local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    file_ignore_patterns = {'__pycache__'},
    mappings = {
      i = { ['<leader>q'] = actions.close, },
      n = { ['<leader>q'] = actions.close, },
    },
  },
}
