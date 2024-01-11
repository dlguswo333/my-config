-- This is personally perferred vim settings file.

-- Turn on syntax highlighting.
vim.cmd("syntax on")

-- Show line numbers.
vim.cmd("set nu")

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
        highlight = { enable = true },
        indent = { enable = false },
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
}
require("lazy").setup(plugins, opts)
local builtin = require("telescope.builtin")
local utils = require("telescope.utils")

-- In normal mode, map Ctrl + p to searching for files only in cwd.
-- Allow hidden files (e.g. dotfiles) to appear but not certain files.
vim.keymap.set(
  "n",
  "<C-p>",
  function() builtin.find_files({
    hidden = true,
    -- '%' is an escape character in lua patterns.
    file_ignore_patterns={'node_modules', '%.git'}
  }) end,
  {}
)
-- In normal mode, map Ctrl + t to searching for a string in cwd.
vim.keymap.set(
  "n",
  "<C-t>",
  builtin.live_grep, {}
)

-- In normal mode, map <leader>f to searching for a string in the open files.
vim.keymap.set(
  "n",
  "<leader>f",
  function() builtin.live_grep({grep_open_files=true}) end, {}
)
