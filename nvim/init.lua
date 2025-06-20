-- leader
vim.g.mapleader = ' '

-- core
require('core.options')

-- filetypes
require('core.filetypes').setup()

-- ime
require('core.ime')

-- lazy
require('core.lazy')
