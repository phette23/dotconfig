#!/usr/bin/env bash
set -x
if [ ! "$(command -v brew)" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# if Apple M1 homebrew dir is not on path, add it
HDIR="/opt/homebrew/bin"
if [ -d $HDIR ] && [[ ":$PATH:" != *":$HDIR:"* ]]; then
    PATH="$HDIR${PATH:+":$PATH"}"
fi

# add my personal taproom
brew tap phette23/local

# Make sure we’re using the latest Homebrew
brew update

# NOTE: we install programming language versions via `mise` & not brew
brew install \
    bash \
    bat \
    cloc \
    coreutils \
    curl \
    difftastic \
    duf \
    dust \
    exiftool \
    eza \
    fd \
    findutils \
    fish \
    fzf \
    gh \
    git \
    glab \
    glow \
    gnu-sed \
    gpg-suite-no-mail \
    grep \
    helm \
    htop \
    imagemagick \
    jc \
    jq \
    marcli \
    miller \
    minikube \
    moreutils \
    mise \
    ncdu \
    pandoc \
    postgresql \
    rsync \
    sassc \
    shellcheck \
    skaffold \
    tealdeer \
    todo-txt \
    tree \
    uchardet \
    uv \
    vim \
    wget \
    xmlstarlet \
    zoxide

brew tap homebrew/aliases && {
    brew alias cmd=commands
    brew alias i=install
}

# Add homebrew bash & fish to /etc/shells & use fish
echo 'Ading homebrew bash and fish to /etc/shells, requires sudo'
PREFIX=$(brew --prefix)
grep "$PREFIX/bin/bash" /etc/shells >/dev/null || echo "$PREFIX/bin/bash" | sudo tee -a /etc/shells
grep "$PREFIX/bin/fish" /etc/shells >/dev/null || echo "$PREFIX/bin/fish" | sudo tee -a /etc/shells
chsh -s "$PREFIX/bin/fish"
