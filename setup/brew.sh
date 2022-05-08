#!/usr/bin/env bash -x
if [ ! $(command -v brew) ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew
brew update

# Install other useful packages
# NOTE: we will uninstall node in npm.sh after using it to get N (my preferred
# node version manager) and then using N to get node stable
# gpm seems to be an unstated requirement for vim (via ruby)
brew install ack \
    bash \
    bat \
    coreutils \
    difftastic \
    duf \
    dust \
    exiftool \
    exa \
    fd \
    findutils \
    fish \
    gh \
    git \
    gnu-sed \
    gpg-suite-no-mail \
    gpm \
    grep \
    htop \
    jc \
    jq \
    marcli \
    miller \
    moreutils \
    ncdu \
    neofetch \
    node \
    pandoc \
    pipenv \
    pyenv \
    rbenv \
    sassc \
    tealdeer \
    todo-txt \
    tree \
    vim \
    wget \
    z

# Add homebrew bash & fish to /etc/shells & use fish
grep '/usr/local/bin/bash' /etc/shells >/dev/null || echo '/usr/local/bin/bash' | sudo tee -a /etc/shells
grep '/usr/local/bin/fish' /etc/shells >/dev/null || echo '/usr/local/bin/fish' | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish
