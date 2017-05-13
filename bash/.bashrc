# GENERAL SETTINGS

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Alias definitions
if [ -f ~/.aliases ]; then
  . ~/.aliases
fi

# mix in the jump capability
if [ -f ~/.jump ]; then
  . ~/.jump
fi

# set vi mode
set -o vi

# start tmux on startup
 if command -v tmux>/dev/null; then
     [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
 fi

# Don't put duplicate lines or lines starting with space in the history
HISTCONTROL="erasedups:ignoreboth"

# Commands that don't need to get recorded
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history"

# Save multi-line commands to the history as one command
shopt -s cmdhist

# Append to the history file, don't overwrite it
shopt -s histappend

# Set history size to a very large number
HISTSIZE=500000
HISTFILESIZE=100000

# Record each line of history right away
# instead of at the end of the session
PROMPT_COMMAND='history -a'

# Set history timestamp format
HISTTIMEFORMAT='%F %T '

# Activate and define cdable variables
shopt -s cdable_vars
export dotfiles="$HOME/dotfiles"

# Define search path for the cd command
CDPATH=".:~/repos"

# Implicit cd
shopt -s autocd

# Correct minor errors in the spelling of a directory
shopt -s cdspell
shopt -s dirspell

# Git custom prompt
# export GITAWAREPROMPT=~/bin/git-aware-prompt
# source "${GITAWAREPROMPT}/main.sh"
# export PS1="\[\033[33;1m\]\W\[\033[m\]\[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]$ "

# Complete all the things
# source ~/bin/completions/git-completion.bash
# source ~/bin/completions/tmux.completion.bash
# source ~/bin/completions/tmuxinator.bash
# source ~/bin/completions/pandoc.bash

# Add my bin folder to PATH
export PATH="$HOME/bin:$PATH"

# Set Vim as default editor
export EDITOR="vim"
