# editor
export ZDOTDIR="$HOME/.zsh"
export EDITOR="vim"
export VISUAL="vim"
. "$HOME/.cargo/env"

# zsh
export HISTFILE=$HOME/.zhistory    # History filepath
export HISTSIZE=10000              # Maximum events for internal history
export SAVEHIST=10000              # Maximum events in history file

# fzf
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi
source /usr/share/doc/fzf/examples/key-bindings.zsh
