" This is personally perferred neovim config file.

" Turn on syntax highlighting.
syntax on

" Show line numbers.
set nu

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
colorschem shine

" Remember last position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
