neovim_install_good() {
    [[ -f /opt/neovim/bin/nvim ]] || return 1

    VERSION=$(/opt/neovim/bin/nvim --version | grep NVIM)

    [[ "$VERSION" == "NVIM v0.12.3" ]] || return 2

    return 0
}

neovim() {
    if ! neovim_install_good; then
        echo "neovim is not current. syncing..."
        sudo rsync -av --delete --progress root@server:/opt/neovim /opt
        REAL_PATH=$(realpath /opt/neovim)
        sudo rsync -av --delete --progress "root@server:$REAL_PATH" /opt
        PATH=/opt/neovim/bin:$PATH
    fi

    nvim.chad $@
}

if [[ $(hostname -s) != "server" ]]; then
    # echo "using custom nvim"
    alias vi='neovim'
    alias vim='neovim'
    # alias nvim='neovim'
fi
