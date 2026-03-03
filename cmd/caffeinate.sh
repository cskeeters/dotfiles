caffeinate_PID() {
    ps auxww | sed -E 's/^([^ ]+) +([^ ]+) +[^ ]+ +[^ ]+ +[^ ]+ +[^ ]+ +[^ ]+ +[^ ]+ +[^ ]+ +[^ ]+ +(.*)/\2\t\1\t\3/' | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf --accept-nth 1 --prompt "PROCESSES> "
}
