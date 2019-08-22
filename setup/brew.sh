#!/usr/bin/env bash -x
if [ ! $(command -v brew) ]; then
  echo 'You need to install homebrew first, silly!'
  open "http://brew.sh"
  exit 1
fi

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Install other useful packages
brew install ack \
	archey \
	bash \
	coreutils \
	exiftool \
	findutils \
	git \
	gnu-sed \
	grep \
	jq \
	moreutils \
	perl-build \
	phantomjs \
	plenv \
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

# Remove outdated versions from the cellar
brew cleanup

# We got Bash? Add to /etc/shells & use updated Bash
echo '/usr/local/bin/bash' | sudo tee -a /etc/shells
chsh -s /usr/local/bin/bash
