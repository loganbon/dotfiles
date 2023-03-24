-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local Util = require("util")

-- NORMAL --
Util.map("n", "<leader>j", "<C-W>h") -- dirty left window movement
Util.map("n", "<leader>l", "<C-W>l")
Util.map("n", "<leader>o", ":on<cr>") -- close other buffers

-- INSERT --
Util.map("i", "kj", "<ESC>")

-- VISUAL --
Util.map("v", ">", ">gv") -- keep visual highlight for indent/dedent
Util.map("v", "<", "<gv")

Util.map("v", "J", ":m '>+1<cr>gv=gv") -- move visual text up/down
Util.map("v", "K", ":m '<-2<cr>gv=gv")
