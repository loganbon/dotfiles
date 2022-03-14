set nocompatible

" Formatting
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set backspace=indent,eol,start
set list
set listchars=trail:*
set nu
set relativenumber
set nowrap
set noerrorbells
set belloff=all
set clipboard=unnamedplus
set incsearch
set scrolloff=8
set signcolumn=yes
set hidden
set wildmenu
set modifiable
set splitbelow splitright
set ignorecase
set updatetime=100

filetype plugin indent on
syntax on

call plug#begin("~/.config/nvim/plugged")
    " git
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'

    " navigation
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'lambdalisue/fern.vim'

    " functional
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'kana/vim-submode'

    " completion
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'jiangmiao/auto-pairs'

    " appearance
    Plug 'sainnhe/everforest'
    Plug 'vim-airline/vim-airline'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " performance
    Plug 'antoinemadec/FixCursorHold.nvim'

call plug#end()


"__ General __
colorscheme everforest

let mapleader = " "
inoremap kj <esc>

"__ Config File Management __
map <leader>vm :vsp $MYVIMRC<CR>
map <leader><enter> :source $MYVIMRC<CR>

let g:cursorhold_updatetime = 100

"__ Completion __
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

"__ Text Movement __
vnoremap K :m '<-2<cr>gv=gv
vnoremap J :m '>+1<cr>gv=gv

vnoremap < <gv
vnoremap > >gv

"__ Git __
nmap <leader>gs :G<cr>
nmap <leader>gj :diffget //3<cr>
nmap <leader>gf :diffget //2<cr>

"__ Navigation __
nnoremap <leader>w <C-w>w
nnoremap <leader>vr <C-W>v<C-W>l<C-W>
nnoremap <leader>o :on<cr>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

call submode#enter_with('grow/shrink', 'n', '', '<leader><right>', ':vertical resize +3<CR>')
call submode#map('grow/shrink', 'n', '', '<right>', ':vertical resize +3<CR>')
call submode#enter_with('grow/shrink', 'n', '', '<leader><left>', ':vertical resize -3<CR>')
call submode#map('grow/shrink', 'n', '', '<left>', ':vertical resize -3<CR>')

"__ Treesitter __
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
        "typescript",
        "go",
        "vim"
    }
}
EOF

"__ Telescope __
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
" nnoremap <leader>fg <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
" nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>gb <cmd>lua require('telescope.builtin').git_branches()<cr>

lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
      file_ignore_patterns = {"__pycache__"},
      mappings = {
        i = { ["<leader>q"] = actions.close, },
        n = { ["<leader>q"] = actions.close, }
      }
  }
}
EOF

"__ FERN __

" Disable netrw.
let g:loaded_netrw= 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

augroup my-fern-hijack
  autocmd!
  autocmd BufEnter * ++nested call s:hijack_directory()
augroup END

function! s:hijack_directory() abort
  let path = expand('%:p')
  if !isdirectory(path)
    return
  endif
  bwipeout %
  execute printf('Fern %s', fnameescape(path))
endfunction

" Custom settings and mappings.
let g:fern#disable_default_mappings = 1
noremap <silent> <Leader>d :Fern . -drawer -reveal=% -toggle -width=35<CR><C-w>=

function! FernInit() abort
  nmap <buffer><expr>
        \ <Plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )
  nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> n <Plug>(fern-action-new-path)
  nmap <buffer> D <Plug>(fern-action-remove)
  nmap <buffer> m <Plug>(fern-action-move)
  nmap <buffer> p <Plug>(fern-action-mark-toggle)
  nmap <buffer> M <Plug>(fern-action-rename)
  nmap <buffer> s <Plug>(fern-action-hidden-toggle)
  nmap <buffer> r <Plug>(fern-action-reload)
  nmap <buffer> b <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer><nowait> < <Plug>(fern-action-leave)
  nmap <buffer><nowait> > <Plug>(fern-action-enter)
endfunction

augroup FernGroup
  autocmd!
  autocmd FileType fern call FernInit()
augroup END
