if [[ -s "$HOME/.autojump/etc/profile.d/autojump.bash" ]]; then
    source "$HOME/.autojump/etc/profile.d/autojump.bash"
elif [[ -s /usr/share/autojump/autojump.bash ]]; then
    source /usr/share/autojump/autojump.bash
elif [[ -s /usr/share/autojump/etc/profile.d/autojump.bash ]]; then
    source /usr/share/autojump/etc/profile.d/autojump.bash
fi
