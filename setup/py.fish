#!/usr/bin/env fish
# Use fish shell so we can modify its PATH with `fish_add_path` & not need to edit config.fish
# like the `pipx ensurepath` command does. We get mise and pipx from homebrew, install python
# versions with mise, then use pipx to install global python packages.
# https://justinmayer.com/posts/homebrew-python-is-not-for-you/
if command --query mise
    mise install python@3.12
    mise install python@2.7
    mise global python@3.12 python@2.7
    mise reshim python
else
    echo "mise not found, run brew.sh first to install mise, then run this script again."
    exit 1
end

if command --query pipx
    fish_add_path ~/.local/bin
    # invenio-cli?
    pipx install \
        argcomplete \
        csvkit \
        pipenv \
        poetry \
        unoconv

    if command --query register-python-argcomplete
        register-python-argcomplete --shell fish pipx >~/.config/fish/completions/pipx.fish
    end
end

pip install --upgrade pip
