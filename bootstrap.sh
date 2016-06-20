#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function install_fonts() {
    POWERLINE_GIT="https://github.com/powerline/fonts"
    git clone $POWERLINE_GIT powerline-fonts
    sh ./powerline-fonts/install.sh
    rm -rf powerline-fonts
}

function run_it() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
        --exclude ".gitignore" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		-avh --no-perms . ~;
	source ~/.bash_profile;
    install_fonts;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	run_it;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		run_it;
	fi;
fi;
unset run_it;
unset install_fonts;
