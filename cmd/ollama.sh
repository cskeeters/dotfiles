ollama_local_models() {
    OLLAMA_LIST=$(ollama list)
    if [[ $? -ne 0 ]]; then
        cmd_error "Error running ollama list.  Is the ollama server running?"
    else
        echo "$OLLAMA_LIST" | grep -v "NAME" | cut -d " " -f 1 | \
            FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf --prompt "MODEL> "
    fi
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
    ollama ps | sed '1d' | awk '{print $1}' | fzf --prompt "RUNNING MODEL> "
}
