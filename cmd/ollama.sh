ollama_local_models() {
    ollama list | grep -v "NAME" | cut -d " " -f 1 | fzf --prompt "MODEL> "
}
