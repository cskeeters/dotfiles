rpm_files() {
    find . -type f -name \*.rpm | fzf --height="90%"
}

rpm_installed_packages() {
    rpm -qa | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf
}
