-- This is personally perferred vim settings file.

-- Turn on syntax highlighting.
vim.cmd("syntax on")

-- Show line numbers.
vim.cmd("set nu")

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

-- Set colorscheme
vim.cmd("colorscheme shine")

-- Remember last position
vim.cmd([[
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
]])

-- Set leader key for custom key mappings.
vim.g.mapleader = ' '

-- Update this boolean value whether you like to use lsp plugins.
local use_lsp = false

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
  -- Fuzzy find things easily.
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local config = require('telescope')
      config.setup({
        pickers = {
          colorscheme = {
            enable_preview = true
          }
        }
      })
    end
  },
  -- Show git blame of the current line.
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },
  -- Show git blame of the current line.
  { 'f-person/git-blame.nvim' },
  -- Highlight code with parsers.
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local config = require('nvim-treesitter.configs')
      config.setup({
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
        indent = { enable = false },
      })
    end
  },
  -- Setup status bar.
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'ayu_light'
        },
        sections = {
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
        }
      })
    end
  },
  -- Guess indent styles and apply from the file.
  {
    'nmac427/guess-indent.nvim',
    config = function()
      require('guess-indent').setup()
    end
  },
  -- Setup lsp using lsp-zero. Belows are dependencies.
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    cond = use_lsp
  },
  {
    'neovim/nvim-lspconfig',
     cond = use_lsp
  },
  {
    'hrsh7th/cmp-nvim-lsp',
     cond = use_lsp
    },
  {
    'hrsh7th/nvim-cmp',
     cond = use_lsp
    },
  {
    'L3MON4D3/LuaSnip',
     cond = use_lsp
    },
  {
    'williamboman/mason.nvim',
     cond = use_lsp
    },
  {
    'williamboman/mason-lspconfig.nvim',
     cond = use_lsp
  },
}
require("lazy").setup(plugins, opts)
local builtin = require("telescope.builtin")
local utils = require("telescope.utils")

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
  builtin.buffers, {}
)

-- In normal mode, map Ctrl + t to searching for a string in cwd.
vim.keymap.set(
  "n",
  "<leader>t",
  builtin.live_grep, {}
)

-- In normal mode, map <leader>f to searching for a string in the current buffer.
vim.keymap.set(
  "n",
  "<leader>f",
   builtin.current_buffer_fuzzy_find, {}
)

-- Setup lsp using lsp-zero.
if use_lsp then
  require('mason').setup({})
  local lsp_zero = require('lsp-zero')
  lsp_zero.on_attach(function(_, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({buffer = bufnr})
    -- Show lsp_references within telescope.
    vim.keymap.set(
      'n',
      'gr',
      function() builtin.lsp_references({initial_mode = 'normal'}) end,
      {buffer = bufnr}
    )
  end)
  require('mason-lspconfig').setup({
    handlers = {
      lsp_zero.default_setup
    }
  })
  local cmp = require('cmp')
  cmp.setup({
    mapping = {
      ['<Tab>'] = cmp.mapping.confirm({select = true})
    },
    window = {
      completion = {
        border = 'rounded',
        -- winhighlight = 'Normal:CmpNormal',
      }
    }
  })

  local lspconfig = require('lspconfig')
  if lspconfig.jsonls then
    lspconfig.jsonls.setup({
      settings = {
        json = {
          schemas = {
            {
              fileMatch = {'package.json'},
              url = 'https://json.schemastore.org/package.json',
            },
          },
        },
      }
    })
  end
end
