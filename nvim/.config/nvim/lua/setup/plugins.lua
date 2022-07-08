local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  })
  print('Installing packer close and reopen Neovim...')
  vim.cmd([[packadd packer.nvim]])
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

function get_setup(name)
  return string.format('require("setup/%s")', name)
end

local packer = require('packer')

packer.init({
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'rounded' })
    end,
  },
})

packer.startup(function(use)
  use { 'wbthomason/packer.nvim' }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    tag = 'nightly',
    config = get_setup('nvim-tree'),
  }

  use { 'nvim-lualine/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons',
      opt = true
    },
    config = get_setup('lualine'),
  }

  use { 'airblade/vim-gitgutter' }
  use { 'tpope/vim-fugitive' }

  use { 'tpope/vim-commentary' }

  use { 'mg979/vim-visual-multi' }

  use { 'sainnhe/everforest',
    config = get_setup('colorscheme'),
  }

  use { 'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
    },
    config = get_setup('telescope'),
  }
  use { 'nvim-telescope/telescope-file-browser.nvim' }

  use { "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = get_setup('treesitter'),
  }

  use { 'hrsh7th/nvim-cmp',
    requires = {
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/nvim-cmp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind.nvim',
    },
    config = get_setup('cmp'),
  }

  use { 'rmagatti/goto-preview',
    config = get_setup('goto-preview'),
  }

  if packer_bootstrap then
    packer.sync()
  end
end)
