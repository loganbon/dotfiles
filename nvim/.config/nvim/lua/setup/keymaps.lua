local map = function(mode, key, result, opts)
  opts = opts or { noremap = true, silent = true }
  vim.api.nvim_set_keymap(
    mode,
    key,
    result,
    opts
  )
end

vim.g.mapleader = ' '

-- NORMAL --
map('n', '<leader>o', ':on<CR>') -- close other buffers
map('n', '<leader>vm', ':vsp $MYVIMRC<CR>') -- open config
map('n', '<leader>d', ':NvimTreeToggle<CR>')
map('n', '<leader>cd', ':NvimTreeFindFile<CR>')
map('n', '<leader>j', '<C-W>h') -- dirty left window movement
map('n', '<leader>l', '<C-W>l')

-- git
map('n', '<leader>gs', ':G<CR>')

-- telescope
map('n', '<leader>ff', ":lua require('telescope.builtin').find_files()<CR>")
map('n', '<leader>b', ":lua require('telescope.builtin').buffers()<CR>")
map('n', '<leader>fg', ":lua require('telescope.builtin').live_grep()<CR>")
map('n', '<leader>gb', ":lua require('telescope.builtin').git_branches()<CR>")

-- preview
map('n', 'gd', ":lua require('goto-preview').goto_preview_definition()<CR>", { noremap=true }) -- get definition in preview
map('n', '<leader>q', ":lua require('goto-preview').close_all_win()<CR> || :NvimTreeClose<CR>", { noremap=true }) -- close all windows
map('n', 'gr', ":lua require('goto-preview').goto_preview_references()<CR>", { noremap=true }) -- get references (uses telescope)

-- INSERT --
map('i', 'kj', '<ESC>')

-- VISUAL --
map('v', '>', '>gv') -- keep visual highlight for indent/dedent
map('v', '<', '<gv')

map('v', 'J', ":m '>+1<cr>gv=gv") -- move visual text up/down
map('v', 'K', ":m '<-2<cr>gv=gv")
