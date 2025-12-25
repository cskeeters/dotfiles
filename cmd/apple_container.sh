# Apple Container Framework
container_images() {
    container image list | grep -v NAME | awk '{print $1}' | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf
}

container_containers() {
    container list --all | grep -v CPUS | awk '{print $1}' | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf
}
