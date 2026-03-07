## UI Output

cmd_show() {
    if [[ -t 2 && $# -gt 1 ]]; then
        # Coloring is ok
        printf -- "\x1b[$2m$1\x1b[m\n" >&2
    else
        printf -- "$1\n" >&2
    fi
}

cmd_fatal() {
    if [[ $CMDSNIP_LOG_LEVEL -ge 1 ]]; then
        cmd_show "FATAL: $1" 31; # 31 is red
    fi
}
cmd_error() {
    if [[ $CMDSNIP_LOG_LEVEL -ge 2 ]]; then
        cmd_show "ERROR: $1" 31; # 31 is red
    fi
}
cmd_warn()  {
    if [[ $CMDSNIP_LOG_LEVEL -ge 3 ]]; then
        cmd_show "WARN: $1" 33; # 33 is yellow
    fi
}
cmd_info()  {
    if [[ $CMDSNIP_LOG_LEVEL -ge 4 ]]; then
        cmd_show "INFO: $1" 34; # 34 is blue
    fi
}
cmd_debug() {
    if [[ $CMDSNIP_LOG_LEVEL -ge 5 ]]; then
        cmd_show "DEBUG: $1" 35;
    fi
}
cmd_trace() {
    if [[ $CMDSNIP_LOG_LEVEL -ge 6 ]]; then
        cmd_show "TRACE: $1" 36;
    fi
}
# Outputs the first parameter and terminates with exit 1
cmd_die() {
    fatal "$1"
    exit 1
}



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
cmd_today() {
    date +%Y-%m-%d
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
    LOCATIONS="."
    if [[ "$3" != "" ]]; then
        LOCATIONS=$3
    fi

    # No quotes around LOCATIONS so there can be multiple arguments to find
    if [[ $2 != "" ]]; then
        find $LOCATIONS -type f -name "$2" | fzf -1 --height="90%" --prompt "$1> "
    else
        find $LOCATIONS -type f | fzf -1 --height="90%" --prompt "$1> "
    fi
}

# $1 - Prompt
# $2 - Path(s)
find_dir() {
    LOCATIONS="."
    if [[ "$2" != "" ]]; then
        LOCATIONS=$2
    fi

    # No quotes around LOCATIONS so there can be multiple arguments to find
    find $LOCATIONS -type d | fzf -1 --height="90%" --prompt "$1> "
}


# $1 - Prompt
# $2 - Pattern (Glob)
# $3 - Path(s)
find_files_shallow() {
    LOCATIONS="."
    if [[ "$3" != "" ]]; then
        LOCATIONS=$3
    fi

    # No quotes around LOCATIONS so there can be multiple arguments to find
    if [[ $2 != "" ]]; then
        gfind -H -L $LOCATIONS -maxdepth 1 -type f -name "$2" | fzf -1 --height="90%" --prompt "$1> "
    else
        gfind -H -L $LOCATIONS -maxdepth 1 -type f | fzf -1 --height="90%" --prompt "$1> "
    fi
}

# $1 - Prompt
# $2 - Path(s)
find_dir_shallow() {
    LOCATIONS="."
    if [[ "$2" != "" ]]; then
        LOCATIONS=$2
    fi

    # No quotes around LOCATIONS so there can be multiple arguments to find
    find $LOCATIONS -depth 1 -type d | fzf -1 --height="90%" --prompt "$1> "
}

# $1 - Prompt
# $2 - Pattern (Regular expression)
# $3 - Path(s)
fd_files() {
    LOCATIONS=$3

    # No quotes around LOCATIONS so there can be multiple arguments to fd
    fd "$2" $LOCATIONS | fzf -1 --height="90%" --prompt "$1> "
}

# $1 - Prompt
# $2 - Pattern (Regular expression)
# $3 - Path(s)
fd_files_shallow() {
    # Fine for this to be empty
    LOCATIONS=$3

    FILTER=""
    if [[ "$2" != "" ]]; then
        FILTER="--glob \"$2\""
    fi

    # No quotes around LOCATIONS so there can be multiple arguments to fd
    if [[ "$2" != "" ]]; then
        fd -d 1 "$2" $LOCATIONS | fzf -1 --height="90%" --prompt "$1> "
    else
        fd -d 1 $LOCATIONS | fzf -1 --height="90%" --prompt "$1> "
    fi
}

## POSIX Utilities

select_pid() {
    ps aux | FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf --with-nth 1,11.. --accept-nth 2
}

cmd_usernames() {
    if [[ $(uname) == "Darwin" ]]; then
        dscl . list /Users | \
            FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf
    else
        getent passwd | sed -re 's/([^:]):.*/\1/' | \
            FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf
    fi
}

cmd_dev_sd() {
    ls -1 /dev/sd* | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf
}

cmd_mount_paths() {
    mount | sed -nre 's/.* on ([^[:space:]]*).*/\1/p' | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf
}

cmd_block_devices() {
    lsblk -f --json | jq -r '.blockdevices | .. | objects | "/dev/\(.name)"' | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf --prompt "BLOCK DEVICE> "
}
