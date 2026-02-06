conda_envs() {
    conda env list | $GSED -nre 's/^([^#[:space:]]+)([[:space:]]+).*/\1/p' | fzf
}
