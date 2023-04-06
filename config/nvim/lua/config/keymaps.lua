local Util = require("util")

-- NORMAL --
Util.map("n", "<leader>j", "<C-W>h", { desc = "Window Left" })
Util.map("n", "<leader>l", "<C-W>l", { desc = "Window Right" })
Util.map("n", "<leader>o", ":on<cr>", { desc = "Focus Window" })
Util.map("n", "<leader>L", ":Lazy<cr>", { desc = "Lazy" })

-- INSERT --
Util.map("i", "kj", "<ESC>")

-- VISUAL --
Util.map("v", ">", ">gv") -- keep visual highlight for indent/dedent
Util.map("v", "<", "<gv")

Util.map("v", "J", ":m '>+1<cr>gv=gv") -- move visual text up/down
Util.map("v", "K", ":m '<-2<cr>gv=gv")
