#!/usr/bin/env bash
if [ ! $(command -v brew) ]; then
  echo "You need to install homebrew first, dummy."
  exit 1;
fi

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

echo "Don’t forget to add $(brew --prefix coreutils)/libexec/gnubin to \$PATH."

# tap necessary formulas
brew tap homebrew/dupes
brew tap josegonzalez/homebrew-php

# Install other useful packages
brew install ack \
	bash \
	bash-completion \
	chromedriver \
	cloc \
	coreutils \
	drush \
	exiftool \
	findutils \
	ghostscript --with-x11 \
	git \
	gnupg \
	homebrew/dupes/grep \
	imagemagick \
	jshon \
	lynx \
	ngrep \
	node \
	optipng \
	phantomjs \
	php55 \
	pngcrush \
	python3 \
	rbenv \
	ruby-build \
	"source-highlight" \
	tree \
	webkit2png \
	z

# Install wget with IRI support
brew install wget --enable-iri

# Remove outdated versions from the cellar
brew cleanup
