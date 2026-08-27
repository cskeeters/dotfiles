# ACL entries for file specified in parameter $1
acl_entry() {
    VALUES_INDEX=1
    if [[ $1 != "" ]]; then
        VALUES_INDEX="$1"
    fi

    getfacl "${VALUES[$VALUES_INDEX]}" | sed -nre 's/([^:]+:.+):.*/\1/p' |
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf -1 --prompt "ACL ENTRY> "
}
