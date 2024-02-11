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

-- trigger `CursorHold` events after 1.5 seconds
vim.opt.updatetime = 1500

-- Github limits commit messages to 72 characters per line
-- vim.api.nvim_create_autocmd("BufRead,BufNewFile", {pattern = "COMMIT_EDITMSG", command = "setlocal textwidth=0"})

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
--disable ex mode
vim.keymap.set("n", "Q", "")
--do not overwrite the default buffer when using x
vim.keymap.set("n", "x", '"_x')


--------------------------
-- General, useful shortcuts
--------------------------
--normal mode: comment out word
vim.keymap.set("n", "<leader>*", "viw<esc>a*/<esc>hbi/*<esc>lel")
--normal mode: quote word in double quotes
vim.keymap.set("n", '<leader>"', 'viw<esc>a"<esc>hbi"<esc>lel')
--normal mode: quote word in single quotes
vim.keymap.set("n", "<leader>'", "viw<esc>a'<esc>hbi'<esc>lel")
--normal mode: quote word in single quotes
vim.keymap.set("n", "<leader>`", "viw<esc>a`<esc>hbi`<esc>lel")
--visual mode: wrap in double quotes
vim.keymap.set("v", '<leader>"', '<esc>`<i"<esc>`>i"<esc>')
--visual mode: wrap in single quotes
vim.keymap.set("v", "<leader>'", "<esc>`<i'<esc>`>i'<esc>")
--visual mode: wrap in single quotes
vim.keymap.set("v", "<leader>`", "<esc>`<i`<esc>`>i`<esc>")
--use jk to exit insert mode
vim.keymap.set("i", "jk", "<esc>")
--create mappings to edit the vimrc easily
vim.keymap.set("n", "<leader>ev", ":split $MYVIMRC<cr>")
vim.keymap.set("n", "<leader>sv", ":source $MYVIMRC<cr>")

--------------------------
--Plugins
--------------------------

--TODO: textobj-argument
--TODO: https://github.com/skywind3000/asynctasks.vim

local Plug = vim.fn['plug#']

vim.call('plug#begin')
-- Themes & general rendering
Plug 'sjl/badwolf' -- badwolf theme
Plug 'tomasr/molokai' -- molokai theme
Plug 'kyazdani42/nvim-web-devicons' -- icons in Telescope
-- General editing/navigation
Plug 'nvim-lua/plenary.nvim' -- Dependency of other plugins
Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' })
Plug 'nvim-telescope/telescope.nvim' -- fuzzy matcher
Plug 'nvim-telescope/telescope-ui-select.nvim' -- integration of LSP into Telescope
Plug 'rcarriga/nvim-notify' -- LSP notifications
Plug 'scrooloose/nerdtree' -- file tree explorer
Plug 'godlygeek/tabular' -- text aligning; http://media.vimcasts.org/videos/29/alignment.ogv
-- languages/syntax highlighting
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'}) -- Treesitter
-- Language server support
Plug 'neovim/nvim-lspconfig' -- LSP config
Plug 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
Plug 'hrsh7th/nvim-cmp' -- Autocompletion plugin
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'stevearc/dressing.nvim' -- nicer UI for code actions; unfortunately typrhas rendering errors
Plug 'simrat39/symbols-outline.nvim' -- symbol outline of current file
Plug 'mfussenegger/nvim-dap' --  Debug adapter
vim.call('plug#end')

vim.cmd("silent! colorscheme molokai")

-- terminal config
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

--Nerdree
vim.keymap.set("n", "<leader>t", ":NERDTreeToggle<CR>")

--------------------------------------------
-- Telescope
--------------------------------------------
local telescope = require("telescope");
local telescope_builtin = require("telescope.builtin");

-- The `<leader>f` prefix is for toplevel entry points, independent of the current buffer
-- "f" stands for "find"
vim.keymap.set('n', '<leader>f<CR>', telescope_builtin.resume)
vim.keymap.set('n', '<leader>ft', telescope_builtin.builtin)
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files)
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep)
vim.keymap.set('n', '<leader>fb', function()
   telescope_builtin.buffers({ sort_mru = true, ignore_current_buffer = true })
end)
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags)
vim.keymap.set('n', '<leader>fs', telescope_builtin.lsp_dynamic_workspace_symbols)

-- Git history. `h` as in "history"
vim.keymap.set('n', '<leader>h', telescope_builtin.git_bcommits)

-- Previously opened files
-- vim.keymap.set('n', '<leader>o', telescope_builtin.old_files)


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
vim.keymap.set('n', '<leader>n', require('telescope').extensions.notify.notify)


--------------------------------------------
-- Treesitter
--------------------------------------------

