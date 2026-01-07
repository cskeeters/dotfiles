tw_task() {
    PROMPT="$1"
    shift

    task $* export | \
        jq -r '.[] | "\(.uuid)\t\(.description)"' | \
        fzf -d $'\t' --with-nth 2.. --accept-nth 1 --prompt "$PROMPT> "
}

tw_date() {
    /usr/local/bin/date-picker
    # date
}

tw_context() {
    ( echo none; cat ~/.config/task/taskrc | sed -nre 's/^context\.([^\.]+).*/\1/p' | sort | uniq ) | \
        fzf --prompt "CONTEXT> "
}
