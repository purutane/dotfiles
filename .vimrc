"dein Scripts-----------------------------
if &compatible
    set nocompatible
endif

" directories
let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" check if not exists clone
if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath+=' . s:dein_repo_dir
endif

" Required:
call dein#begin(s:dein_dir)

" Let dein manage dein
" Required:
call dein#add(s:dein_repo_dir)

" Plugins
call dein#add('w0ng/vim-hybrid')

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
    call dein#install()
endif

"End dein Scripts-------------------------

set autoindent
set smartindent
set smarttab
set expandtab

set tabstop=4
set softtabstop=4
set shiftwidth=4

" colorscheme
set background=dark
colorscheme hybrid

" appearnce
set number
set cursorline
set cursorcolumn

" true color
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

