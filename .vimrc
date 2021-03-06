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
"Plugin 'scrooloose/syntastic' "syntax checking
Plugin 'ctrlpvim/ctrlp.vim' "fuzzy file search
Plugin 'dbext.vim' "auto completion etc. for SQL involving database
Plugin 'vim-scripts/SQLComplete.vim' "auto completion based on dbext.vim
Plugin 'pangloss/vim-javascript' "improved JS syntax and identation support
"Plugin 'marijnh/tern_for_vim' "really good JS autocompletion
Plugin 'wesQ3/vim-windowswap' "window swap
Plugin 'tpope/vim-fugitive' "git integration
Plugin 'godlygeek/tabular' "text aligning; http://media.vimcasts.org/videos/29/alignment.ogv
Plugin 'scrooloose/nerdtree' "file tree explorer
Plugin 'TagBar'
"syntax highlighting
Plugin 'Superbil/llvm.vim' "syntax highlighting for LLVM code
Plugin 'groenewege/vim-less' "syntax highlighting for less
Plugin 'digitaltoad/vim-jade' "syntax highlighting for jade
Plugin 'alunny/pegjs-vim' "syntax highlighting for pegjs grammars
Plugin 'mattn/emmet-vim' "shortcuts for HTML editing
Plugin 'plasticboy/vim-markdown' "markdown support
Plugin 'chaquotay/ftl-vim-syntax' "freemarker support
Plugin 'mxw/vim-jsx' "jsx syntax support
Plugin 'lepture/vim-jinja' "jinja syntax support
Plugin 'derekwyatt/vim-scala'
Plugin 'majutsushi/tagbar'
call vundle#end()

set tags=./tags;/
nmap <F8> :TagbarToggle<CR>
"cscope
if has('cscope')
  set cscopetag cscopeverbose

  if has('quickfix')
    set cscopequickfix=s-,c-,d-,i-,t-,e-
  endif

  cnoreabbrev csa cs add
  cnoreabbrev csf cs find
  cnoreabbrev csk cs kill
  cnoreabbrev csr cs reset
  cnoreabbrev css cs show
  cnoreabbrev csh cs help

  command -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src

  nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
  nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

  nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
  nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>

  nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
  nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>
endif


"enable filetype specific filetypes and indents
filetype plugin indent on
syntax on

"always use unix encoding
set fileformats=unix

let g:ctrlp_root_markers = ['Makefile']
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|ade_path)$'
set number "shows absolute line number for current line
set splitbelow "put horizontal splits below
set splitright "put vertical splits to the right

let g:ycm_global_ycm_extra_conf = '~/dotfiles/.ycm_extra_conf.py'

"settings for synstastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']

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
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_confirm_extra_conf = 0
autocmd FileType html iabbrev </ </<C-X><C-O><C-F>
autocmd FileType js iabbrev fun function
autocmd FileType js iabbrev ret return
autocmd FileType js iabbrev ; ;<CR>

"scrolling
set scrolloff=2 "keep 2 lines visible over/below the cursor
set sidescrolloff=2

"do not write a backup file (does not play nicely with file watches, f.e. by Grunt)
set nowritebackup

"command line autocompletion
set wildmenu
set wildmode=longest,list
set wildignore+=*.a,*.o
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=.DS_Store,.git,.hg,.svn
set wildignore+=*~,*.swp,*.tmp

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
