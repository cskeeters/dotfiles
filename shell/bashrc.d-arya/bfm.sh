#### bfm
b() {
    if [[ -n "$TMUX" ]]; then
        bfm $*
    else
        tmux new-session -n BFM bfm $*
    fi

    LASTD="$HOME/.local/state/bfm.lastd"

    if [ -f "$LASTD" ]; then
        dir=$(cat "$LASTD")
        cd "$dir"
    fi
}
