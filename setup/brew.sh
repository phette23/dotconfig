#!/usr/bin/env bash -x
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

# Install other useful packages
# NOTE: we will uninstall node in npm.sh after using it to get N (my preferred
# node version manager) and then using N to get node stable
# gpm seems to be an unstated requirement for vim (via ruby)
brew install \
    ack \
    asdf \
    bash \
    bat \
    cloc \
    coreutils \
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
    gpm \
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
    ncdu \
    neofetch \
    node \
    pandoc \
    pipx \
    postgresql \
    rsync \
    sassc \
    shellcheck \
    skaffold \
    tealdeer \
    todo-txt \
    tree \
    uchardet \
    vim \
    wget \
    xmlstarlet \
    zoxide

brew tap homebrew/aliases && {
    brew alias cmd=commands
    brew alias i=install
}

# asdf plugins
if [ command -v asdf >/dev/null ]; then
    asdf plugin add nodejs
    asdf plugin add python
    asdf plugin add ruby
fi

# Add homebrew bash & fish to /etc/shells & use fish
echo 'Ading homebrew bash and fish to /etc/shells, requires sudo'
PREFIX=$(brew --prefix)
grep "$PREFIX/bin/bash" /etc/shells >/dev/null || echo "$PREFIX/bin/bash" | sudo tee -a /etc/shells
grep "$PREFIX/bin/fish" /etc/shells >/dev/null || echo "$PREFIX/bin/fish" | sudo tee -a /etc/shells
chsh -s "$PREFIX/bin/fish"
