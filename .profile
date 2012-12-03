export CLICOLOR=1
alias ll="ls -lah"

#MacPorts
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

#OSX method to rename windows
function tabname {
		  printf "\e]1;$1\a"
}
 
function winname {
		  printf "\e]2;$1\a"
}

bitb() {
    local P="$(hg paths 2>/dev/null | grep 'bitbucket.org' | head -1)"
    local URL="$(echo $P | sed -e's|.*\(bitbucket.org.*\)|http://\1|')"
    if [ -e /usr/bin/gnome-open ]; then
      [[ -n $URL ]] && gnome-open $URL || echo "No BitBucket path found!"
    else
      [[ -n $URL ]] && open $URL || echo "No BitBucket path found!"
    fi
}
