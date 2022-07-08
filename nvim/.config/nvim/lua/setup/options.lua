local set = vim.opt

set.compatible = false -- don't override w/ vi settings

set.completeopt = {'menu', 'menuone', 'noselect'}
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.expandtab = true -- converts tabs to spaces
set.autoindent = true -- indent based on prev line
set.smartindent = true -- indent considers code syntax
set.nu = true -- line numbers
set.incsearch = true -- search as you type
set.clipboard = 'unnamedplus' -- use same clipboard as computer
set.scrolloff = 8 -- stop scroll before end buffer
set.splitright = true -- open splits to right & below
set.splitbelow = true
set.wrap = false -- don't wrap text
set.signcolumn = 'yes' -- default left column for git signs
set.belloff = 'all' -- stop the beeping sounds 
set.updatetime = 100 -- gitgutter optimization
set.modifiable = true
set.hidden = true
set.listchars = 'trail:*' -- show me the trailing whitespace
set.list = true
