uv_tools() {
    uv tool list | grep -v "^-" | cut -d " " -f 1 | fzf
}
