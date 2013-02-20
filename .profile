export CLICOLOR=1
alias ll="ls -lah"
alias d=ll
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'

if [ "Darwin" == "$(uname)" ]; then
  #homebrew path first
  export PATH=/usr/local/bin:$PATH
  export PATH=/opt/local/bin:/opt/local/sbin:$PATH
  export PKG_CONFIG_PATH=/opt/X11/lib/pkgconfig:/opt/X11/share/pkgconfig:/opt/local/lib/pkgconfig:/usr/lib/pkgconfig
  export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


  function tabname {
    printf "\e]1;$1\a"
  }

  function winname {
    printf "\e]2;$1\a"
  }
fi

bitb() {
    local P="$(hg paths 2>/dev/null | grep 'bitbucket.org' | head -1)"
    local URL="$(echo $P | sed -e's|.*\(bitbucket.org.*\)|http://\1|')"
    if [ -e /usr/bin/gnome-open ]; then
      [[ -n $URL ]] && gnome-open $URL || echo "No BitBucket path found!"
    else
      [[ -n $URL ]] && open $URL || echo "No BitBucket path found!"
    fi
}
