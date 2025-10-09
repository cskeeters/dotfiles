if exists nvim; then
    alias vi='nvim'
    alias vim='nvim'
fi

if [[ -d /opt/neovim ]]; then
    export NEOVIM_HOME=/opt/neovim
    export PATH=$NEOVIM_HOME/bin:$PATH

    if [[ ! "$MANPATH" == *$NEOVIM_HOME/share/man* && -d "$NEOVIM_HOME/share/man" ]]; then
        export MANPATH="$MANPATH:$NEOVIM_HOME/share/man"
    fi
fi

