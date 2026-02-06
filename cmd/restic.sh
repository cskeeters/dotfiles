restic_repo() {
    cat ~/.restic/repos | fzf --with-nth 1 --accept-nth 1 --prompt "REPO> "
}

restic_backedup_path() {
    restic snapshots --latest 1 --host $(hostname) --json | jq -r '.[] | .paths[] ' | uniq | sort | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf --prompt "PATH> "
}