require('nvim-treesitter.configs').setup({
    ensure_installed = {
       -- System programming
       "c", "cpp", "rust", "proto",
        -- Web development
       "typescript", "css", "html", "sql",
       -- Scripting
       "python", "bash",
       -- Build systems
       "cmake", "starlark",
       -- Neovim itself
       "lua", "vimdoc",
       -- Text editing
       "markdown", "rst", "latex",
       -- File format
       "json", "yaml"},
    sync_install = false,
    auto_install = false,
    highlight = {
        enable = true,
    },
})

-- Use treesitter for code folding
vim.opt.foldlevelstart=999
vim.opt.foldmethod="expr"
vim.api.nvim_command("set foldexpr=nvim_treesitter#foldexpr()")

--------------------------------------------
-- LSP support
--------------------------------------------

local cmp = require'cmp'
local nvim_lsp = require('lspconfig')

-----------------------
-- Setup nvim-cmp.
luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
})

-----------------------
-- Shortcuts for diagnostics

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', telescope_builtin.diagnostics)

-----------------------
-- Setup lspconfig.

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client == nil then
      return
    end

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition)
    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references)
    vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
    vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action)
    vim.keymap.set({'n', 'v'}, '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)

    -- Trigger highlighting of symbol under cursor by keeping the cursor still
    if client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd('CursorHold', { callback = vim.lsp.buf.document_highlight})
      vim.api.nvim_create_autocmd('CursorHoldI', { callback = vim.lsp.buf.document_highlight})
      vim.api.nvim_create_autocmd('CursorMoved', { callback = vim.lsp.buf.clear_references})
    end

    -- clangd-specific key bindings
    if client.name == "clangd" then
      vim.keymap.set('n', 'g<Tab>', "<cmd>ClangdSwitchSourceHeader<CR>")
    end
  end
})

-- Highlighting of references
vim.api.nvim_set_hl(0, 'LspReferenceText', { bg = '#5555aa', default = true })
vim.api.nvim_set_hl(0, 'LspReferenceRead', { bg = '#5555aa', default = true })
vim.api.nvim_set_hl(0, 'LspReferenceWrite', { bg = '#5555aa', default = true })

nvim_lsp["clangd"].setup({
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  -- to debug: '-log:verbose'
  -- --hidden-features
  -- cmd = { 'clangd', '--enable-config', '--use-dirty-headers', '--limit-references=10000', '--limit-results=10000', '--hidden-features'},
  -- cmd = { '/Users/avogelsgesang/hyper/hyper-db/bazel-hyper-db/external/clang_darwin/bin/clangd', '--enable-config', '--limit-references=10000', '--limit-results=10000', '--parse-forwarding-functions'},
  cmd = { 'clangd', '--enable-config', '--limit-references=10000', '--limit-results=10000', '--parse-forwarding-functions'},
  flags = {
    debounce_text_changes = 300,
  }
})

-- Lua language server for editing Neovim config
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
require'lspconfig'.lua_ls.setup {
  on_init = function(client)
    local path = "."
    if client.workspace_folders then
      path = client.workspace_folders[1].name
    end
    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            }
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true)
          }
        }
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end
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

-- Symbols outline
require("symbols-outline").setup()
vim.keymap.set('n', '<leader>s', "<cmd>SymbolsOutline<cr>")

--------------------------------------------
-- Hyper IR LSP
--------------------------------------------

vim.filetype.add({
  extension = {
    hir = 'hyper_ir',
  }
})

require('lspconfig.configs').hyper_ir_lsp = {
  default_config = {
    cmd = { '/home/avogelsgesang/Documents/hyper-ir-lsp/target/release/hyper-ir-lsp' },
    name = 'Hyper IR LSP',
    filetypes = {'hyper_ir'},
    root_dir = function(fname)
      return nvim_lsp.util.find_git_ancestor(fname)
    end,
  }
}

nvim_lsp["hyper_ir_lsp"].setup({})

local hyper_ir_links = {
  ['@lsp.type.keyword.hyper_ir'] = '@keyword',
  ['@lsp.type.modifier.hyper_ir'] = '@keyword',
  ['@lsp.type.type.hyper_ir'] = '@type',
  ['@lsp.type.variable.hyper_ir'] = 'Identifier',
  ['@lsp.type.number.hyper_ir'] = '@number',
  ['@lsp.type.string.hyper_ir'] = '@string',
}

for newgroup, oldgroup in pairs(hyper_ir_links) do
  vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
end

--------------------------------------------
-- Debug adapter
--------------------------------------------
local dap = require('dap')

-- Keymap for debugging
vim.keymap.set('n', '<leader>dc', dap.continue)
vim.keymap.set('n', '<leader>dr', dap.run_last)
vim.keymap.set('n', '<leader>dn', dap.step_over)
vim.keymap.set('n', '<leader>ds', dap.step_into)
vim.keymap.set('n', '<leader>df', dap.step_out) -- "f" as in "finish"
vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>dB', function()
   dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end)
vim.keymap.set('n', '<leader>dl', function()
   dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
end)
vim.keymap.set('n', '<leader>dt', dap.repl.toggle) -- "t" as in "terminal"

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
