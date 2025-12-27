launchctl_plist() {
    find /Library/LaunchAgents $HOME/Library/LaunchAgents/ | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf --prompt "AGENT> "
}

launchctl_labels() {
    launchctl list | sed -ne '2,$p' | awk '{ print $3}' | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf --prompt "LABEL> "
}
