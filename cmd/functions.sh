## CMD Utilities

cmd_remove_ext() {
    echo "${VALUES[$1]%.*}"
}

cmd_dir_name() {
    command -p dirname "${VALUES[$1]}"
}

cmd_basename() {
    command -p basename "${VALUES[$1]}"
}

cmd_realpath() {
    REL_PATH=$(gum input --prompt="$1> " --value="$3" --placeholder="$2")
    realpath "$REL_PATH"
}

cmd_date() {
    /usr/local/bin/date_picker
    # date
}

# $1 PROMPT
# $* Choices (In order of preference)
cmd_choose() {
    PROMPT=$1
    shift
    echo "$*" | tr ' ' '\n' | fzf --prompt "$PROMPT> "
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
    find $LOCATIONS -type f $NAME_FILTER | fzf -1 --height="90%" --prompt "$1> "
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
    find $LOCATIONS -depth 1 -type f $NAME_FILTER | fzf -1 --height="90%" --prompt "$1> "
}

# $1 - Prompt
# $2 - Path(s)
find_dir_shallow() {
    LOCATIONS="."
    if [[ "$2" != "" ]]; then
        LOCATIONS=$2
    fi

    # No quotes around LOCATIONS so they can be multiple arguments to find
    find $LOCATIONS -depth 1 -type d | fzf -1 --height="90%" --prompt "$1> "
}

# $1 - Prompt
# $2 - Pattern (Regular expression)
# $3 - Path(s)
fd_files() {
    LOCATIONS=$3

    # No quotes around LOCATIONS so it can be multiple arguments to fd
    fd "$2" $LOCATIONS | fzf -1 --height="90%" --prompt "$1> "
}

# $1 - Prompt
# $2 - Pattern (Regular expression)
# $3 - Path(s)
fd_files_shallow() {
    # Fine for this to be empty
    LOCATIONS=$3

    # No quotes around LOCATIONS so it can be multiple arguments to fd
    fd -d 1 "$2" $LOCATIONS | fzf -1 --height="90%" --prompt "$1> "
}

## POSIX Utilities

select_pid() {
    ps aux | FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf --with-nth 1,11.. --accept-nth 2
}
