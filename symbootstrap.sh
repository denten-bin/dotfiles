#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
# Forked from https://github.com/michaeljsmalley/dotfiles
# At this time, you must list the files manually

########## Variables

dir=~/.dotfiles                    # dotfiles directory
olddir=~/.dotfiles_old             # old dotfiles backup directory
files=".gitignore .gitmodules .i3 .screenlayout .vim .vimrc .Xmodemap .zshrc"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
# from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/$file ~/.dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/$file
done

# update submodules
echo -n "Changing to the $dir directory and attempting to update submodules..."
cd $dir
git submodule update --init
echo "done"

install_zsh () {
# Test to see if zshell is installed.  If it is:
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    # Clone my oh-my-zsh repository from GitHub only if it isn't already present
    if [[ ! -d $dir/oh-my-zsh/ ]]; then
        git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh  
    fi
    # Set the default shell to zsh if it isn't currently set to zsh
    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
        chsh -s $(which zsh)
    fi
# else
     # If zsh isn't installed, get the platform of the current machine
     platform=$(uname);
     # If the platform is Linux, try an apt-get to install zsh and then recurse
     if [[ $platform == 'Linux' ]]; then
         sudo apt-get install zsh
        install_zsh
     fi
fi
}

install_zsh
