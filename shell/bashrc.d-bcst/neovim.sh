if [[ $(hostname -s) != "server" ]]; then
    if exists nvim.chad; then
        # set this to a fixed location so that when nvim.chad changes HOME,
        # xsel can still find .Xauthority and write to the clipboard
        export XAUTHORITY="${XAUTHORITY:-$HOME/.Xauthority}"

        # echo "using custom nvim"
        alias vi='nvim.chad'
        alias vim='nvim.chad'
        alias nvim='nvim.chad'

        # VISUAL may not be a function or alias
        # If the user launches the editor from betty file manager before it's
        # initialized, it will error.  Good enough.
        export VISUAL='nvim.chad'
        export EDITOR=$VISUAL
    fi
fi
