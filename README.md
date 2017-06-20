This repository contains my collection of configuration files for Arch. Use
[GNU `stow`][1] to manage.

[1]: https://www.gnu.org/software/stow/

My interfaces are built around *i3*, *zsh*, and *vim*. The environment ends up
looking something like this:

![screenshot](https://github.com/denten/.dotfiles/raw/master/layoutidea.png)

## Native Vim module loading using Git submodules

The following is quoted from:
<https://web.archive.org/web/20170620052953/https://shapeshed.com/vim-packages/>

### Adding a package

Here is an example of how to add a package using Vim’s native approach to
packages and git submodules.

```
cd ~/dotfiles
git submodule init
git submodule add https://github.com/vim-airline/vim-airline.git vim/pack/shapeshed/start/vim-airline
git add .gitmodules vim/pack/shapeshed/start/vim-airline
git commit
```

### Updating packages

To update packages is also just a case of updating git submodules.

```
git submodule update --remote --merge
git commit
```

### Removing a package

Removing a package is just a case of removing the git submodule.

```
git submodule deinit vim/pack/shapeshed/start/vim-airline
git rm vim/pack/shapeshed/start/vim-airline
rm -Rf .git/modules/vim/pack/shapeshed/start/vim-airline
git commit
```
