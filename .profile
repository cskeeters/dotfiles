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

