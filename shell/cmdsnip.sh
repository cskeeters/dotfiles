#### Command Line Snippets

export SED=sed

# On macOS we need to use gsed
if command -v gsed &> /dev/null; then
    export SED=gsed
fi

getsnippet() {
    TRIGGER="$1"
    while IFS= read -r -d $'\0' file; do
        if egrep "^snippet $TRIGGER" "$file" > /dev/null; then
            $SED -nre "/snippet $TRIGGER/{:again; n; s/\t(.*)/\1/p;t again;q;}" "$file"
        fi
    done < <(find ~/.config/cmd -name \*.snippets -print0)
}

export -f getsnippet

snippreview() {
    TRIGGER=""

    re='^snippet +([^[:space:]]*)'
    if [[ "$1" =~ $re ]]; then
        TRIGGER=${BASH_REMATCH[1]}
    fi

    if [[ -z $TRIGGER ]]; then
        return
    fi

    SNIPPET=$(getsnippet "$TRIGGER")
    echo $SNIPPET
}
export -f snippreview

runsnippet() {
    local DEFAULT

    S=$(cat $HOME/.config/cmd/*.snippets | egrep '^snippet' | \
        fzf -d ' ' --with-nth 3.. --bind 'enter:become(echo {2})' \
            --preview-window='top,10%' \
            --preview 'snippreview {}'
    )
    if [[ $S != "" ]]; then
        #printf 'Processing Snippet: %q\n' "$S"
        SNIPPET=$(getsnippet "$S")

        #echo "$SNIPPET"
        CMD="$SNIPPET"

        for ((i=1;i<10;i++)); do
            if echo $SNIPPET | egrep '\$\{'"$i"'.*\}' > /dev/null; then
                DEFAULT=$(echo $SNIPPET | sed -nre 's/.*\$\{'"$i"':([^\}]*)\}.*/\1/p') || {
                    echo "Error extracting default"
                    return
                }
                echo "Populating: $CMD"
                if [[ $DEFAULT =~ ^(.*)\(\)$ ]]; then
                    INPUTFUNC=${BASH_REMATCH[1]}
                    VALUE=$($INPUTFUNC)
                else
                    VALUE=$(gum input --prompt='$1 >' --value="$DEFAULT" --placeholder="$DEFAULT")
                fi
                #echo "$i -> $DEFAULT"

                CMD=$(echo "$CMD" | sed -re 's;\$\{'"$i"'[^\}]*\};'"$VALUE"';g') || {
                    echo "Error using supplied value in CMD"
                    return
                }
            fi
        done

        # Populate the promopt
        READLINE_LINE="$CMD"
        # Cursor position at the end
        READLINE_POINT=${#READLINE_LINE}
    fi
}

bind -x '"\C-x\C-j": runsnippet'

###### Functions for use in snippets

find_files() {
    find . -type f | fzf --height="90%"
}

select_pid() {
    ps aux | FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf --with-nth 1,11.. --accept-nth 2
}

fd_files() {
    fd | fzf --height="90%"
}

git_select_modified() {
    git ls-files -m | fzf --height="90%" --preview 'git diff --color=always {}' --preview-window='top,50%'
}

git_select_staged() {
    git diff --name-only --staged | fzf --height="90%" --preview 'git diff --staged --color=always {}' --preview-window='top,50%'
}

git_tags() {
    git tag -l | fzf --height="90%" --preview 'git log --color=always --graph --oneline -3 {}' --preview-window='top,10%'
}

conda_envs() {
    conda env list | $SED -nre 's/^([^#[:space:]]+)([[:space:]]+).*/\1/p' | fzf
}
ollama_local_models() {
    ollama list | grep -v "NAME" | cut -d " " -f 1 | fzf
}

uv_tools() {
    uv tool list | grep -v "^-" | cut -d " " -f 1 | fzf
}

deb_installed_packages() {
    dpkg -l | sed '1,/===/d' | cut -d ' ' -f 3 | fzf
}
