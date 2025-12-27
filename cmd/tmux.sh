tmux_sessions() {
    tmux ls | fzf -1 -d ":" --accept-nth 1
}
