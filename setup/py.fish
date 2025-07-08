#!/usr/bin/env fish
# Use fish shell so we can modify its PATH with `fish_add_path` & without editing config.fish.
# We get mise & uv from homebrew, install python versions with mise, then use uv to install
# global python tools. https://justinmayer.com/posts/homebrew-python-is-not-for-you/
if command --query mise
    mise install python@2.7
    mise install python@3.12
    mise global python@3.12 python@2.7
    mise reshim python
else
    echo "mise not found, run brew.sh first to install mise, then run this script again."
    exit 1
end

if command --query uv
    fish_add_path ~/.local/bin
    uv tool install \
        csvkit \
        invenio-cli \
        poetry \
        unoconv
    # bagit relies on deprecated pkg_resources which is in setuptools
    uv tool install bagit --with setuptools
end
