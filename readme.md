# .config

The shell-agnostic pieces of my dotfiles, consisting of configuration files for various programs, executables, & setup scripts for installing software on new machines.

This project breaks off of [my previous dotfiles](https://github.com/phette23/my-dotfiles/) repo which was bash-specific.

## Structure

**bin** is for executables, it is synced to `$HOME/bin`.

**config** is for configuration files. If you're looking for a file that ends in "rc", it's probably in here. The files in here are synced directly into `$HOME`.

**setup** is for one-time setup scripts for new computers, mostly lists of packages to install from various package managers. These files are not synced anywhere.

## Grunt Tasks

If you have Node & Grunt installed, you can run `npm i` inside this project to get started.

**`grunt copy`** (also the default `grunt`) moves the files into place.

**`grunt watch`** monitors config/ & bin/ for changes & then runs `copy`.
