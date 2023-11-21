#### Homebrew
#
export BREW_PREFIX=/opt/homebrew
export PATH="$BREW_PREFIX/bin:$PATH"
export PATH="$BREW_PREFIX/sbin:$PATH"

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
