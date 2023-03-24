#!/bin/bash

source log.sh

# Obtains plugins from the internet via junegunn/vim-plug

if hash git 2> /dev/null; then
    rm -f ~/.vim/autoload/plug.vim
    info "Downloading updated vim-plug"
    curl -sSfLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim +PlugInstall +PlugUpdate +qa
else
    error "git not installed"
fi
