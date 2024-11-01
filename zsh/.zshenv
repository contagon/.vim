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
. $HOME/.nix-profile/etc/profile.d/nix.sh
export PATH="$HOME/.pixi/bin:$PATH"

export VCPKG_ROOT=~/.vcpkg
export PATH=$VCPKG_ROOT:$PATH

export CMAKE_COLOR_DIAGNOSTICS=ON
export CMAKE_GENERATOR="Ninja"

# zsh
export HISTFILE=$HOME/.zhistory    # History filepath
export HISTSIZE=10000              # Maximum events for internal history
export SAVEHIST=10000              # Maximum events in history file

# for autocomplete
skip_global_compinit=1
