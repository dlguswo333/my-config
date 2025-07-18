-- This is personally perferred vim settings file.

-- Turn on syntax highlighting.
vim.cmd("syntax on")

-- Show line numbers.
vim.cmd("set nu")

-- Show relative line numbers
vim.cmd("set rnu")

-- Highlight the current cursor line.
vim.cmd("set cursorline")

-- Show current cursor position.
vim.cmd("set ruler")

-- tab size is 4 spaces.
vim.cmd("set shiftwidth=4")

-- Use spaces instead of a tab.
vim.cmd("set expandtab")

-- Insert or deletes spaces instead of a tab at the start of line.
vim.cmd("set smarttab")

-- C style indent.
vim.cmd("set cindent")

-- Support mouse.
vim.cmd("set mouse=a")

-- Highlight search patterns.
vim.cmd("set hlsearch")

-- Show available auto completion words in command mode.
vim.cmd("set wildmenu")

-- Enable case insensitive search only if keyword not having capitals.
vim.cmd("set ignorecase")
vim.cmd("set smartcase")

-- Automatically reload on file changes.
vim.cmd("set autoread")
vim.cmd("au CursorHold * checktime")
vim.cmd("au VimResume * checktime")

-- Remember last position
vim.cmd([[
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
]])

-- In normal mode, map <c-w>+ to maximizing the current window.
vim.keymap.set(
  'n',
  '<c-w>+',
  ':resize <bar> :vertical resize <cr>'
)

-- Create an user command that copies the current buffer path into clipboard.
vim.api.nvim_create_user_command(
  'CopyCurrentBufferPath',
  function ()
    vim.cmd('let @+=@% | echo "Copied to clipboard: " . @%')
  end,
  {desc = 'Copy the current buffer path into clipboard'}
)

-- Set leader key for custom key mappings.
vim.g.mapleader = ' '

-- Update this boolean value whether you like to use lsp plugins.
local use_lsp = true

-- lazy.nvim package manager.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  -- Fuzzy find things easily.
  {
    'nvim-telescope/telescope.nvim',
    version = false,
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      defaults = {
        path_display = { 'filename_first' },
      },
      pickers = {
        colorscheme = {
          enable_preview = true
        }
      }
    }
  },
  -- Show git blame of the current line.
  {
    'lewis6991/gitsigns.nvim',
    version = false,
    opts = {}
  },
  -- Show git blame of the current line.
  {
    'f-person/git-blame.nvim',
    opts = {}
  },
  -- Highlight code with parsers.
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = {
        -- These 5 parsers should always be installed. But I don't know exactly why...
        -- https://github.com/nvim-treesitter/nvim-treesitter
        'c', 'lua', 'vim', 'vimdoc', 'query',
      },
      sync_install = true,
      ignore_install = { 'all' },
      highlight = {
        enable = true,
        is_supported = function()
          function check_big_file()
            local threshold = 300 * 1024
            -- get the full path of the current file
            local filename = vim.fn.expand('%:p')
            -- get the size of the file in bytes
            local filesize = vim.fn.getfsize(filename)
            if filesize > threshold then
                return true
            else
                return false
            end
          end

          if check_big_file() then
            return false
          end
          return true
        end
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<cr>",
          node_incremental = "<cr>",
          node_decremental = "<bs>",
        },
      },
      indent = { enable = false },
    }
  },
  -- Setup status bar.
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme = 'onedark'
      },
      sections = {
        lualine_a = {
          {
            'mode',
            -- 0 = just filename, 1 = relative path, 2 = absolute path
            fmt = function(str) return str:sub(1,1) end
            -- Truncate to show only the first character
          }
        },
        lualine_c = {
          {
            'filename',
            -- 0 = just filename, 1 = relative path, 2 = absolute path
            path = 1
          }
        },
        lualine_x = {
          'encoding',
          'filetype'
        }
      },
      inactive_sections = {
        lualine_c = {
          {
            'filename',
            -- 0 = just filename, 1 = relative path, 2 = absolute path
            path = 1
          }
        },
      }
    }
  },
  {
    'folke/which-key.nvim',
    opts = {
      win = {
        border = 'single',
      },
    }
  },
  {
    'nvim-tree/nvim-tree.lua',
    opts = {},
  },
  {
    'numToStr/Comment.nvim',
    opts = {}
  },
  -- Guess indent styles and apply from the file.
  {
    'nmac427/guess-indent.nvim',
    opts = {}
  },
  {
    'neovim/nvim-lspconfig',
     enabled = use_lsp
  },
  {
    'hrsh7th/cmp-nvim-lsp',
    enabled = use_lsp,
    dependencies = {
      'onsails/lspkind.nvim',
    },
  },
  {
    'hrsh7th/nvim-cmp',
    version = false,
    enabled = use_lsp
  },
  {
    'L3MON4D3/LuaSnip',
     enabled = use_lsp
    },
  {
    'mason-org/mason.nvim',
    version = false,
    enabled = use_lsp
  },
  {
    'mason-org/mason-lspconfig.nvim',
     enabled = use_lsp
  },
  -- Show autocompletion from the buffer.
  {
    'hrsh7th/cmp-buffer',
     enabled = use_lsp
  },
  -- Show symbols and structures inside the file.
  {
    'Bekaboo/dropbar.nvim',
    -- optional, but required for fuzzy finder support
    -- dependencies = {
    --   'nvim-telescope/telescope-fzf-native.nvim',
    --   build = 'make'
    -- },
    config = function()
      local dropbar_api = require('dropbar.api')
      vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
      vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
      vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
    end,
    enabled = use_lsp
  },
  -- Show function signatures and parameters while typing.
  {
    "ray-x/lsp_signature.nvim",
    cond = use_lsp,
    event = 'VeryLazy',
    opts = {
      handler_opts = {
        border = 'rounded'
      }
    },
    version = false,
  },
}

