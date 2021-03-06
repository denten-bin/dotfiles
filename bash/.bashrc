# GENERAL SETTINGS

# If not running interactively, don't do anything
# [[ $- != *i* ]] && return
# [[ -z "$TMUX" ]] && exec tmux

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
# source ~/bin/completions/tmux.completion.bash
# source ~/bin/completions/ssh.completion.bash
# source ~/bin/completions/pip.completion.bash
# source ~/bin/completions/awscli.completion.bash

# enable compleition for marks
_completemarks() {
  local curw=${COMP_WORDS[COMP_CWORD]}
  local wordlist=$(find $MARKPATH -type l -printf "%f\n")
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}

complete -F _completemarks jump unmark

# enable completions for pandoc
eval "$(pandoc --bash-completion)"

# Enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Add my bin folder to PATH
export PATH="$HOME/bin/:/bin/senna/:$HOME/.local/bin/:$HOME/.gem/ruby/2.6.0/bin/: $PATH"

# Set Vim as default editor
export EDITOR="vim"

# prompt
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# the last line is handled by inputrc
# export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
export PS1="\[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] 
"

# colors
# Set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color) color_prompt=yes;;
esac

# Uncomment for a colored prompt, if the terminal has the capability
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# use ssh-add once per session
# supress the eval output
eval $(ssh-agent) >/dev/null


# http://henrik.nyh.se/2008/12/git-dirty-prompt
# http://www.simplisticcomplexity.com/2008/03/13/show-your-git-branch-name-in-your-prompt/
#   username@Machine ~/dev/dir[master]$   # clean working directory
#   username@Machine ~/dev/dir[master*]$  # dirty working directory

function parse_git_dirty {
  [[ -n "$(git status -s 2> /dev/null)" ]] && echo "*"
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ [\1$(parse_git_dirty)]/"
}

# special bindings

# this one auto expands !! with space for inspection
bind Space:magic-space

# scroll through menu with tab
bind 'set completion-ignore-case on'
bind 'TAB:menu-complete'
bind 'set menu-complete-display-prefix on'
bind 'set show-all-if-ambiguous on'

# Commands to be executed before the prompt is displayed

# Save current working dir
PROMPT_COMMAND='pwd > "${HOME}/.cwd"'

# Change to saved working dir
[[ -f "${HOME}/.cwd" ]] && cd "$(< ${HOME}/.cwd)"
