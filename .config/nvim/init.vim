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
"normal mode: quote word in single quotes
nnoremap <leader>` viw<esc>a`<esc>hbi`<esc>lel
"visual mode: wrap in double quotes
vnoremap <leader>" <esc>`<i"<esc>`>i"<esc>
"visual mode: wrap in single quotes
vnoremap <leader>' <esc>`<i'<esc>`>i'<esc>
"visual mode: wrap in single quotes
vnoremap <leader>` <esc>`<i`<esc>`>i`<esc>
"ability to use jk to exit insert mode
inoremap jk <esc>
"create mappings to edit the vimrc easily
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

"textobj-argument
"oscyank

"""""""""""""""""""""""""
"Plugins
"""""""""""""""""""""""""

call plug#begin()
" Themes
Plug 'sjl/badwolf' "badwolf theme
Plug 'tomasr/molokai' "molokai theme
" General editing/navigation
Plug 'ojroques/vim-oscyank' "copy-paste over ssh
Plug 'nvim-lua/plenary.nvim' "Dependency of other plugins
Plug 'nvim-telescope/telescope.nvim' "fuzzy matcher
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'scrooloose/nerdtree' "file tree explorer
Plug 'godlygeek/tabular' "text aligning; http://media.vimcasts.org/videos/29/alignment.ogv
"Language server support
Plug 'neovim/nvim-lspconfig' "LSP config
Plug 'hrsh7th/cmp-nvim-lsp' "LSP source for nvim-cmp
Plug 'hrsh7th/nvim-cmp' "Autocompletion plugin
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
"Plug 'simrat39/symbols-outline.nvim' " symbol tree; couple of rendering issues; maybe revisit later
" Plug 'stevearc/dressing.nvim' "nicer UI for code actions; unfortunately typrhas rendering errors
"" Other languages/syntax highlighting
"Plug 'Superbil/llvm.vim' "syntax highlighting for LLVM code; destroys shiftwidth
Plug 'bfrg/vim-cpp-modern' "syntax highlighting for C++ code
Plug 'rust-lang/rust.vim' "syntax highlighting for Rust code
Plug 'plasticboy/vim-markdown' "markdown support
Plug 'leafgarland/typescript-vim' "typescript syntax support
"Plug 'lepture/vim-jinja' "jinja syntax support
call plug#end()

silent! colorscheme molokai

" terminal config
:tnoremap <Esc> <C-\><C-n>

"OSCYank config
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | execute 'OSCYankReg +' | endif

"work around weird SQL autocompletion
let g:ftplugin_sql_omni_key       = '<C-.>'

"Nerdree
nmap <leader>t :NERDTreeToggle<CR>

""""""""""""""""""""""""""""
" Telescope
" TODO: use for LSP diagnostircs
lua <<EOF
local function set_keymap(a, b, c) vim.api.nvim_set_keymap(a, b, c, { noremap=true, silent=true }) end
set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
set_keymap('n', '<leader>f<CR>', "<cmd>lua require('telescope.builtin').resume()<cr>")
set_keymap('n', '<leader>ft', "<cmd>lua require('telescope.builtin').builtin()<cr>")
set_keymap('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<cr>")
set_keymap('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>")
set_keymap('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>")
set_keymap('n', '<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<cr>")
set_keymap('n', '<leader>fr', "<cmd>lua require('telescope.builtin').lsp_references()<cr>")

local telescope = require("telescope");
telescope.setup {
  mappings = {
    i = {
       -- TODO: configure history and https://github.com/nvim-telescope/telescope-smart-history.nvim
      ["C-p"] = require('telescope.actions').cycle_history_next,
      ["C-n"] = require('telescope.actions').cycle_history_prev,
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_cursor({
        -- even more opts
      })
    }
  }
}
telescope.load_extension("ui-select")
EOF


""""""""""""""""""""""""""""
"LSP support
lua <<EOF
local cmp = require'cmp'
local nvim_lsp = require('lspconfig')

-----------------------
-- Setup nvim-cmp.
cmp.setup({
  completion = {
    autocomplete = false,
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
})

-----------------------
-- Shortcuts for diagnostics

local function set_keymap(a, b, c) vim.api.nvim_set_keymap(a, b, c, { noremap=true, silent=true }) end
set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>')

-----------------------
-- Setup lspconfig.

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(a, b, c) vim.api.nvim_buf_set_keymap(bufnr, a, b, c, { noremap=true, silent=true }) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  buf_set_keymap('n', 'g<Tab>', '<cmd>ClangdSwitchSourceHeader<CR>')
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  buf_set_keymap('v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>')
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
  buf_set_keymap('v', '<leader>f', '<cmd>lua vim.lsp.buf.range_formatting()<CR>')
end

nvim_lsp["clangd"].setup {
  capabilities = require('cmp_nvim_lsp').update_capabilities(nvim_lsp["clangd"].document_config.default_config.capabilities),
  -- to debug: '-log:verbose'
  cmd = { 'clangd', '--enable-config', '--use-dirty-headers', '--hidden-features'},
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 1000,
  }
}
EOF