require("lazy").setup(plugins, {
  defaults = {
    version = '*',
  },
})

vim.cmd('colorscheme tokyonight-storm')

local builtin = require("telescope.builtin")

-- In normal mode, map <leader>o to searching for files only in cwd.
-- Allow hidden files (e.g. dotfiles) to appear but not certain files.
vim.keymap.set(
  "n",
  "<leader>o",
  function() builtin.find_files({
    hidden = true,
    -- '%' is an escape character in lua patterns.
    file_ignore_patterns={'node_modules', '%.git%/'}
  }) end,
  {}
)

-- In normal mode, map Ctrl + p to searching for files only in buffers.
vim.keymap.set(
  "n",
  "<leader>p",
  function () builtin.buffers({
    sort_mru = true,
    initial_mode = 'normal',
    ignore_current_buffer = true,
  }) end, {}
)

-- In normal mode, map Ctrl + t to searching for a string in cwd.
vim.keymap.set(
  "n",
  "<leader>t",
  builtin.live_grep, {}
)

-- This keymap closes the current buffer without closing the window.
vim.keymap.set(
  'n',
  '<leader>bd',
  ':bn <bar> :bd# <cr>'
)

-- In normal mode, map <leader>f to searching for a string in the current buffer.
vim.keymap.set(
  "n",
  "<leader>f",
   builtin.current_buffer_fuzzy_find, {}
)

-- In normal anv visual mode, map <leader>c to searching commands.
vim.keymap.set(
  {"n", "v"},
  "<leader>c",
   builtin.commands, {}
)

-- In normal mode, map <leader>e to nvimtree toggle.
vim.keymap.set(
  "n",
  "<leader>e",
   function () vim.cmd(':NvimTreeToggle <cr>') end, {}
)

-- In normal mode, map Ctrl + T to searching for telescope commands.
vim.keymap.set(
  "n",
  "<leader>r",
  function () vim.cmd(':Telescope') end, {}
)

-- Setup lsp manually.
if use_lsp then

  -- Reserve a space in the gutter
  -- This will avoid an annoying layout shift in the screen
  vim.opt.signcolumn = 'yes'

  -- Enable virtual text (e.g. inline diagnostic text)
  vim.diagnostic.config({virtual_text = true})

  -- Add cmp_nvim_lsp capabilities settings to lspconfig
  -- This should be executed before you configure any language server
  local lspconfig_defaults = require('lspconfig').util.default_config
  lspconfig_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lspconfig_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
  )

  require('mason').setup({})
  require('mason-lspconfig').setup({
    handlers = {
      -- Setup each server with default options.
      function(server_name)
        require('lspconfig')[server_name].setup({})
      end,
    },
  })

  -- This is where you enable features that only work
  -- if there is a language server active in the file
  vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
      -- nowait for overlapping keymappings.
      local opts = {buffer = event.buf, nowait = true}

      -- Setup lsp keymappings.
      vim.keymap.set(
        'n',
        'K',
        function ()
          vim.lsp.buf.hover({
            border = 'rounded',
          })
        end,
        opts
      )
      vim.keymap.set(
        'n',
        'gd',
        function()
          builtin.lsp_definitions({
            initial_mode = 'normal',
            show_line = false,
          })
        end,
        opts
      )
      vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
      vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
      vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
      vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
      vim.keymap.set(
        'n',
        'gr',
        function()
          builtin.lsp_references({
            initial_mode = 'normal',
            show_line = false,
            include_declaration = false,
          })
        end,
        opts
      )
      vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
      vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
      vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
      vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

      -- Change float styles.
      vim.diagnostic.config({
        float = { border = 'rounded' },
      })
      vim.cmd('highlight! link NormalFloat Normal')
    end,
  })

  local cmp = require('cmp')
  local lspkind = require('lspkind')
  cmp.setup({
    -- The order of the sources determines their order in the completion results.
    sources = {
      { name = 'nvim_lsp' },
      { name = 'buffer' },
    },
    snippet = {
      expand = function(args)
        -- You need Neovim v0.10 to use vim.snippet
        require('luasnip').lsp_expand(args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<Tab>'] = cmp.mapping.confirm({ select = true })
    }),
    formatting = {
      format = lspkind.cmp_format({ preset = 'codicons' }),
    }
  })

  local lspconfig = require('lspconfig')
  if lspconfig.jsonls then
    vim.lsp.config('jsonls', {
      settings = {
        json = {
          schemas = {
            {
              fileMatch = {'package.json'},
              url = 'https://json.schemastore.org/package.json',
            },
            {
              fileMatch = { 'tsconfig.json' },
              url = 'https://json.schemastore.org/tsconfig.json',
            },
          },
        },
      }
    })
  end
  if lspconfig.vtsls then
    local yarnTsdkPath = './.yarn/sdks/typescript/lib'
    vim.lsp.config('vtsls', {
      -- https://github.com/yioneko/vtsls/blob/main/packages/service/configuration.schema.json
      settings = {
        vtsls = {
          autoUseWorkspaceTsdk = true
        },
        ['js/ts'] = {
          implicitProjectConfig = {
            target = 'ESNext',
          },
        },
        javascript = {
          -- https://github.com/yioneko/vtsls/issues/169
          tsdk = vim.fn.isdirectory(yarnTsdkPath) ~= 0 and yarnTsdkPath or nil,
          format = {
            insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = false
          }
        },
        typescript = {
          tsdk = vim.fn.isdirectory(yarnTsdkPath) ~= 0 and yarnTsdkPath or nil,
          format = {
            insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = false
          }
        }
      }
    })
  end
end
