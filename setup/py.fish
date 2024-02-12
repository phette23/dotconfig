#!/usr/bin/env fish
# Python setup
# Use fish shell so we can modify its PATH with `fish_add_path` & not need to edit config.fish
# like the `pipx ensurepath` command does. We get asdf and pipx from homebrew, install python
# versions with asdf, then use pipx to install global python packages.
# https://justinmayer.com/posts/homebrew-python-is-not-for-you/
asdf install python latest:3.11
asdf install python latest:2.7
asdf global python latest:3.11 latest:2.7
asdf reshim python

if command --query pipx
    fish_add_path ~/.local/bin
    # invenio-cli?
    pipx install \
        csvkit \
        pipenv \
        poetry \
        unoconv

    if command --query register-python-argcomplete
        register-python-argcomplete --shell fish pipx > ~/.config/fish/completions/pipx.fish
    end
end

pip install --upgrade pip
