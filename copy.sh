#!/usr/bin/env bash
mkdir -p ~/bin
cp -vr bin/* ~/bin
cp -vr config/. ~
mkdir ~/.config && mv ~/emmet ~/.config
cp -vr .vim/. ~/.vim
cp -vr .pip/. ~/.pip

