#!/usr/bin/env fish
mkdir -p ~/.ssh
ZPATH="$HOME/phette23@gmail.com - Google Drive/My Drive/z"
if test -d "$ZPATH"
    cp "$ZPATH/ssh-config.txt" ~/.ssh/config
    # Configure 1Password SSH agent, but only if we copied our SSH config
    set -Ux SSH_AUTH_SOCK ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
    set_color --bold red
    echo "Don't forget to start the 1Password SSH agent under 1Password > Settings > Developer > SSH Agent"
    set_color normal
end
# shellcheck disable=SC2164
cd ~/.ssh
# correct permissions for gpg
if test -d "$HOME/.gnupg"
    chmod 700 ~/.gnupg
end
# see GPG key password
if test -f "$ZPATH/phette23.gpg"
    gpg --import-options restore --import "$ZPATH/phette23.gpg"
end
