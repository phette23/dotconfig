# .config

The shell-agnostic pieces of my dotfiles, consisting of configuration files for various programs, executables, & setup scripts for installing software on new machines.

## Structure

**config** is for all configuration files. The files in here are synced directly into `$HOME`. **bin** is for my own executables.

**setup** is for one-time setup scripts for new computers, mostly lists of packages to install from various package managers. osx.sh sets up a new Mac. These files are not synced anywhere.

The "copy.sh" script syncs all the configuration files into your home directory.

## Setup Notes/Order

(See also my [new mac](https://gist.github.com/phette23/735f2816b261cb7592be4bd36e24d987) gist) On a new Mac, this is the general order of things:

1. `xcode-select --install` to make `git` work
1. `mkdir ~/Code && cd ~/Code && git clone https://github.com/phette23/dotconfig.git && cd dotconfig && ./copy.sh`
1. `./setup/brew.sh` must come before npm.sh, makes sense to run before py & ruby
1. `./setup/cask.sh`
1. `./setup/npm.sh`
1. `./setup/py.sh`
1. `./setup/ruby.sh`
1. `./setup/osx.sh` makes sense to run last, but mostly important to do after `brew cask` has installed apps like Chrome that will have their settings changed
