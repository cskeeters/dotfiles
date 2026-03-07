btrfs_devices() {
    lsblk -f --json | \
    jq -r '.blockdevices[] | .. | objects | select(.fstype == "btrfs") |
        if .mountpoints | length > 0 then "\(.mountpoints[0])\t\(.label)\t(/dev/\(.name))" else "/dev/\(.name)" end' | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf -1 -d $'\t' --accept-nth 1 --prompt "BTRFS DEVICE> "
}

btrfs_subvol_mount() {
    mount | egrep 'btrfs.*subvol' | \
        sed -nre 's/.* on ([^[:space:]]*).*/\1/p' | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf
}
