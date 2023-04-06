local options = {
  breakindent = true,
  clipboard = "unnamedplus",
  complete = { ".", "w", "b", "u", "t", "i", "kspell" },
  completeopt = { "menuone", "noinsert", "noselect" },
  cursorline = false,
  expandtab = true,
  fillchars = { fold = " ", eob = " " },
  foldlevel = 0,
  foldmethod = "marker",
  hidden = true,
  ignorecase = true,
  list = false,
  listchars = { eol = "↲", tab = "▸ ", trail = "·" },
  nrformats = { "alpha", "octal", "hex" },
  number = true,
  numberwidth = 3,
  relativenumber = true,
  scrolloff = 8,
  shiftround = true,
  shiftwidth = 4,
  showbreak = "↪",
  showmatch = true,
  showmode = false,
  signcolumn = "yes",
  smartcase = true,
  smartindent = true,
  softtabstop = 4,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  termguicolors = true,
  updatetime = 250,
  wildmode = { "list", "longest" },
  wrap = false,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd([[filetype plugin indent on]])
