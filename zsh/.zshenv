# editor
export ZDOTDIR="$HOME/.zsh"
export EDITOR="vim"
export VISUAL="vim"
. "$HOME/.cargo/env"

# zsh
export HISTFILE=$HOME/.zhistory    # History filepath
export HISTSIZE=10000              # Maximum events for internal history
export SAVEHIST=10000              # Maximum events in history file

# for autocomplete
skip_global_compinit=1