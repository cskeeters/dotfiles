#!/bin/bash

# Setup fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

fzfpreview() {
    if [[ -d $1 ]]; then
        if command -v eza > /dev/null; then
            eza -1 --icons=always --color=always "$1"
        else
            ls -1 "$1"
        fi
    else
        if [[ $1 =~ (pdf|PDF)$  ]]; then
            if command -v imgcat > /dev/null; then
                if command -v pdftoppm > /dev/null; then
                    pdftoppm -singlefile -jpeg -jpegopt quality=75 "$1" | imgcat -W 100
                fi
            fi
        elif [[ $1 =~ (jpg|jpeg|JPG|JPEG)$ ]]; then
            if command -v imgcat > /dev/null; then
                imgcat -W 100 "$1"
            fi
        elif [[ $1 =~ (nef|NEF)$ ]]; then
            if command -v imgcat > /dev/null; then
                imgcat -W 100 "$1"
            fi
        elif [[ $1 =~ (png|PNG)$ ]]; then
            if command -v imgcat > /dev/null; then
                imgcat -W 100 "$1"
            fi
        else
            # All other file types use bat or head
            if command -v bat > /dev/null; then
                bat -n --color=always -r :55 "$1"
            elif command -v batcat > /dev/null; then
                batcat -n --color=always -r :55 "$1"
            else
                head -n 55 "$1"
            fi
        fi
    fi
}
export -f fzfpreview

# PREVIEW="--preview 'cat {}' --preview-window='right,30%,border-left' --border "
# if command -v bat > /dev/null; then
#     PREVIEW="--preview 'bat -n --color=always {}' --preview-window='right,30%,border-left' --border "
# fi
# # Debian and Ubuntu named bat batcat
# if command -v batcat > /dev/null; then
#     PREVIEW="--preview 'batcat -n --color=always {}' --preview-window='right,30%,border-left' --border "
# fi

PREVIEW="--preview 'fzfpreview {}' --preview-window='right,30%,border-left' --border "

TREE="ls -l {}"
if command -v eza > /dev/null; then
    TREE="eza --tree --color=always {} | head -200"
fi

# Use o instead of i no not overwrite mapping for Tab
export FZF_DEFAULT_OPTS="--walker-skip .git,.hg,node_modules,target --height=100% "\
"$PREVIEW"\
"--bind 'alt-k:half-page-up,alt-j:half-page-down' "\
"--bind 'shift-up:preview-top,shift-down:preview-bottom' "\
"--bind 'ctrl-p:preview-half-page-up,ctrl-n:preview-half-page-down' "\
"--bind 'alt-p:preview-page-up,alt-n:preview-page-down' "\
"--bind 'f2:toggle-preview' "\
"--bind 'f3:change-preview-window(right,60%|bottom,40%|right,30%)' "\
""

# Due to Caret Notation, don't map the following:
# ^H : Backspace
# ^I : Tab
# ^M : Enter
# ^[ : Escape

# FZF comes with the following useful default bindings
#    See man fzf AVAILABLE ACTIONS and KEY/EVENT BINDINGS
#
#### Program
#
# abort                        ctrl-c  ctrl-g  ctrl-q  esc
# accept                       enter   double-click
#
## Selection
# toggle+down                  ctrl-i  (tab)
# toggle+up                    btab (shift-tab)
#
#### Cursor Navigation
#
# backward-char                ctrl-b  left
# forward-char                 ctrl-f  right
#
# forward-word                 alt-f   shift-right
# backward-kill-word           alt-bs
# backward-word                alt-b   shift-left
#
# beginning-of-line            ctrl-a  home
# end-of-line                  ctrl-e  end
#
#### Input Modification
#
# backward-delete-char         ctrl-h  bspace
#
# kill-line                    (UNMAPPED)
# kill-word                    alt-d
#
#### Selection Navigation
#
# down                         ctrl-j  ctrl-n  down
# up                           ctrl-k  ctrl-p  up
# half-page-down               (UNMAPPED)
# half-page-up                 (UNMAPPED)
# next-selected                (UNMAPPED)
# prev-selected                (UNMAPPED)
#
#### Preview Window Manipulation
#
# toggle-preview               (UNMAPPED)
# preview-page-down            (UNMAPPED)
# preview-page-up              (UNMAPPED)
# preview-half-page-down       (UNMAPPED)
# preview-half-page-up         (UNMAPPED)
# preview-bottom               (UNMAPPED)
# preview-top


#",ctrl-y:preview-page-up,ctrl-e:preview-page-down"\
# To make it appear like a popup below the current command, use this:
# --height=80% --min-height=20

#",ctrl-u:preview-page-up,ctrl-d:preview-page-down"\ # Conflicts with git diff in hash select

if exists ag; then
    export FZF_DEFAULT_COMMAND='ag -g ""'

    # Use ag for listing path candidates
    _fzf_compgen_path() {
        ag -g "" "$1"
    }
fi

# Use fd if it's installed
if command -v fd &> /dev/null; then
    # Use fd instead of find
    export FZF_DEFAULT_COMMAND="fd --type f --hidden --no-ignore-vcs --exclude .git/objects --exclude .hg"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git --exclude .hg"

    # Use fd for listing path candidates
    _fzf_compgen_path() {
        fd --hidden --exclude .git --exclude .hg . "$1"
    }
    _fzf_compgen_dir() {
        fd --type=d --hidden --exclude .git --exclude .hg . "$1"
    }
fi

# Setup bash bindings for git
if [[ -d ~/fzf-git.sh ]]; then
    # https://github.com/junegunn/fzf-git.sh
    # cd ~; git clone https://github.com/junegunn/fzf-git.sh.git

    source ~/fzf-git.sh/fzf-git.sh

    # Redefine this function to change the options
    # TAB or SHIFT-TAB to select multiple objects
    # CTRL-/ to change preview window layout
    # CTRL-O to open the object in the web browser (in GitHub URL scheme)
    _fzf_git_fzf() {
        fzf --layout=reverse --multi --border \
            --border-label-pos=2 \
            --color='header:italic:underline,label:blue' \
            "$@"
    }
fi

# Customize preview based on command
_fzf_comprun() {
    local command=$1
    shift

    case "$command" in
        cd)    fzf --preview "$TREE" "$@" ;;
        *)     fzf "$@" ;;
    esac
}

#### FZF Jumping

fzf_project_jump() {
    D=$(cat $HOME/.paths | fzf -d '	' --with-nth 2.. --bind 'enter:become(echo {1})')
    if [[ $D != "" ]]; then
        printf 'builtin cd -- %q' "$D"
    fi
}
bind -m emacs-standard '"\ej": "`fzf_project_jump`\e\C-e\C-m"'

