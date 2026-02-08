tw_task() {
    PROMPT="$1"
    shift

    CONTEXT=$(task _get rc.context)
    CONTEXT_READ_FILTER=""
    if [[ $CONTEXT != "" ]]; then
        CONTEXT_READ_FILTER="( $(task _get rc.context.$CONTEXT.read) )"
    fi

    # jq will output
    # * numerical date for sort -n
    # * uuid for selection
    # * string with ansi color coding to search on with fzf
    task $CONTEXT_READ_FILTER $* export | \
        jq -r '.[] |
            (if .tags == null then "" else .tags | map("+"+.) | join(" ") end) as $tags |
            ( .entry |
              sub("(?<y>\\d{4})(?<m>\\d{2})(?<d>\\d{2})T(?<H>\\d{2})(?<M>\\d{2})(?<s>\\d{2})Z"; "\(.y)-\(.m)-\(.d)T\(.H):\(.M):\(.s)Z") |
              fromdateiso8601) as $datestr |
            "\($datestr)\t\(.uuid)\t\u001b[34m\($datestr | strflocaltime("%Y-%m-%d")) \u001b[0m\(.description) \u001b[32m\($tags)\u001b[0m"' | \
            sort -k3 -n | fzf --ansi -d $'\t' --with-nth 3.. --accept-nth 2 --prompt "$PROMPT> "
}

tw_task_due() {
    PROMPT="$1"
    shift

    CONTEXT=$(task _get rc.context)
    CONTEXT_READ_FILTER=""
    if [[ $CONTEXT != "" ]]; then
        CONTEXT_READ_FILTER="( $(task _get rc.context.$CONTEXT.read) )"
    fi

    # jq will output
    # * numerical date for sort -n
    # * uuid for selection
    # * string with ansi color coding to search on with fzf
    task $CONTEXT_READ_FILTER $* export | \
        jq -r '.[] |
            select(.due) |
            (if .tags == null then "" else .tags | map("+"+.) | join(" ") end) as $tags |
            ( .due |
              sub("(?<y>\\d{4})(?<m>\\d{2})(?<d>\\d{2})T(?<H>\\d{2})(?<M>\\d{2})(?<s>\\d{2})Z"; "\(.y)-\(.m)-\(.d)T\(.H):\(.M):\(.s)Z") |
              fromdateiso8601) as $datestr |
            "\($datestr)\t\(.uuid)\t\u001b[34m\($datestr | strflocaltime("%Y-%m-%d")) \u001b[0m\(.description) \u001b[32m\($tags)\u001b[0m"' | \
            sort -k3 -n | fzf --ansi -d $'\t' --with-nth 3.. --accept-nth 2 --prompt "$PROMPT> "
}

tw_date() {
    if [[ "$1" != "" ]]; then
        # GNU Date can only parse ISO 8601 extended (2026-02-08T23:00:00Z)
        # task export     exports ISO 8601 basic    (20260208T230000Z)
        BASIC=$(task uuid:${VALUES[1]} export | jq -r '.[0].due')
        EXTENDED=$(echo "$BASIC" | $GSED -nre 's/^(....)(..)(..)T(..)(..)(..)Z/\1-\2-\3T\4:\5:\6Z/p')
        DAY=$($GDATE -d "$EXTENDED" +'%Y-%m-%d')

        /usr/local/bin/date_picker "$DAY"
    else
        /usr/local/bin/date_picker
    fi
    # date
}

tw_context() {
    ( echo none; cat ~/.config/task/taskrc | $GSED -nre 's/^context\.([^\.]+).*/\1/p' | sort | uniq ) | \
        fzf --prompt "CONTEXT> "
}
