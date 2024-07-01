#!/usr/bin/env fish

if command --query mise
    mise install ruby@latest
else
    echo "mise not found, run brew.sh first to install mise, then run this script again."
    exit 1
end

gem install \
    bundler
