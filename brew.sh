#!/usr/bin/env bash

brew update

brew upgrade --all

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names
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
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen

brew install nmap
brew install ack
brew install git
brew install git-extras
brew install imagemagick --with-webp
brew install ssh-copy-id
brew install node
brew install npm
brew install openssl
brew install nginx
brew install postgresql
brew install python3
brew install mongodb
brew install redis
brew install memcached
brew install pgcli
brew install go
brew install gotags

# Remove outdated versions from the cellar.
brew cleanup
