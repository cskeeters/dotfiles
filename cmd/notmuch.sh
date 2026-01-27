notmuch_profile() {
    ls -1d /Users/chad/.config/notmuch/* | \
        xargs -I {} basename {} | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf -1 --prompt "NOTMUCH_PROFILE> "
}
