hf_cache_get_models() {
    hf cache ls --sort size:desc | \
        $GSED -re '1,/---/d' -e $'/^\033.*/,$d' -e 's/^([^[:space:]]+).*/\1/' \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf --accept-nth 1 --prompt "MODEL> "
}
