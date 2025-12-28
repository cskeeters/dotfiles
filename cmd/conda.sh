conda_envs() {
    conda env list | $SED -nre 's/^([^#[:space:]]+)([[:space:]]+).*/\1/p' | fzf
}
