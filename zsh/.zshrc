# Aliases
alias c='clear'
alias ca='conda activate'
alias ma='mamba activate'
alias mi='mamba install'
alias open='xdg-open'

# Completions
autoload -U compinit; compinit
_comp_options+=(globdots) # With hidden files
source $HOME/.zsh/completion.zsh
# more completions
fpath=($HOME/.zsh/zsh-completions/src $fpath)

# prompt
# TODO: Powerlevel10k
# TODO: antidote

# Directory stack
setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# Vim mode
# bindkey -v
# export KEYTIMEOUT=1

# easy directory jumping
# zoxide a better option?? 
# source $HOME/.zsh/bd.zsh
