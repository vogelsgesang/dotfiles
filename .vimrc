set nocompatible
"Vundle plugins
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'sjl/badwolf' "badwolf theme
Plugin 'tomasr/molokai' "molokai theme
Plugin 'Valloric/YouCompleteMe' "autocompletion
Plugin 'dbext.vim' "auto completion etc. for SQL involving database
Plugin 'vim-scripts/SQLComplete.vim' "auto completion based on dbext.vim
Plugin 'wookiehangover/jshint.vim' "js hinting
Plugin 'marijnh/tern_for_vim' "really good JS autocompletion
Plugin 'groenewege/vim-less' "syntax highlighting for less
Plugin 'digitaltoad/vim-jade' "syntax highlighting for jade
Plugin 'mattn/emmet-vim' "shortcuts for HTML editing
Plugin 'wesQ3/vim-windowswap' "window swap
Plugin 'tpope/vim-fugitive' "git integration
"Plugin 'heavenshell/vim-jsdoc' "jsdoc support
Plugin 'scrooloose/nerdtree' "file tree explorer
call vundle#end()

"powerline
if !has('nvim') "neovim does not offer the python interface...
  python from powerline.vim import setup as powerline_setup
  python powerline_setup()
  python del powerline_setup
endif

"enable filetype specific filetypes and indents
filetype plugin indent on
syntax on

"tabs
set softtabstop=2
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set autoindent

"search
set incsearch
set ignorecase

"folding
set foldmethod=syntax
set foldlevelstart=99

let javaScript_fold=1         " JavaScript
let perl_fold=1               " Perl
let php_folding=1             " PHP
let r_syntax_folding=1        " R
let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
let xml_syntax_folding=1      " XML

"syntax highlighting
let html_no_rendering=1

"scrolling
set scrolloff=2
set sidescrolloff=2

"do not write a backup file (does not play nicely with file watches)
set nowritebackup

"always show the status bar
set laststatus=2
set noshowmode

"adjust the <leader> key
let mapleader=","

"select a colorscheme
colorscheme molokai

"adjustments to the dark color scheme
highlight Visual      cterm=UNDERLINE
"highlight clear SpellBad
"highlight SpellBad cterm=underline,bold ctermfg=magenta

"dbext connection parameters
let g:dbext_default_PGSQL_cmd_terminator = ";"
let g:dbext_default_profile_pgsql_wahlen = "type=PGSQL:user=adrian:dbname=wahldaten"

"emett configuration
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
