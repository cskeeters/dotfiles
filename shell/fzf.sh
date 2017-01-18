#set FZF_HOME to the detected home of fzf
for dir in /usr/share /usr/local/opt; do
    [[ -d $dir/fzf ]] && FZF_HOME="$dir/fzf"
done

shell=$(basename $SHELL)

# Disable fzf-tmux
hash tmux 2>/dev/null || export FZF_TMUX=0

if [[ $TERM =~ konsole.* ]]; then
    export FZF_DEFAULT_OPTS='--color fg+:5,hl+:6'
fi

# Setup fzf
# ---------
if [[ ! "$PATH" == *$FZF_HOME/bin* ]]; then
  export PATH="$PATH:$FZF_HOME/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" == *$FZF_HOME/man* && -d "$FZF_HOME/man" ]]; then
  export MANPATH="$MANPATH:$FZF_HOME/man"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$FZF_HOME/shell/completion.$shell" 2> /dev/null

# Key bindings
# ------------
source "$FZF_HOME/shell/key-bindings.$shell"
