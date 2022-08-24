--------------------------
--General editing-related config
--------------------------

--adjust the <leader> key
vim.g.mapleader = ","

--use full color space
vim.opt.termguicolors = true

--always use unix encoding
vim.opt.fileformats = "unix"

--line numbers
vim.opt.number = true

--splitting
vim.opt.splitbelow = true --put horizontal splits below
vim.opt.splitright = true --put vertical splits to the right

--tabs
vim.opt.softtabstop = 3 --number of spaces used with tab/bs
vim.opt.tabstop = 3 --display tabs with the width of 3 spaces
vim.opt.shiftwidth = 3 --indent with 3 spaces
vim.opt.expandtab = true --expand tabs into spaces
vim.opt.smarttab = true
vim.opt.autoindent = true

-- search case insensitive if term is all lowercase
vim.opt.ignorecase = true
vim.opt.smartcase = true

--scrolling
vim.opt.cursorline = true
vim.opt.scrolloff = 2 --keep 2 lines visible over/below the cursor
vim.opt.sidescrolloff = 2

--disable mouse
vim.opt.mouse=""

--do not write a backup file (does not play nicely with file watches, f.e. by Grunt)
vim.opt.writebackup = false

--------------------------
--command line autocompletion
--------------------------
vim.opt.wildmenu = true
vim.opt.wildmode = longest,list
vim.opt.wildignore = "*.a,*.o"
vim.opt.wildignore:append("*.bmp,*.gif,*.ico,*.jpg,*.png")
vim.opt.wildignore:append(".DS_Store,.git,.hg,.svn")
vim.opt.wildignore:append("*~,*.swp,*.tmp")

--------------------------
-- Overwrite built-in shotcuts
--------------------------
local function set_keymap(a, b, c) vim.api.nvim_set_keymap(a, b, c, { noremap=true, silent=true }) end
--disable ex mode
set_keymap("n", "Q", "")
--do not overwrite the default buffer when using x
set_keymap("n", "x", '"_x')


--------------------------
-- General, useful shortcuts
--------------------------
--normal mode: comment out word
set_keymap("n", "<leader>*", "viw<esc>a*/<esc>hbi/*<esc>lel")
--normal mode: quote word in double quotes
set_keymap("n", '<leader>"', 'viw<esc>a"<esc>hbi"<esc>lel')
--normal mode: quote word in single quotes
set_keymap("n", "<leader>'", "viw<esc>a'<esc>hbi'<esc>lel")
--normal mode: quote word in single quotes
set_keymap("n", "<leader>`", "viw<esc>a`<esc>hbi`<esc>lel")
--visual mode: wrap in double quotes
set_keymap("v", '<leader>"', '<esc>`<i"<esc>`>i"<esc>')
--visual mode: wrap in single quotes
set_keymap("v", "<leader>'", "<esc>`<i'<esc>`>i'<esc>")
--visual mode: wrap in single quotes
set_keymap("v", "<leader>`", "<esc>`<i`<esc>`>i`<esc>")
--use jk to exit insert mode
set_keymap("i", "jk", "<esc>")
--create mappings to edit the vimrc easily
set_keymap("n", "<leader>ev", ":split $MYVIMRC<cr>")
set_keymap("n", "<leader>sv", ":source $MYVIMRC<cr>")

--------------------------
--Plugins
--------------------------

--TODO: textobj-argument
--TODO: https://github.com/skywind3000/asynctasks.vim
--TODO: simrat39/symbols-outline.nvim -- symbol tree; couple of rendering issues; maybe revisit later

local Plug = vim.fn['plug#']

vim.call('plug#begin')
-- Themes
Plug 'sjl/badwolf' -- badwolf theme
Plug 'tomasr/molokai' -- molokai theme
-- General editing/navigation
Plug 'ojroques/vim-oscyank' -- copy-paste over ssh
Plug 'nvim-lua/plenary.nvim' -- Dependency of other plugins
Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' })
Plug 'nvim-telescope/telescope.nvim' -- fuzzy matcher
Plug 'nvim-telescope/telescope-ui-select.nvim' -- integration of LSP into Telescope
Plug 'rcarriga/nvim-notify' -- LSP notifications
Plug 'scrooloose/nerdtree' -- file tree explorer
Plug 'godlygeek/tabular' -- text aligning; http://media.vimcasts.org/videos/29/alignment.ogv
-- Language server support
Plug 'neovim/nvim-lspconfig' -- LSP config
Plug 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
Plug 'hrsh7th/nvim-cmp' -- Autocompletion plugin
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'stevearc/dressing.nvim' -- nicer UI for code actions; unfortunately typrhas rendering errors
Plug 'mfussenegger/nvim-dap' --  Debug adapter
-- Other languages/syntax highlighting
Plug 'bfrg/vim-cpp-modern' -- syntax highlighting for C++ code
Plug 'rust-lang/rust.vim' -- syntax highlighting for Rust code
Plug 'plasticboy/vim-markdown' -- markdown support
Plug 'leafgarland/typescript-vim' -- typescript syntax support
vim.call('plug#end')

