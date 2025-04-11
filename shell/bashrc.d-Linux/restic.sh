activate_restic_repository() {
    DATA=$(cat ~/.restic/repos | fzf --with-nth 1 --accept-nth 1,2)
    export RESTIC_REPOSITORY=$(echo "$DATA" | cut -d '	' -f 1)
    export RESTIC_PASSWORD_FILE="$HOME/.restic/$(echo "$DATA" | cut -d '	' -f 2)"
}

export -f activate_restic_repository
