# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
#################################
# run `source ~/.zshrc` to reload
#################################

# Path to your oh-my-zsh configuration.
# ZSH=$HOME/.oh-my-zsh
export TERM="xterm-256color"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# --- Paths ---
export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:$HOME/.cabal/bin:/home/denten/.node/bin

# The links directory contains symbolic links to deep folders
CDPATH=~/Links:.
export CDPATH

# necessary to make ssh-add work
# use keychain instead
eval $(ssh-agent)

# --- Vim it up ---
export EDITOR='vim'
bindkey -v

# History
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

# --- Aliases ---
alias ls='ls --color -F'
alias la='ls --color -a'
alias ll='ls --color -la'
alias feh='feh --auto-zoom --sort filename'
alias python=python3

# Metafont to mv common mistype
alias mf='mv'

# --- Completions ---
# source ~/.bin/tmuxinator.zsh
# source ~/.fzf.zsh

# --- Hacks and fixes

# fix the "grep_options is depricated please use an alias or script" error
# alias grep="/usr/bin/grep $GREP_OPTIONS"
# unset GREP_OPTIONS

# change cursor shape in VI mode
zle-keymap-select () {
if [ $KEYMAP = vicmd ]; then
    printf "\033[2 q"
else
    printf "\033[6 q"
fi
}
zle -N zle-keymap-select
zle-line-init () {
zle -K viins
printf "\033[6 q"
}
zle -N zle-line-init
bindkey -v
