diskutil_disknum_by_parition_name() {
    diskutil list -plist | \
        plutil -convert json -o - - | \
        jq -r '.AllDisksAndPartitions[].Partitions[] | select(has("VolumeName")) | "\(.DeviceIdentifier) \(.VolumeName)"' | \
        sed -nre "s~disk(.)([^[:space:]]+) (.*)~\1 \3~p" | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf --with-nth 2.. --accept-nth 1
}
