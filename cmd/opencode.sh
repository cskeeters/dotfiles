opencode_provider_models() {
    PROMPT="PROVIDER/MODEL"
    if [[ $1 != "" ]]; then
        PROMPT=$1
    fi

    cat ~/.config/opencode/opencode.jsonc | strip-jsonc | \
        jq -r '.provider | to_entries[] | .key as $P | .value.models | to_entries[] | "\($P)/\(.key)"' | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf --accept-nth 1 --prompt "$PROMPT> "
}
