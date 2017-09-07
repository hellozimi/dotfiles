for file in ~/.{aliases,extras,bash_prompt,exports,functions,path}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
    shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if which brew > /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
  source "$(brew --prefix)/share/bash-completion/bash_completion";
fi;

if [ -d "$(brew --prefix)/etc/bash_completion.d" ]; then
	 source <(cat $(brew --prefix)/etc/bash_completion.d/*)
fi

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# NVM
. "/usr/local/opt/nvm/nvm.sh"

