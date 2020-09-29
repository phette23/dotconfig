#!/usr/bin/env bash -x
if [ -d '~/Google Drive/z' ]; then
    mkdir ~/.ssh
    cp '~/Google Drive/z/ssh-config.txt' ~/.ssh/config
    
fi
