# editor
export ZDOTDIR="$HOME/.zsh"
export EDITOR="nvim"
export VISUAL="nvim"

# nvim manager
export PATH="$PATH:$HOME/.local/share/bob/nvim-bin"
# cargo 
. "$HOME/.cargo/env"
# nvm (https://github.com/nvm-sh/nvm?tab=readme-ov-file#install--update-script)
# this can be slow, so disabled since we don't use it often
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# zsh
export HISTFILE=$HOME/.zhistory    # History filepath
export HISTSIZE=10000              # Maximum events for internal history
export SAVEHIST=10000              # Maximum events in history file

# for autocomplete
skip_global_compinit=1
