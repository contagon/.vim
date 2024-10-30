# editor
export ZDOTDIR="$HOME/.zsh"
export EDITOR="nvim"
export VISUAL="nvim"

# nvim manager
export PATH="$PATH:$HOME/.local/share/bob/nvim-bin"
# cargo 
. "$HOME/.cargo/env"
# nvm (https://github.com/nvm-sh/nvm?tab=readme-ov-file#install--update-script)
. "$HOME/.nvm/nvm.sh"  # This loads nvm

# zsh
export HISTFILE=$HOME/.zhistory    # History filepath
export HISTSIZE=10000              # Maximum events for internal history
export SAVEHIST=10000              # Maximum events in history file

# for autocomplete
skip_global_compinit=1
