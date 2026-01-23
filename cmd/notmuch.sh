notmuch_profile() {
    ls -d /Users/chad/.config/notmuch/* | \
        xargs basename | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf -1 --prompt "NOTMUCH_PROFILE> "
}
