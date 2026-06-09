docker_containers() {
    docker container ls -a --format 'json' | jq -r '"\(.ID)\t\(.Names)"' | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf -1 --prompt="CONTAINER> " -d $'\t' --accept-nth 1 --with-nth 2..
}

docker_container_names() {
    docker container ls -a --format 'json' | jq -r '.Names' | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf -1 --prompt="CONTAINER NAME> "
}

docker_containers_with_state() {
    STATE="$1"
    docker container ls -a --format 'json' | jq -r 'select(.State == "'"$STATE"'") | "\(.ID)\t\(.Names)"' | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf -1 --prompt="CONTAINER> " -d $'\t' --accept-nth 1 --with-nth 2..
}

docker_container_names_with_state() {
    STATE="$1"
    docker container ls -a --format 'json' | jq -r 'select(.State == "'"$STATE"'") | .Names' | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf -1 --prompt="CONTAINER NAME> "
}

docker_images() {
    docker image ls -a --format 'json' | jq -r '"\(.ID)\t\(.Repository)"' | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf -1 --prompt="IMAGE> " -d $'\t' --accept-nth 1 --with-nth 2..
}

docker_image_tags() {
    docker image ls -a --format 'json' | jq -r '"\(.Repository):\(.Tag)"' | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf -1 --prompt="IMAGE TAG> "
}

docker_tag_repository() {
    echo "${VALUES[$1]%%:*}"
}

docker_volume() {
    docker volume ls --format 'json' | jq -r '"\(.Name)"' | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf -1 --prompt="VOLUME> "
}
