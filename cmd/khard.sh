khard_format() {
    echo -e "pretty\nyaml\nvcard" | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf --prompt "FORMAT> "
}
