export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

alias python="python3"
# -G Do not print group.
# -F Print classifiers; * for executables, / for directories.
alias ls="ls -GF --color"
# -a Get all including entries starting with '.'.
# -l Use long listing format
# -h Human readable size format
alias ll="ls -alhF --color"
# nvim alias.
alias nvi=nvim

# Configure for WSL.
if uname -r | grep -iq WSL; then
  PATH=$PATH:/mnt/c/Windows/
  alias code="/mnt/c/Users/LHJ/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code"
  explorer="/mnt/c/Windows/explorer.exe"
  alias explorer=$explorer
  export BROWSER=$explorer
fi

# Add home and end Key Bindings for some distro not having default mapping (e.g. Fedora)
# https://blog.bullspit.co.uk/linux/zsh-home-end/
if [[ $(bindkey) != *'^[OH'* ]]; then
  bindkey '^[OH' beginning-of-line
  bindkey '^[OF' end-of-line
fi
if [[ $(bindkey) != *'^[[H'* ]]; then
  bindkey '^[[H' beginning-of-line
  bindkey '^[[F' end-of-line
fi

# Enable auto correction
setopt correct

# Skip duplicated command lines in history.
setopt histignoredups

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Enable tab completion arrow key navigation
zstyle ':completion:*' menu select=5

# Highlight the current autocomplete option
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Allow for autocomplete to be case insensitive
zstyle ':completion:*' matcher-list '' '+m:{a-zA-Z}={A-Za-z}' '+r:|[._-]=* r:|=*' '+l:|=*'

# Initialize the autocompletion
autoload -Uz compinit && compinit

# Better SSH/Rsync/SCP Autocomplete
zstyle ':completion:*:(scp|rsync):*' tag-order ' hosts:-ipaddr:ip\ address hosts:-host:host files'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'
