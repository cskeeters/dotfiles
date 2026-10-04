ollama_local_models() {
    OLLAMA_LIST=$(ollama list)
    if [[ $? -ne 0 ]]; then
        cmd_error "Error running ollama list.  Is the ollama server running?"
    else
        echo "$OLLAMA_LIST" | grep -v "NAME" | cut -d " " -f 1 | \
            FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf --prompt "MODEL> "
    fi
}

# $1 must be the position of the model name
ollama_context_limit() {
    local MODEL
    local CONTEXT_LENGTH
    MODEL="${VALUES[$1]}"

    cmd_info "Looking up context length for $MODEL"
    CONTEXT_LENGTH=$(curl -s http://localhost:11434/api/ps | jq '.models[] | select(.name == "'"$MODEL"'") | .context_length')

    if [[ $CONTEXT_LENGTH == "" ]]; then
        cmd_warn "Could not detect context length for $MODEL"
        echo 32768
    else
        cmd_info "$MODEL was loaded with context length $CONTEXT_LENGTH"
        echo $CONTEXT_LENGTH
    fi
}

ollama_trained_context_limit() {
    local MODEL
    local CONTEXT_LENGTH
    MODEL="${VALUES[$1]}"

    cmd_info "Looking up trained context length for $MODEL"
    CONTEXT_LENGTH=$(curl -s http://localhost:11434/api/show -d '{ "model": "'$MODEL'" }' | jq '.model_info' | grep context_length | sed -nre 's/.*: ([^,]*).*/\1/' -e '1p')

    if [[ $CONTEXT_LENGTH == "" ]]; then
        cmd_warn "Could not detect context length for $MODEL"
        echo 32768
    else
        cmd_info "$MODEL was trained with context length $CONTEXT_LENGTH"
        echo $CONTEXT_LENGTH
    fi
}

# $1 must be the model name
ollama_select_context_limit() {
    MAX_NUM_CTX=$(ollama_context_limit $1)

    CUR=2048
    declare -a OPTIONS
    while true; do
        if [[ $CUR -lt $MAX_NUM_CTX ]]; then
            OPTIONS+=($CUR)
        elif [[ $CUR -eq $MAX_NUM_CTX ]]; then
            OPTIONS+=($CUR)
            break
        else
            OPTIONS+=($MAX_NUM_CTX)
            break
        fi

        ((CUR *= 2))
    done

    printf "%s\n" ${OPTIONS[@]} |
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf --prompt "NUM_CTX> "
}

ollama_local_manifest() {
    cmd_debug "Running ollama_local_manifest"
    ollama list | grep -v "NAME" | cut -d " " -f 1 | tr ":" "/" | fzf --prompt "MODEL> "
}

ollama_model_blob_path() {
    MODEL="$(ollama_local_models)"
    MANIFEST_SUBPATH="$(echo "$MODEL" | tr ":" "/")"
    MANIFEST_PATH="~/.ollama/models/manifests/registry.ollama.ai/library/$MANIFEST_SUBPATH"
    cmd_debug "Manifest for $MODEL: $MANIFEST_PATH"

    BLOB_FILE=$(cat ~/.ollama/models/manifests/registry.ollama.ai/library/$MANIFEST_SUBPATH | \
        jq -r '.layers[] | select (.mediaType == "application/vnd.ollama.image.model") | .digest' | \
        tr ':' '-')
    BLOB_PATH="~/.ollama/models/blobs/$BLOB_FILE"
    cmd_info "BLOB for $MODEL: $BLOB_PATH"
    echo $BLOB_PATH
}

ollama_running_models() {
    ollama ps | sed '1d' | awk '{print $1}' |
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf -1 --prompt "RUNNING MODEL> "
}
