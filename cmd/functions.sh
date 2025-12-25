## CMD Utilities

remove_ext() {
    echo "${VALUES[$1]%.*}"
}

## File names/paths

# $1 - Prompt
# $2 - Pattern (Glob)
# $3 - Path(s)
find_files() {
    NAME_FILTER=""
    if [[ "$2" != "" ]]; then
        NAME_FILTER="-name \"$2\""
    fi

    LOCATIONS="."
    if [[ "$3" != "" ]]; then
        LOCATIONS=$3
    fi

    # No quotes around $NAME_FILTER or LOCATIONS so they can be multiple arguments to find
    find $LOCATIONS -type f $NAME_FILTER | fzf --height="90%" --prompt "$1> "
}

# $1 - Prompt
# $2 - Pattern (Glob)
# $3 - Path(s)
find_files_shallow() {
    NAME_FILTER=""
    if [[ "$2" != "" ]]; then
        NAME_FILTER="-name \"$2\""
    fi

    LOCATIONS="."
    if [[ "$3" != "" ]]; then
        LOCATIONS=$3
    fi

    # No quotes around $NAME_FILTER or LOCATIONS so they can be multiple arguments to find
    find $LOCATIONS -depth 1 -type f $NAME_FILTER | fzf --height="90%" --prompt "$1> "
}

# $1 - Prompt
# $2 - Pattern (Regular expression)
# $3 - Path(s)
fd_files() {
    LOCATIONS="."
    if [[ "$3" != "" ]]; then
        LOCATIONS=$3
    fi

    # No quotes around LOCATIONS so it can be multiple arguments to fd
    fd "$2" $LOCATIONS | fzf --height="90%" --prompt "$1> "
}

# $1 - Prompt
# $2 - Pattern (Regular expression)
# $3 - Path(s)
fd_files_shallow() {
    LOCATIONS="."
    if [[ "$3" != "" ]]; then
        LOCATIONS=$3
    fi

    # No quotes around LOCATIONS so it can be multiple arguments to fd
    fd -d 1 "$2" $LOCATIONS | fzf --height="90%" --prompt "$1> "
}

## POSIX Utilities

select_pid() {
    ps aux | FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf --with-nth 1,11.. --accept-nth 2
}
