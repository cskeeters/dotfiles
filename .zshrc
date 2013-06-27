yourdotfiles=/Users/chad
source $yourdotfiles/.zshuery/zshuery.sh
load_defaults
load_aliases
load_lol_aliases
load_completion $yourdotfiles/.zshuery/completion
load_correction

#autoload -Uz vcs_info
#zstyle ':vcs_info:*' enable hg git bzr svn

prompts '%{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%}$(virtualenv_info) %{$fg[yellow]%}$(prompt_char)%{$reset_color%} ' '%{$fg[red]%}%n@%m%{$reset_color%}'

if is_mac; then
    export EDITOR='mvim'
else
    export EDITOR='vim'
fi

alias -s h=$EDITOR
alias -s cpp=$EDITOR
alias -s htm=$EDITOR
alias -s html=$EDITOR
alias -s css=$EDITOR
alias -s js=$EDITOR

chpwd() {
  update_terminal_cwd
}

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd autopushd beep extendedglob nomatch
unsetopt notify
bindkey -e


# End of lines configured by zsh-newuser-install

bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# The following lines were added by compinstall
zstyle :compinstall filename '/home/chad/.zshrc'

autoload -Uz compinit
compinit

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
    echo '○'
}

s() {
  hg root >/dev/null 2>/dev/null
  if [ $? -eq 0 ]; then
    hg status
  fi

  git branch >/dev/null 2>/dev/null
  if [ $? -eq 0 ]; then
    git status
  fi
}


# End of lines added by compinstall

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
umask 002

h2d(){
  echo "ibase=16; $@"|bc
}
d2h(){
  echo "obase=16; $@"|bc
}

export HISTCONTROL=erasedups


if [[ "Darwin" == "$(uname)" ]]; then
  #homebrew path first
  export PATH=/usr/local/bin:$PATH
  export PATH=/opt/local/bin:/opt/local/sbin:$PATH
  export PATH=~/bin:$PATH
  export PKG_CONFIG_PATH=/opt/X11/lib/pkgconfig:/opt/X11/share/pkgconfig:/opt/local/lib/pkgconfig:/usr/lib/pkgconfig
  export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

  # use gnu versions of these tools.  Must be installed with
  # brew install findutils gnu-sed
  alias find=gfind
  alias sed=gsed


  function tabname {
    printf "\e]1;$1\a"
  }

  function winname {
    printf "\e]2;$1\a"
  }
fi

if [[ "Linux" == "$(uname)" ]]; then # for the linux only stuff
  xmodmap .Xmodmap
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

alias -g ll='ls -la'
alias -g d="dirs -v"
#alias -g s="hg sta"
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g CA="2>&1 | cat -A"
alias -g C='| wc -l'
alias -g D="DISPLAY=:0.0"
alias -g DN=/dev/null
alias -g ED="export DISPLAY=:0.0"
alias -g EG='|& egrep'
alias -g EH='|& head'
alias -g EL='|& less'
alias -g ELS='|& less -S'
alias -g ETL='|& tail -20'
alias -g ET='|& tail'
alias -g F=' | fmt -'
alias -g G='| egrep'
alias -g H='| head'
alias -g HL='|& head -20'
alias -g Sk="*~(*.bz2|*.gz|*.tgz|*.zip|*.z)"
alias -g LL="2>&1 | less"
alias -g L="| less"
alias -g LS='| less -S'
alias -g MM='| most'
alias -g M='| more'
alias -g NE="2> /dev/null"
alias -g NS='| sort -n'
alias -g NUL="> /dev/null 2>&1"
alias -g PIPE='|'
alias -g R=' > /c/aaa/tee.txt '
alias -g RNS='| sort -nr'
alias -g S='| sort'
alias -g TL='| tail -20'
alias -g T='| tail'
alias -g US='| sort -u'
alias -g VM=/var/log/messages
alias -g X0G='| xargs -0 egrep'
alias -g X0='| xargs -0'
alias -g XG='| xargs egrep'
alias -g X='| xargs'