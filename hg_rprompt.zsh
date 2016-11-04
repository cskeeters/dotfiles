#!/bin/zsh

#For less querying, set the follow to assume that `hg pull` pulls everything and `hg push` pushes everthing
# HG_APROX=1

# zsh hook - executed before prompt is drawn
precmd() {
    if [[ -d .hg ]]; then
        if [[ -z $HG_OUTGOING ]]; then
            hg_query_incoming
            hg_query_outgoing
        else
            handle_last_command
        fi
        RPROMPT="$(red_non_zero $HG_INCOMING)/$(red_non_zero $HG_OUTGOING)"
    fi
}

# zsh hook - executed when directory has changed
chpwd() { 
    RPROMPT=""
    HG_INCOMING=""
    HG_OUTGOING=""
}

red_non_zero() {
    if [[ $1 == "0" ]]; then
        echo "0";
    else
        echo "%{$fg_bold[red]%}$1%{$reset_color%}"
    fi
}

# Determine if last cmd affects HG_INCOMING or HG_OUTGOING values
handle_last_command() {
    last_cmd=$(sed -re 's:^[^;]*;(.*)$:\1:' <(tail -n 1 $HISTFILE))
    # Handle cases where ctrl-c or enter are pressed
    [[ $last_cmd == $last_cmd_processed ]] && return
    last_cmd_processed="$last_cmd"

    # pull only affects HG_INCOMING
    if [[ $last_cmd =~ ^hg\ pull? ]]; then
        if [[ $HG_APPROX == 1 ]]; then
            HG_INCOMING="0"
        else
            hg_query_incoming
        fi
    fi

    # push only affects HG_OUTGOING
    if [[ $last_cmd =~ ^hg\ push? ]]; then
        if [[ $HG_APPROX == 1 ]]; then
            HG_OUTGOING="0"
        else
            hg_query_outgoing
        fi
    fi

    if [[ $last_cmd =~ ^hg\ (ci|commit) ]]; then
        (( HG_OUTGOING=$HG_OUTGOING + 1 ))
    fi
}


hg_query_incoming() {
    echo "...Updating incomming for RPROMPT"

    output="$(hg incoming -q 2> /dev/null)"
    if [[ $? -eq 0 ]]; then
        HG_INCOMING="$(echo "$output" | wc -l | tr -d '[:space:]')"
    else
        HG_INCOMING="0"
    fi
}

hg_query_outgoing() {
    echo "...Updating outgoing for RPROMPT"

    output="$(hg outgoing -q 2> /dev/null)"
    if [[ $? -eq 0 ]]; then
        HG_OUTGOING="$(echo "$output" | wc -l | tr -d '[:space:]')"
    else
        HG_OUTGOING="0"
    fi
}
