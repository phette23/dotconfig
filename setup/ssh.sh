#!/usr/bin/env bash
set -x
mkdir -p ~/.ssh
zpath="$HOME/phette23@gmail.com - Google Drive/My Drive/z"
if [[ -d "$zpath" ]]; then
    cp "$zpath/ssh-config.txt" ~/.ssh/config
fi
# shellcheck disable=SC2164
cd ~/.ssh
echo "Generating an SSH key, name it 'id' if you want it to work with existing ssh config"
ssh-keygen -t ed25519 -C "phette23@gmail.com"
# correct permissions for gpg
[[ -d "$HOME/.gnupg" ]] && chmod 700 ~/.gnupg
if [[ -d "$HOME/SpiderOak Hive" ]]; then
    echo "Importing GPG key from SpiderOak, this will require its passphrase"
    gpg --import-options restore --import "$HOME/SpiderOak Hive/phette23.gpg"
fi
