# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/simon/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/simon/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/simon/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/simon/.fzf/shell/key-bindings.zsh"
