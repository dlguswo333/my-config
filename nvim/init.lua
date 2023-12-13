-- This is personally perferred vim settings file.

-- Turn on syntax highlighting.
vim.cmd("syntax on")

-- Show line numbers.
vim.cmd("set nu")

-- Show current cursor position.
vim.cmd("set ruler")

-- tab size is 4 spaces.
vim.cmd("set shiftwidth=4")

-- Insert or deletes spaces instead of a tab.
vim.cmd("set smarttab")

-- C style indent.
vim.cmd("set cindent")

-- Support mouse.
vim.cmd("set mouse=a")

-- Highlight search patterns.
vim.cmd("set hlsearch")

-- Show available auto completion words in command mode.
vim.cmd("set wildmenu")

-- Set colorscheme
vim.cmd("colorschem zellner")

vim.cmd([[
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
]])

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
  -- Find files easily.
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' }
  }
}
require("lazy").setup(plugins, opts)
local builtin = require("telescope.builtin")
local utils = require("telescope.utils")
vim.keymap.set(
  -- Normal mode.
  "n",
  -- Ctrl + p, just like vscode.
  "<C-p>",
  -- Search for files only in cwd.
  function() builtin.find_files({cwd = utils.buffer_dir()}) end, {}
)
