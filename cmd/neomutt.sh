neomutt_accounts() {
    ls -1 ~/.config/neomutt/accounts/* | xargs -I {} basename {} | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf --bind change:first --prompt "ACCOUNT> "
}
