# vi:syntax=sh

# Source .bashrc as recommended here:
# http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

if [ -f ~/.profile ]; then
   source ~/.profile
fi

case $- in *i*) . ~/.bashrc;; esac

# must include this to startx on login
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec startx
fi
