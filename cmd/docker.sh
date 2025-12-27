docker_containers() {
    docker container ls | sed -ne '2,$p' | awk '{ print $1, $2 }' | \
        fzf -1 --prompt="CONTAINER> " --accept-nth=1
}
