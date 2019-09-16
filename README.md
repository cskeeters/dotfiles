dotfiles
========

This is the repository that stores personal settings for Chad Skeeters.

This can be installed with

    cd ~
    git clone ...
    cd dotfiles
    ./install

To install settings on computers not connected to the internet, install from a dotfiles folder where offline files have been previously downloaded.

On existing machine:

    cd [USB_MOUNT]
    tar -zcf dotfiles.tgz ~/dotfiles

On new machine:

    cd
    tar -zxf [USB_MOUNT]/dotfiles.tgz
    cd dotfiles
    ./install
