tm_local_snapshot() {
    tmutil listlocalsnapshots / | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf --prompt "LOCAL SNAPSHOT> "
}
