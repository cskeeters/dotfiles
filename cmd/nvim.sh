nvim_config() {
    (cd $HOME/.config; ls -1d nvim*) | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf
}
