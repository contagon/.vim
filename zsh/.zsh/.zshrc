# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Aliases
alias c='clear'
alias ca='conda activate'
alias ma='mamba activate'
alias mi='mamba install'
alias open='xdg-open'

# Completions
# autoload -U compinit; compinit
# _comp_options+=(globdots) # With hidden files
# source $HOME/.zsh/completion.zsh
# # more completions
# fpath=($HOME/.zsh/zsh-completions/src $fpath)

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

# Load antidote
source ${ZDOTDIR}/antidote/antidote.zsh
antidote load

# To customize prompt, run `p10k configure` or edit ~/.zsh/.p10k.zsh.
[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh

# To customize prompt, run `p10k configure` or edit ~/dotfiles/zsh/.zsh/.p10k.zsh.
[[ ! -f ~/dotfiles/zsh/.zsh/.p10k.zsh ]] || source ~/dotfiles/zsh/.zsh/.p10k.zsh
