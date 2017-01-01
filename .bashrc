. .profile
source ~/.gshrc
if [[ -f ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
    if hash ag 2> /dev/null; then
        export FZF_DEFAULT_COMMAND='ag -g ""'
    fi
fi

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
