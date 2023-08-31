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

# enable fasd
fasd_cache="$HOME/.fasd-init-bash"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

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
# export PATH="$HOME/.local/bin/:$HOME/.rbenv/bin:$PATH"
# export PATH="$HOME/.local/bin/:"

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

echo "fzf: CTRL-t and CTRL-r"

## History Settings

HISTCONTROL=ignoredups:erasedups     # no duplicate entries
HISTSIZE=100000                      # big big history
HISTFILESIZE=100000                  # big big history
shopt -s histappend                  # append to history, don't overwrite it
shopt -s cmdhist                     # save multi-line as one command
HISTTIMEFORMAT='%F %T '              # Set history timestamp format
PROMPT_COMMAND='history -a'          # record right away instead of eo session

# Commands that don't need to get recorded
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:cd:exa:jump"

## Ruby, Node, Python, ETC

# Install Ruby Gems to ~/gems

# eval "$(rbenv init -)"

export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/home/denten/.local/share/.gem/ruby/3.0.0/bin:$PATH"
