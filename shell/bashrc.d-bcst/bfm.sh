#### bfm
b() {
    tmux new-session -n BFM bfm $*

    LASTD="$HOME/.local/state/bfm.lastd"

    if [ -f "$LASTD" ]; then
        dir=$(cat "$LASTD")
        cd "$dir"
    fi
}
