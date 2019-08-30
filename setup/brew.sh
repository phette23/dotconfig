#!/usr/bin/env bash -x
if [ ! $(command -v brew) ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew
brew update

# Install other useful packages
# NOTE: we will uninstall node in npm.sh after using it to get N (my preferred 
# node version manager) and then using N to get node stable
brew install ack \
    archey \
    bash \
    coreutils \
    exiftool \
    exa \
    findutils \
    git \
    gnu-sed \
    grep \
    hub \
    jq \
    moreutils \
    node \
    python \
    python3 \
    rbenv \
    ruby-build \
    sassc \
    "source-highlight" \
    tree \
    vim \
    wget \
    z

# We got Bash? Add to /etc/shells & use updated Bash
echo '/usr/local/bin/bash' | sudo tee -a /etc/shells
chsh -s /usr/local/bin/bash
