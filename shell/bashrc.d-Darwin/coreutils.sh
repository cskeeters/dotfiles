exists() {
    hash $1 2>/dev/null
}

# use gnu versions of these tools.  Must be installed with
# brew install findutils gnu-sed coreutils
# exists gfind   && alias find=gfind
# exists gsed    && alias sed=gsed
# exists gmktemp && alias mktemp=gmktemp

#### coreutils
PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
