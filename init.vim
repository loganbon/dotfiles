set nocompatible

" Formatting
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set backspace=indent,eol,start
set nu
set relativenumber
set nowrap
set noerrorbells
set belloff=all
" set nohlsearch
set incsearch
set scrolloff=8
set signcolumn=yes
set hidden
set wildmenu
set modifiable
set splitbelow splitright

" delay by which autocommands are ran
set updatetime=100

filetype plugin indent on
syntax on

call plug#begin("~/.config/nvim/plugged")
    " git 
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'vim-airline/vim-airline'
    
    " search
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}

    " completion
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " explore
    Plug 'preservim/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

    " appearance
    Plug 'sainnhe/everforest'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'kana/vim-submode'
    Plug 'tpope/vim-commentary'
call plug#end()

" Colorscheme
colorscheme everforest 

let mapleader = " "
inoremap kj <esc>
nnoremap <leader>b :buffers<cr>:b<space>
nnoremap <leader>s :execute '20split \| term'<cr><insert>
tnoremap kj <C-\><C-n>

" Vim File Management
map <leader>vm :vsp $MYVIMRC<CR>
map <leader><enter> :source $MYVIMRC<CR>

" Autocomplete Remaps
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Text Manipulation
vnoremap K :m '<-2<cr>gv=gv
vnoremap J :m '>+1<cr>gv=gv
" nnoremap <leader>k :m .-2<cr>==
" nnoremap <leader>j :m .+1<cr>==

" Git Remaps
nmap <leader>gs :G<cr>
nmap <leader>gj :diffget //3<cr>
nmap <leader>gf :diffget //2<cr>

" Window Movement
nnoremap <leader>w <C-w>w
nnoremap <leader>vr <C-W>v<C-W>l<C-W>L
call submode#enter_with('grow/shrink', 'n', '', '<leader><right>', ':vertical resize -3<CR>')
call submode#enter_with('grow/shrink', 'n', '', '<leader><left>', ':vertical resize +3<CR>')
call submode#map('grow/shrink', 'n', '', '<right>', ':vertical resize -3<CR>')
call submode#map('grow/shrink', 'n', '', '<left>', ':vertical resize +3<CR>')

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Nerd Tree
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <C-t> :NERDTree<CR>

" Reloads icons in nerdtree
if exists("g:loaded_webdevicons")
    call webdevicons#refresh()
endif

" Treesitter
lua <<EOF
require 'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        disable = {},
    },
    ensure_installed = {
        "python",
        "yaml",
        "json",
        "javascript", 
        "go",
        "vim"
    }
}
EOF

" Telescope Remaps
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>gb <cmd>lua require('telescope.builtin').git_branches()<cr>

lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
      file_ignore_patterns = {"__pycache__"},
      mappings = {
        i = {
            ["<leader>q"] = actions.close,
        },
        n = {
            ["<leader>q"] = actions.close,
        }
      }
  }
}
EOF
