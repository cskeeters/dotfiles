# Initialize $LLAMA_CPP_MODELS
llama_init_models() {
    if [[ -d "$HOME/.caches/llama.cpp" ]]; then
        LLAMA_CPP_MODELS=${LLAMA_CPP_MODELS:-$HOME/.caches/llama.cpp}
    fi

    if [[ -d "$HOME/Library/Caches/llama.cpp" ]]; then
        LLAMA_CPP_MODELS=${LLAMA_CPP_MODELS:-$HOME/Library/Caches/llama.cpp}
    fi
}

# Returns the filename of the selected model
llama_select_model() {
    llama_init_models
    ls -1 "$LLAMA_CPP_MODELS" | sed -nre 's/manifest=(.*).json/\1/p' | sed -re $'s:=:/:' -e $'s/=/:/' | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf -1 --prompt "MODEL ($LLAMA_CPP_MODELS)> "
}

# Returns the filename of the manifest
llama_manifest_name() {
    MODEL=$(llama_select_model)
    cmd_debug "Selected Model: $MODEL"
    # HF_ARG=$(ls -1 "$LLAMA_CPP_MODELS" | sed -nre 's/manifest=(.*).json/\1/p' | sed -re $'s:=:/:' -e $'s/=/:/' | \
        # FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf -1 --prompt "MODEL ($LLAMA_CPP_MODELS)> ")
    # cmd_debug "HF_ARG: $HF_ARG"

    echo "manifest=$(echo "$MODEL" | tr '/:' '==').json"
}

llama_manifest_path() {
    MANIFEST_NAME=$(llama_manifest_name)
    echo "$LLAMA_CPP_MODELS/$MANIFEST_NAME"
}

# Returns the path to the guff file for a model downloaded with: llama.server -hf
llama_model_guff_name() {
    MODEL=$(llama_select_model)
    cmd_debug "Selected Model: $MODEL"

    MANIFEST_NAME="manifest=$(echo "$MODEL" | tr '/:' '==').json"
    MANIFEST_PATH="~/Library/Caches/llama.cpp/$MANIFEST_NAME"
    cmd_debug "MANIFEST_PATH: $MANIFEST_PATH"

    RFILENAME=$(jq -r '.ggufFile.rfilename' ~/Library/Caches/llama.cpp/"$MANIFEST_NAME")
    cmd_debug "Parsing ORG/REPO from: $MODEL"
    ORG=$(echo "$MODEL" | cut -d'/' -f1)
    REPO=$(echo "$MODEL" | cut -d'/' -f2 | cut -d':' -f1)
    cmd_debug "RFILENAME: $RFILENAME"
    cmd_debug "ORG: $ORG"
    cmd_debug "REPO: $REPO"

    echo "${ORG}_${REPO}_${RFILENAME}"
}


llama_model_guff_path() {
    llama_init_models
    GUFF_NAME="$(llama_model_guff_name)"
    echo "$LLAMA_CPP_MODELS/$GUFF_NAME"
}
