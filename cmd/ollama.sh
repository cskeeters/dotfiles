ollama_local_models() {
    ollama list | grep -v "NAME" | cut -d " " -f 1 | fzf --prompt "MODEL> "
}

ollama_running_models() {
    ollama ps | sed '1d' | awk '{print $1}' | fzf --prompt "RUNNING MODEL> "
}
