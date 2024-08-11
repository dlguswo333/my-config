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

-- Automatically reload on file changes.
vim.cmd("set autoread")

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
  -- Fuzzy find things easily.
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
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
        theme = 'ayu_light'
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
  -- Setup lsp using lsp-zero and plugins below this line are all about lsp.
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    enabled = use_lsp
  },
  {
    'neovim/nvim-lspconfig',
     enabled = use_lsp
  },
  {
    'hrsh7th/cmp-nvim-lsp',
     enabled = use_lsp
    },
  {
    'hrsh7th/nvim-cmp',
     enabled = use_lsp
    },
  {
    'L3MON4D3/LuaSnip',
     enabled = use_lsp
    },
  {
    'williamboman/mason.nvim',
     enabled = use_lsp
    },
  {
    'williamboman/mason-lspconfig.nvim',
     enabled = use_lsp
  },
  -- Show autocompletion from the buffer.
  {
    'hrsh7th/cmp-buffer',
     enabled = use_lsp
  }
}

require("lazy").setup(plugins, {
  defaults = {
    version = '*',
  },
})

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
  function () builtin.buffers({sort_mru = true}) end, {}
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

-- Setup lsp using lsp-zero.
if use_lsp then
  require('mason').setup({})
  local lsp_zero = require('lsp-zero')
  lsp_zero.on_attach(function(_, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({
      buffer = bufnr,
      preserve_mappings = false,
    })

    -- Show lsp_definitions within telescope.
    vim.keymap.set(
      'n',
      'gd',
      function()
        builtin.lsp_definitions({
          initial_mode = 'normal',
          show_line = false,
        })
      end,
      { buffer = bufnr }
    )

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
  local cmp_format = lsp_zero.cmp_format({details = true})
  cmp.setup({
    -- The order of the sources determines their order in the completion results.
    sources = {
      {name = 'nvim_lsp'},
      {name = 'buffer'},
    },
    formatting = cmp_format,
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
    lspconfig.vtsls.setup({
      settings = {
        vtsls = {
          autoUseWorkspaceTsdk = true
        }
      }
    })
  end
end