vim.cmd("silent! colorscheme molokai")

-- terminal config
set_keymap("t", "<Esc>", "<C-\\><C-n>")

--OSCYank config
vim.cmd("autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | execute 'OSCYankReg +' | endif")

--Nerdree
set_keymap("n", "<leader>t", ":NERDTreeToggle<CR>")

--------------------------------------------
-- Telescope
--------------------------------------------

-- The `<leader>f` prefix is for toplevel entry points, independent of the current buffer
-- "f" stands for "find"
set_keymap('n', '<leader>f<CR>', "<cmd>lua require('telescope.builtin').resume()<cr>")
set_keymap('n', '<leader>ft', "<cmd>lua require('telescope.builtin').builtin()<cr>")
set_keymap('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<cr>")
set_keymap('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>")
set_keymap('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers({ sort_mru = true, ignore_current_buffer = true })<cr>")
set_keymap('n', '<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<cr>")
set_keymap('n', '<leader>fs', "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>")

-- Git history. `h` as in "history"
set_keymap('n', '<leader>h', "<cmd>lua require('telescope.builtin').git_bcommits()<cr>")


local telescope = require("telescope");
telescope.setup ({
  defaults = {
    mappings = {
      i = {
        ["<C-p>"] = require('telescope.actions').cycle_history_prev,
        ["<C-n>"] = require('telescope.actions').cycle_history_next,
      },
    },
  },
  pickers = {
    buffers = {
      mappings = {
        n = {
          ['d'] = require('telescope.actions').delete_buffer
        },
      },
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_cursor({})
    }
  }
})
telescope.load_extension("ui-select")
telescope.load_extension("fzf")


--------------------------------------------
-- Notifications
--------------------------------------------
local notify = require("notify")
notify.setup({
    max_width = 80,
    max_height = 20,
    icons = {
        ERROR = "",
        WARN = "",
        INFO = "",
        DEBUG = "",
        TRACE = "✎",
    }
})
vim.notify = notify
set_keymap('n', '<leader>n', "<cmd>lua require('telescope').extensions.notify.notify()<cr>")


--------------------------------------------
-- LSP support
--------------------------------------------

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

set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
set_keymap('n', '<space>q', "<cmd>lua require('telescope.builtin').diagnostics()<cr>")

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
  buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  buf_set_keymap('n', 'gr', "<cmd>lua require('telescope.builtin').lsp_references()<cr>")
  buf_set_keymap('n', 'gd', "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>")
  buf_set_keymap('n', 'g<Tab>', '<cmd>ClangdSwitchSourceHeader<CR>')
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  buf_set_keymap('v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>')
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.format({async=True})<CR>')
  buf_set_keymap('v', '<leader>f', '<cmd>lua vim.lsp.buf.range_formatting()<CR>')
end

nvim_lsp["clangd"].setup {
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  -- to debug: '-log:verbose'
  -- --hidden-features
  -- cmd = { 'clangd', '--enable-config', '--use-dirty-headers', '--limit-references=10000', '--limit-results=10000', '--hidden-features'},
  cmd = { '/home/tsi/avogelsgesang/Documents/llvm-project/build/bin/clangd', '--enable-config', '--limit-references=10000', '--limit-results=10000'},
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 1000,
  }
}

vim.lsp.handlers['window/showMessage'] = function(_, result, ctx)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  local lvl = ({
    'ERROR',
    'WARN',
    'INFO',
    'DEBUG',
  })[result.type]
  vim.notify(result.message, lvl, {
    title = 'LSP | ' .. client.name,
    timeout = 10000,
    keep = function()
      return lvl == 'ERROR' or lvl == 'WARN'
    end,
  })
end


-- LSP progress notifications
-- based on https://github.com/rcarriga/nvim-notify/issues/43#issuecomment-1030604806
local client_notifs = {}

local function get_notif_data(client_id, token)
  if not client_notifs[client_id] then
    client_notifs[client_id] = {}
  end

  if not client_notifs[client_id][token] then
    client_notifs[client_id][token] = {}
  end

  return client_notifs[client_id][token]
end


local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }

local function update_spinner(client_id, token)
  local notif_data = get_notif_data(client_id, token)

  if notif_data.spinner then
    local new_spinner = (notif_data.spinner + 1) % #spinner_frames
    notif_data.spinner = new_spinner

    notif_data.notification = vim.notify(nil, nil, {
      hide_from_history = true,
      icon = spinner_frames[new_spinner],
      replace = notif_data.notification,
    })

    vim.defer_fn(function()
      update_spinner(client_id, token)
    end, 100)
  end
end

local function format_title(title, client_name)
  return client_name .. (#title > 0 and ": " .. title or "")
end

local function format_message(message, percentage)
  return (percentage and percentage .. "%\t" or "") .. (message or "")
end

vim.lsp.handlers["$/progress"] = function(_, result, ctx)
  local client_id = ctx.client_id

  local val = result.value

  if not val.kind then
    return
  end

  local notif_data = get_notif_data(client_id, result.token)

  if val.kind == "begin" then
    local message = format_message(val.message, val.percentage)

    notif_data.notification = vim.notify(message, "info", {
      title = format_title(val.title, vim.lsp.get_client_by_id(client_id).name),
      icon = spinner_frames[1],
      timeout = false,
      hide_from_history = false,
    })

    notif_data.spinner = 1
    update_spinner(client_id, result.token)
  elseif val.kind == "report" and notif_data then
    notif_data.notification = vim.notify(format_message(val.message, val.percentage), "info", {
      replace = notif_data.notification,
      hide_from_history = false,
    })
  elseif val.kind == "end" and notif_data then
    notif_data.notification =
      vim.notify(val.message and format_message(val.message) or "Complete", "info", {
        icon = "",
        replace = notif_data.notification,
        timeout = 3000,
      })

    notif_data.spinner = nil
  end
end


--------------------------------------------
-- Debug adapter
--------------------------------------------
local dap = require('dap')

-- Keymap for debugging
set_keymap('n', '<leader>dc', "<cmd>lua require('dap').continue()<cr>")
set_keymap('n', '<leader>dr', "<cmd>lua require('dap').run_last()<cr>")
set_keymap('n', '<leader>dn', "<cmd>lua require('dap').step_over()<cr>")
set_keymap('n', '<leader>ds', "<cmd>lua require('dap').step_into()<cr>")
set_keymap('n', '<leader>df', "<cmd>lua require('dap').step_out()<cr>") -- "f" as in "finish"
set_keymap('n', '<leader>db', "<cmd>lua require('dap').toggle_breakpoint()<cr>")
set_keymap('n', '<leader>dB', "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
set_keymap('n', '<leader>dl', "<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>")
set_keymap('n', '<leader>dt', "<cmd>lua require('dap').repl.toggle()<cr>") -- "t" as in "terminal"

-- Symbols
vim.fn.sign_define('DapStop', {text='🤡', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointCondition', {text='🟥', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapLogPoint', {text='🟣', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='🟡', texthl='', linehl='', numhl=''})

-- Python debugging
dap.adapters.python = {
  type = 'executable';
  command = 'python3';
  args = { '-m', 'debugpy.adapter' };
}

dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "Launch file";

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}"; -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        return '/usr/bin/python3'
      end
    end;
  },
}

-- C++ debugging
dap.adapters.lldb = {
  type = 'executable',
  command = '/home/tsi/avogelsgesang/Documents/llvm-project/build/bin/lldb-vscode',
  name = "lldb"
}

dap.configurations.cpp = {
    {
      name = "Spawn sql_hyper",
      type = 'lldb',
      request = 'launch',
      program = '${workspaceFolder}/bazel-bin/hyper/tools/sql_hyper/sql_hyper',
      args = {"!", "test.sql"},
      -- stopOnEntry = true,
      sourcePath = "${workspaceFolder}",
    },
    {
      name = "Attach to gdb-server",
      type = 'lldb',
      request = 'attach',
      attachCommands = {"gdb-remote localhost:9999"},
      sourcePath = "${workspaceFolder}",
    },
}

dap.listeners.before['event_progressStart']['progress-notifications'] = function(session, body)
  local notif_data = get_notif_data("dap", body.progressId)

  local message = format_message(body.message, body.percentage)
  notif_data.notification = vim.notify(message, "info", {
    title = format_title(body.title, session.config.type),
    icon = spinner_frames[1],
    timeout = false,
    hide_form_history = false,
  })

  notif_data.notification.spinner = 1,
  update_spinner("dap", body.progressId)
end

dap.listeners.before['event_progressUpdate']['progress-notifications'] = function(session, body)
  local notif_data = get_notif_data("dap", body.progressId)
  notif_data.notification = vim.notify(format_message(body.message, body.percentage), "info", {
    replace = notif_data.notification,
    hide_form_history = false,
  })
end

dap.listeners.before['event_progressEnd']['progress-notifications'] = function(session, body)
  local notif_data = client_notifs["dap"][body.progressId]
  notif_data.notification = vim.notify(body.message and format_message(body.message) or "Complete", "info", {
     icon = "",
     replace = notif_data.notification,
     timeout = 3000
  })
  notif_data.spinner = nil
end
