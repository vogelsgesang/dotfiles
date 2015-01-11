set nocompatible

"Vundle plugins
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'sjl/badwolf' "badwolf theme
Plugin 'tomasr/molokai' "molokai theme
if has('python')
  Plugin 'Valloric/YouCompleteMe' "autocompletion
endif
Plugin 'kien/ctrlp.vim' "fuzzy file search
Plugin 'dbext.vim' "auto completion etc. for SQL involving database
Plugin 'vim-scripts/SQLComplete.vim' "auto completion based on dbext.vim
Plugin 'pangloss/vim-javascript' "improved JS syntax and identation support
Plugin 'wookiehangover/jshint.vim' "js hinting
Plugin 'marijnh/tern_for_vim' "really good JS autocompletion
Plugin 'groenewege/vim-less' "syntax highlighting for less
Plugin 'digitaltoad/vim-jade' "syntax highlighting for jade
Plugin 'mattn/emmet-vim' "shortcuts for HTML editing
Plugin 'wesQ3/vim-windowswap' "window swap
Plugin 'tpope/vim-fugitive' "git integration
Plugin 'godlygeek/tabular' "text aligning; http://media.vimcasts.org/videos/29/alignment.ogv
Plugin 'plasticboy/vim-markdown' "markdown support
Plugin 'chaquotay/ftl-vim-syntax' "freemarker support
"Plugin 'heavenshell/vim-jsdoc' "jsdoc support
Plugin 'scrooloose/nerdtree' "file tree explorer
call vundle#end()

"enable filetype specific filetypes and indents
filetype plugin indent on
syntax on

"always use unix encoding
set fileformats=unix

"disable arrow keys (to force me sticking to hjkl)
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

set relativenumber "shows relative line numbers for easy motions
au CmdwinEnter :  set relativenumber!
au CmdwinLeave :  set relativenumber
set splitbelow "put horizontal splits below
set splitright "put vertical splits to the right

"tabs
set softtabstop=2 "number of spaces used with tab/bs
set tabstop=2 "display tabs with the width of two spaces
set shiftwidth=2 "indent with two spaces 
set expandtab "expand tabs into spaces
set smarttab
set autoindent

"search
set incsearch
set ignorecase

"folding
set foldmethod=syntax
set foldlevelstart=99

"syntax highlighting
let html_no_rendering=1
let javaScript_fold=1         " JavaScript
let perl_fold=1               " Perl
let php_folding=1             " PHP
let r_syntax_folding=1        " R
let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
let xml_syntax_folding=1      " XML
"highlight ftl (Freemarker templates) as HTML
autocmd BufNewFile,BufRead *.ftl setfiletype html

"autocompletion
autocmd FileType html iabbrev </ </<C-X><C-O><C-F>
autocmd FileType js iabbrev fun function
autocmd FileType js iabbrev ret return
autocmd FileType js iabbrev ; ;<CR>

"scrolling
set scrolloff=2 "keep 2 lines visible over/below the cursor
set sidescrolloff=2

"do not write a backup file (does not play nicely with file watches, f.e. by Grunt)
set nowritebackup

"adjust the <leader> key
let mapleader=","

"custom commands
"create mappings to edit the vimrc easily
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
"normal mode: quote word in double quotes
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
"normal mode: quote word in single quotes
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
"visual mode: wrap in double quotes
vnoremap <leader>" <esc>`<i"<esc>`>i"<esc>
"visual mode: wrap in single quotes
vnoremap <leader>' <esc>`<i"<esc>`>i"<esc>
"ability to use jk to exit insert mode
inoremap jk <esc>
"disable the ESC key so that I actually learn the new mapping
inoremap <esc> <Nop>


"disable ex mode
nnoremap Q <Nop>
"do not overwrite the default buffer when using x
noremap x "_x

"select a colorscheme
colorscheme molokai

"adjustments to the dark color scheme
highlight Visual      cterm=UNDERLINE
"highlight clear SpellBad
"highlight SpellBad cterm=underline,bold ctermfg=magenta

"dbext connection parameters
let g:dbext_default_PGSQL_cmd_terminator = ";"
let g:dbext_default_profile_pgsql_wahlen = "type=PGSQL:user=adrian:dbname=wahldaten"
let g:dbext_default_autoclose = 1

"emett configuration
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
