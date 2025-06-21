local opt = vim.opt

-- Encoding settings
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'
vim.o.fileencodings = 'utf-8,iso-2022-jp,euc-jp,sjis'

-- Locale settings
vim.o.langmenu = 'ja_JP.UTF-8'
vim.o.helplang = 'ja'

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Input settings
opt.mouse = ''
opt.clipboard = 'unnamedplus'

-- Indentation and tabs
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- UI settings
opt.wrap = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.termguicolors = true
opt.showmode = false

-- File handling
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- Undo settings
opt.undofile = true
local undodir = vim.fn.stdpath('data') .. '/undodir'
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, 'p')
end
opt.undodir = undodir
