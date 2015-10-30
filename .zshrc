#################################
# run `source ~/.zshrc` to reload
#################################

# Path to your oh-my-zsh configuration.
ZSH=$HOME/oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="gallois"
# ZSH_THEME="bira"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git jump common-aliases last-working-dir pip)

source $ZSH/oh-my-zsh.sh
# source ~/.aws-osp-keys

# --- Paths ---
export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:$HOME/.cabal/bin:/home/denten/.node/bin
export OSP_WHEELHOUSE=/home/denten/gDrive/code/osp/osp-wheelhouse.tar.gz

# The links directory contains symbolic links to deep folders
CDPATH=~/Links:.
export CDPATH

# --- Vim it up ---
export EDITOR='vim'
bindkey -v

# History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# --- Aliases ---
alias ls='ls --color -F'
alias la='ls --color -a'
alias ll='ls --color -la'
alias feh='feh --auto-zoom --sort filename'
alias python=python3

# Metafont to mv common mistype
alias mf='mv'

# --- Custom Key Binds ---
bindkey '^R' history-incremental-search-backward

# --- Completions ---
# source ~/.bin/tmuxinator.zsh
source ~/.fzf.zsh

# --- Hacks and fixes

# fix the "grep_options is depricated please use an alias or script" error
# alias grep="/usr/bin/grep $GREP_OPTIONS"
# unset GREP_OPTIONS
