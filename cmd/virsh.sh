virsh_get_VMs() {
    FLAGS=""

    if [[ "$1" == "ALL" ]]; then
        FLAGS="--all"
    fi

    if $(sudo -n true); then
        sudo -n virsh -c "qemu:///system" list $FLAGS | sed -nre '3,$p' | awk '{print $2}' |
            FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf --prompt "DOMAIN(VM)> "
    else
        exit 1
    fi
}
