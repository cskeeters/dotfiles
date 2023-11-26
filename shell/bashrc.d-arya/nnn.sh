#### nnn
n() {
    # Remove F from LESS so help will be paged
    LESS="RX" \
    # Open text files with neovide (separate window)
    VISUAL="neovide" \
    nnn -AHdeT t $*

    LASTD="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    if [ -f "$LASTD" ]; then
        # .lastd will be a script with a cd command in it
        . "$LASTD"
        rm -f "$LASTD" > /dev/null
    fi
}
export NNN_PLUG='a:addjump;f:openfolder;j:fzjump;o:fzopen;d:fzcd;p:acrobatpro;v:vim;i:preview-tui'
# -A no dir auto-enter during filter
# -e open text files in $VISUAL (else $EDITOR, fallback vi) [preferably CLI]
# -d detail mode
# -H show hidden files
export NNN_FIFO=/tmp/nnn.fifo

nnn_cd()
{
    if ! [ -z "$NNN_PIPE" ]; then
        printf "%s\0" "0c${PWD}" > "${NNN_PIPE}" !&
    fi
}

trap nnn_cd EXIT
