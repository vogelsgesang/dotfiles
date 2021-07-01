"""""""""""""""""""""""""
"General editing-related config
"""""""""""""""""""""""""

"enable filetype specific filetypes and indents
filetype plugin indent on
syntax on

"adjust the <leader> key
let mapleader=","

"always use unix encoding
set fileformats=unix

"line numbers
set number "shows absolute line number for current line

"splitting
set splitbelow "put horizontal splits below
set splitright "put vertical splits to the right

"tabs
set softtabstop=3 "number of spaces used with tab/bs
set tabstop=3 "display tabs with the width of 3 spaces
set shiftwidth=3 "indent with 3 spaces
set expandtab "expand tabs into spaces
set smarttab
set autoindent

"search
set ignorecase

"scrolling
set cursorline
set scrolloff=2 "keep 2 lines visible over/below the cursor
set sidescrolloff=2

"do not write a backup file (does not play nicely with file watches, f.e. by Grunt)
set nowritebackup

"""""""""""""""""""""""""
"command line autocompletion
"""""""""""""""""""""""""
set wildmenu
set wildmode=longest,list
set wildignore+=*.a,*.o
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=.DS_Store,.git,.hg,.svn
set wildignore+=*~,*.swp,*.tmp

"""""""""""""""""""""""""
" Overwrite built-in shotcuts
"""""""""""""""""""""""""
"disable ex mode
nnoremap Q <Nop>
"do not overwrite the default buffer when using x
noremap x "_x


"""""""""""""""""""""""""
" General, useful shortcuts
"""""""""""""""""""""""""
"normal mode: comment out word
nnoremap <leader>* viw<esc>a*/<esc>hbi/*<esc>lel
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
"create mappings to edit the vimrc easily
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

"""""""""""""""""""""""""
"Plugins
"""""""""""""""""""""""""

call plug#begin()
Plug 'prabirshrestha/async.vim'
" Themes
Plug 'sjl/badwolf' "badwolf theme
Plug 'tomasr/molokai' "molokai theme
" General editing/navigation
Plug 'ctrlpvim/ctrlp.vim' "fuzzy file search
Plug 'scrooloose/nerdtree' "file tree explorer
Plug 'godlygeek/tabular' "text aligning; http://media.vimcasts.org/videos/29/alignment.ogv
Plug 'prabirshrestha/vim-lsp' " LSP support
Plug 'liuchengxu/vista.vim' " tagbar based on lsp
"" Other languages/syntax highlighting
"Plug 'Superbil/llvm.vim' "syntax highlighting for LLVM code; destroys shiftwidth
Plug 'bfrg/vim-cpp-modern' "syntax highlighting for LLVM code; destroys shiftwidth
Plug 'rust-lang/rust.vim' "syntax highlighting for Rust code
Plug 'plasticboy/vim-markdown' "markdown support
Plug 'leafgarland/typescript-vim' "typescript syntax support
Plug 'lepture/vim-jinja' "jinja syntax support
call plug#end()

silent! colorscheme molokai

"ctrlp
let g:ctrlp_max_files=40000
let g:ctrlp_custom_ignore = '\v[\/](\.git|\.hg|\.svn|\.ade_path|Release|Debug)$'

"LSP support
if executable('clangd-9')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'lsp',
        \ 'cmd': {server_info->['clangd-9', '--background-index', '--compile-commands-dir=Debug']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif
let g:lsp_diagnostics_enabled = 0
nnoremap <leader>rk :LspDeclaration<cr>
nnoremap <leader>rj :LspDefinition<cr>
nnoremap <leader>rf :LspReferences<cr>

"Nerdree
nmap <leader>f :NERDTreeToggle<CR>

"Tadbar
nmap <leader>t :Vista!!<CR>

set shiftwidth=3 "indent with 3 spaces
