systemctl_unit() {
    systemctl list-unit-files | sed -re '1d' -e '/^$/,$d' | awk '{ print($1) }' | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf --prompt "UNIT> "
}
