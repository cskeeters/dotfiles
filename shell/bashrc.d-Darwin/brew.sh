#### Bash Completion for Brew

# brew install bash-completion
if [[ -r "${BREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${BREW_PREFIX}/etc/profile.d/bash_completion.sh"
else
    for COMPLETION in "${BREW_PREFIX}/etc/bash_completion.d/"*
    do
      [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
    done
fi
