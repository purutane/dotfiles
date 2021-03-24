"Start dein Scripts-----------------------------
if &compatible
    set nocompatible
endif

augroup my_auto_cmd
    autocmd!
augroup END

let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let s:toml = s:dein_dir . '/rc/dein.toml'
let s:lazy_toml = s:dein_dir . '/rc/dein_lazy.toml'

if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath+=' . s:dein_repo_dir
endif

call dein#begin(s:dein_dir)

call dein#load_toml(s:toml, {'lazy': 0})
call dein#load_toml(s:lazy_toml, {'lazy': 1})

call dein#end()

filetype plugin indent on
syntax enable

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
set shiftwidth=0

" appearnce
set number
set cursorline
set cursorcolumn

" true color
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

