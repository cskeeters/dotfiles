pass_entries() {
    PROMPT="ENTRY"
    if [[ $1 != "" ]]; then
        PROMPT=$1
    fi

    (cd ~/.password-store; find * -type f | sed -Ee 's/.gpg$//') | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf --prompt "$PROMPT> "
}

pass_dirs() {
    PROMPT="ENTRY"
    if [[ $1 != "" ]]; then
        PROMPT=$1
    fi

    (cd ~/.password-store; find * -type d) | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf --prompt "$PROMPT> "
}
