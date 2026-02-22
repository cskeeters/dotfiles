diskutil_disknum_by_parition_name() {
    diskutil list -plist | \
        plutil -convert json -o - - | \
        jq -r '.AllDisksAndPartitions[].Partitions[] | select(has("VolumeName")) | "\(.DeviceIdentifier) \(.VolumeName)"' | \
        sed -nre "s~disk(.)([^[:space:]]+) (.*)~\1 \3~p" | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf --with-nth 2.. --accept-nth 1
}

diskutil_webdav_volume() {
    cat ~/.webdav | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf -1 --prompt="VOLUME>"
}

diskutil_mounted_webdav_volume() {
    mount | sed -nre 's;.* (/Volumes/[^[:space:]]+) .*webdav.*;\1;p' | \
        fzf -1 --prompt="VOLUME>"
}
