require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    'python',
    'yaml',
    'json',
    'javascript',
    'typescript',
    'vim',
  }
}
