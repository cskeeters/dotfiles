#### Command Line Snippets

set -o pipefail

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
    TRIGGER="$1"

    if [[ -z $TRIGGER ]]; then
        echo $'\033[31mERROR\033[0m: Trigger was not passed to snippreview'
        return
    fi

    if command -v batcat > /dev/null; then
        getsnippet "$TRIGGER" | batcat --color=always --file-name="SNIPPET" --language=bash
    else
        if command -v bat > /dev/null; then
            getsnippet "$TRIGGER" | bat --color=always --file-name="SNIPPET" --language=bash
        else
            getsnippet "$TRIGGER"
        fi
    fi
}
export -f snippreview

runsnippet() {
    for f in "$HOME/.config/cmd"/*.sh; do
        if [[ -f "$f" ]]; then
            # echo "Sourcing $f..."
            source "$f"
        fi
    done

    local DEFAULT

    #printf 'Processing Snippet: %q\n' "$SNIPPET_KEY"
    SNIPPET=$(getsnippet "$SNIPPET_KEY")

    #echo "$SNIPPET"
    CMD="$SNIPPET"

    VALUES=()

    for ((i=1;i<10;i++)); do
        if echo $SNIPPET | egrep '\$\{'"$i"'.*\}' > /dev/null; then
            DEFAULT=$(echo $SNIPPET | sed -nre 's/.*\$\{'"$i"':([^}]*)\}.*/\1/p') || {
                echo "Error extracting default"
                return
            }
            echo "Populating $i for: $CMD"
            if [[ $DEFAULT =~ ^([^\(]*)\((.*)\)$ ]]; then
                INPUTFUNC=${BASH_REMATCH[1]}
                INPUTPARAMS=${BASH_REMATCH[2]}

                # Allows quoting in parameters
                PARAMS=()
                while IFS= read -r -d '' P; do
                    PARAMS+=("$P")
                done < <(echo "$INPUTPARAMS" | xargs printf '%s\0')

                # All the magic...
                # VALUE will be set to the text output by the function specified
                # The function can provide options to FZF (or other) to
                # allow for filtering and selection
                VALUE=$($INPUTFUNC "${PARAMS[@]}")
                if [[ $? -ne 0 ]]; then
                    echo Cancelled cmd snippet
                    return
                fi
            else
                FULL=$DEFAULT
                PROMPT=""
                PLACEHOLDER=$DEFAULT

                # : will separate PROMPT from PLACEHOLDER
                re='^([^:]*):(.*)$'
                if [[ $FULL =~ $re ]]; then
                    PROMPT=${BASH_REMATCH[1]}
                    PLACEHOLDER=${BASH_REMATCH[2]}
                    DEFAULT=""
                fi

                # ; will separate PROMPT from DEFAULT
                re='^([^;]*);(.*)$'
                if [[ $FULL =~ $re ]]; then
                    PROMPT=${BASH_REMATCH[1]}
                    PLACEHOLDER=${BASH_REMATCH[2]}
                    DEFAULT=${BASH_REMATCH[2]}
                fi

                # PROMPT:PLACEHOLDER;VALUE
                re='^([^:]*):([^;]*);(.*)$'
                if [[ $FULL =~ $re ]]; then
                    PROMPT=${BASH_REMATCH[1]}
                    PLACEHOLDER=${BASH_REMATCH[2]}
                    DEFAULT=${BASH_REMATCH[3]}
                fi

                VALUE=$(gum input --prompt="$PROMPT> " --value="$DEFAULT" --placeholder="$PLACEHOLDER")
                if [[ $? -ne 0 ]]; then
                    echo Cancelled cmd snippet
                    return
                fi
            fi
            #echo "$i -> $DEFAULT"

            # Glob with ANSI C Quoting
            if [[ "$VALUE" == *$'\n'* ]]; then
                echo "Error with snippet: default value has newline"
                echo "  Did you forget to pipe to fzf?"
            else
                # Set values here so that other functions (like cmd_remove_ext)
                # can access (and manipuliate) provided values
                # echo "DEBUG: SETTING VALUES[$i]=$VALUE"
                VALUES[$i]=$VALUE
                CMD=$(echo "$CMD" | sed -re 's;\$\{'"$i"'[^}]*\};'"$VALUE"';g') || {
                    echo "Error using supplied value in CMD"
                    return
                }
            fi
        fi
    done

    # Populate the promopt
    READLINE_LINE="$CMD"
    # Cursor position at the end
    READLINE_POINT=${#READLINE_LINE}
}

select_run_snippet() {
    if command -v fzf_sort > /dev/null; then
        # Keep track of recently used commands
        KEY=$(cat $HOME/.config/cmd/*.snippets | sed -n 's/^snippet //p' | \
            fzf_sort --path ~/.local/log/cmdsnip --accept-nth 1 | \
            fzf -d ' ' --with-nth 2.. --bind 'enter:become(echo {1})' \
                --preview-window='top,10%' \
                --preview 'snippreview {1}' | \
            fzf_sort --path ~/.local/log/cmdsnip --log
        )
    else
        KEY=$(cat $HOME/.config/cmd/*.snippets | sed -n 's/^snippet //p' | \
            fzf -d ' ' --with-nth 2.. --bind 'enter:become(echo {1})' \
                --preview-window='top,10%' \
                --preview 'snippreview {}'
        )
    fi

    if [[ $? -eq 0 ]]; then
        # Only save to SNIPPET_KEY and run if the user didn't cancel
        SNIPPET_KEY=$KEY
        runsnippet
    fi
}

rerun_snipet() {
    runsnippet
}

bind -x '"\C-x\C-j": select_run_snippet'
bind -x '"\C-x\C-k": rerun_snipet'
