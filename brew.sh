#!/usr/bin/env bash

brew update

brew upgrade --all

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before
# running `chsh`.
brew install bash
brew tap homebrew/versions
brew install bash-completion2

if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
    echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
    chsh -s /usr/local/bin/bash;
fi;

brew install wget --with-iri

brew install vim --override-system-vi

brew install imagemagick --with-webp
brew install node
brew install npm
brew install openssl
brew install pgcli
brew install go

# Remove outdated versions from the cellar.
brew cleanup
