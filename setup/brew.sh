#!/usr/bin/env bash
if [ ! $(command -v brew) ]; then
  echo 'You need to install homebrew first, silly!'
  open "http://brew.sh"
  exit 1
fi

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# tap necessary formulas
brew tap homebrew/dupes
brew tap homebrew/homebrew-versions
brew tap homebrew/completions

# Install other useful packages
brew install ack \
	archey \
	bash \
	chromedriver \
	cloc \
	coreutils \
	drush \
	exiftool \
	findutils \
	fish \
	ghostscript --with-x11 \
	git \
	gnupg \
	gnu-sed \
	homebrew/dupes/grep \
	imagemagick \
	jq \
	moreutils \
	nvm \
	pandoc \
    perl-build \
	phantomjs \
	php55 \
    plenv \
	python \
	python3 \
	ruby-build \
	"source-highlight" \
	tree \
	vim \
	z

# unreleased rbenv version supports Fish shell
brew install rbenv --HEAD

# Install wget with IRI support
brew install wget --enable-iri

# Remove outdated versions from the cellar
brew cleanup

# We got Bash & Fish? Add them to /etc/shells & use updated Bash
echo '/usr/local/bin/bash' | sudo tee -a /etc/shells
echo '/usr/local/bin/fish' | sudo tee -a /etc/shells
chsh -s /usr/local/bin/bash

# Get a current ruby
rbenv install 2.3.1
# and a current node
nvm install stable
# add a current perl here, too?
