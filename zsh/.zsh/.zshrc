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
autoload -U compinit; compinit
_comp_options+=(globdots) # With hidden files
# source $HOME/.zsh/completion.zsh
# # more completions
# fpath=($HOME/.zsh/zsh-completions/src $fpath)
# TODO: tldr completions
# https://github.com/tldr-pages/tlrc/blob/main/completions/_tldr

# Load antidote & plugins
source ${ZDOTDIR}/antidote/antidote.zsh
antidote load

# fzf keybindings
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi
source /usr/share/doc/fzf/examples/completion.zsh
source /usr/share/doc/fzf/examples/key-bindings.zsh

# ----------------- Replacement for standard tools ----------------- #
# ls -> eza aliases
# https://gist.github.com/AppleBoiy/04a249b6f64fd0fe1744aff759a0563b
# TODO: https://denisrasulev.medium.com/eza-the-best-ls-command-replacement-9621252323e
alias ls='eza'
alias l='eza -lbF --git'
alias ll='eza -lbGF --git'
alias llm='eza -lbGd --git --sort=modified'
alias la='eza -lbhHigUmuSa --time-style=long-iso --git --color-scale'
alias lx='eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale'
# specialty views
alias lS='eza -1'
alias lt='eza --tree --level=2'
alias l.="eza -a | grep -E '^\.'"

# cd -> zoxide
eval "$(zoxide init zsh)"
alias cd="z"
alias cdi="zi"

# man -> tldr
# No alias

# cat -> bat
export BAT_THEME="base16"
export BAT_STYLE="numbers,changes,header"
alias cat="bat"
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'


# To customize prompt, run `p10k configure` or edit ~/.zsh/.p10k.zsh.
[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh