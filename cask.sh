#!/usr/bin/env bash

brew update
brew upgrade --all

# Be sure cask is tapped'
brew cask

brew cask install iterm2
brew cask install alfred
brew cask install macvim

