#!/usr/bin/env bash -x
if [ ! $(command -v brew) ]; then
  echo 'Installing Homebrew to /usr/local...'
  cd /usr/local
  mkdir homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
fi

# Make sure we’re using the latest Homebrew
brew update

# Install other useful packages
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
    # NOTE: we uninstall this after using it to get N & using N to get node stable
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
