lima_templates() {
    limactl create --list-templates | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf --prompt "TEMPLTE> "
}

lima_vms() {
    limactl list --quiet | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf --prompt "VM> "
}
