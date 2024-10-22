# editor
export ZDOTDIR="$HOME/.zsh"
export EDITOR="nvim"
export VISUAL="nvim"
export PATH="$PATH:$HOME/.local/share/bob/nvim-bin"
. "$HOME/.cargo/env"

# zsh
export HISTFILE=$HOME/.zhistory    # History filepath
export HISTSIZE=10000              # Maximum events for internal history
export SAVEHIST=10000              # Maximum events in history file

# for autocomplete
skip_global_compinit=1