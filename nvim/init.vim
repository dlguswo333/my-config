" This is personally perferred neovim config file.

" Turn on syntax highlighting.
syntax on

" Show line numbers.
set nu

" Highlight the current cursor line.
set cursorline

" Show current cursor position.
set ruler

" tab size is 4 spaces.
set shiftwidth=4

" Use spaces instead of a tab.
set expandtab

" Insert or deletes spaces instead of a tab at the start of line.
set smarttab

" C style indent.
set cindent

" Support mouse.
set mouse=a

" Highlight search patterns.
set hlsearch

" Show available auto completion words in command mode.
set wildmenu

" Enable case insensitive search only if keyword not having capitals.
set ignorecase
set smartcase

" Set colorscheme
colorscheme shine

" Automatically reload on file changes.
set autoread

" Remember last position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

command CopyCurrentBufferPath let @+=@% | echo "Copied to clipboard: " . @%

" Set leader key
let mapleader = ' '

noremap <c-w>+ :resize <bar> :vertical resize <cr>
noremap <leader>bd :bn <bar> :bd# <cr>
