#!/usr/bin/env bash -x
mkdir -p ~/.ssh
# TODO correct path to Drive
if [[ -d '~/Google Drive/z' ]]; then
    cp '~/Google Drive/z/ssh-config.txt' ~/.ssh/config
fi
cd ~/.ssh
echo "Generating an SSH key, name it 'id' if you want it to work with existing ssh config"
ssh-keygen -t ed25519 -C "phette23@gmail.com"
# correct permissions for gpg
[ -d "~/.gnupg" ] && chmod 700 ~/.gnupg
if [ -d "~/SpiderOak Hive"]; then
    echo "Importing GPG key from SpiderOak, this will require its passphrase"
    gpg --import-options restore --import "~/SpiderOak Hive/phette23.gpg"
fi
