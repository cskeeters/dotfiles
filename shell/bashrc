[[ -f ~/.profile ]] && source ~/.profile
[[ -f ~/.gshrc ]] && source ~/.gshrc

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

if [[ $(uname) == "Darwin" ]]; then
    if [[ -f $(brew --prefix)/etc/bash_completion ]]; then
        . $(brew --prefix)/etc/bash_completion
    else
        echo "Bash completion is not installed.  Install with:"
        echo "  brew install bash-completion"
    fi
fi

if type _cd > /dev/null; then
    # Enable fuzzy style completions
    [[ -f ~/.completions ]] && source ~/.completions
fi

[[ -f ~/.bash_prompt ]] && source ~/.bash_prompt
