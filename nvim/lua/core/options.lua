local opt = vim.opt

-- encodings
vim.o.encoding = 'utf-8'
vim.o.fileencoding = 'utf-8'
vim.o.fileencodings = 'utf-8,iso-2022-jp,euc-jp,sjis'
vim.o.langmenu = 'ja_JP.UTF-8'
vim.o.helplang = 'ja'

-- 基本設定
opt.number = true
opt.relativenumber = true
opt.mouse = ''
opt.clipboard = ''

-- インデントとタブ
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- 検索関連
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- UI関連
opt.wrap = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.termguicolors = true
opt.showmode = false

-- ファイル関連
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- アンドゥ関連
opt.undofile = true
-- アンドゥ履歴の保存場所
local undodir = vim.fn.stdpath('data') .. '/undodir'
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, 'p')
end
opt.undodir = undodir

-- clipboard
opt.clipboard = 'unnamedplus'
