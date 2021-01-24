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


Capslock to Escape
==================

To map caps lock to escape for one given session, run:

    setxkbmap -option caps:escape

If running in X, you can setup the keybord with dconf.

To install `dconf` under Debian, run:

    sudo apt-get install dconf-cli

To make the setting perminant, run this command.

    dconf write "/org/gnome/desktop/input-sources/xkb-options" "['caps:escape']"
