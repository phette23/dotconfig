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
brew tap josegonzalez/homebrew-php

# Install other useful packages
brew install ack \
	archey \
	bash \
	bash-completion \
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
	homebrew/dupes/grep \
	imagemagick \
	node \
	nvm \
	optipng \
	pandoc \
	phantomjs \
	php55 \
	pngcrush \
	python3 \
	ruby-build \
	"source-highlight" \
	tree \
	vim \
	webkit2png \
	xquartz \
	z

# unreleased rbenv version supports Fish shell
brew install rbenv --HEAD

# Install wget with IRI support
brew install wget --enable-iri

# Remove outdated versions from the cellar
brew cleanup
