# .config

The shell-agnostic pieces of my dotfiles, consisting of configuration files for various programs, executables, & setup scripts for installing software on new machines.

This project breaks off of [my previous dotfiles](https://github.com/phette23/my-dotfiles/) repo which was bash-specific.

## Structure

**bin** is for executables, it is synced to `$HOME/bin`.

**config** is for configuration files. If you're looking for a file that ends in "rc", it's probably in here. The files in here are synced directly into `$HOME`.

**setup** is for one-time setup scripts for new computers, mostly lists of packages to install from various package managers. These files are not synced anywhere.

The included "copy.sh" script copies all the configuration files (not the setup scripts) into your home directory.

## Setup Notes/Order

(See also my [new mac](https://gist.github.com/phette23/735f2816b261cb7592be4bd36e24d987) gist) On a new Mac, this is the general order of things:

1. `git` won't even work at first without XCode, so open App Store & spend an hour installing it
1. `git clone https://github.com/phette23/bashrc.git && cd bashrc && ./copy.sh`
1. `setup/brew.sh` must come before npm.sh, makes sense to run before py & ruby
1. `setup/cask.sh`
1. `setup/npm.sh`
1. `setup/py.sh`
1. `setup/ruby.sh`
1. `setup/osx.sh` makes sense to run last, but mostly important to do after `brew cask` has installed apps like Chrome that will have their settings changed
