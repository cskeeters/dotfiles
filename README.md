This is the repository that stores personal settings for Chad Skeeters.

# Installation

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


# Configuration

## Caps Lock to Escape

To map caps lock to escape for the tty:

    sudo loadkeys caps-escape.kmap

If running in X, you can setup the keyboard with `setxkbmap` or `dconf`.

    setxkbmap -option caps:escape

To install `dconf` under Debian, run:

    sudo apt-get install dconf-cli

To make the setting permanent, run this command.

    dconf write "/org/gnome/desktop/input-sources/xkb-options" "['caps:escape']"

# Git

Different machines use different branches.

| Branch         | Machine               |
|----------------|-----------------------|
| `master`       | *arya*                |
| `joffrey`      | *joffrey*             |
| `joffrey_chad` | *joffrey* (chad user) |
| `red`          | *red*                 |

<https://github.com/cskeeters/dotfiles> is used as a central repo.  Branches are kept there so all changes are backed up.

I want changes made to master to be applied to `joffrey`.  This is done by rebasing `joffrey` onto `master` and force pushing.  If this is done on *arya*, then `reset --hard` must be used on *joffrey*.

I want `nvim/lazy-lock.json` to be tracked in each branch, but I don't want changes from `master` to be merged into `joffrey`, I use:

`.gitattributes`:

    nvim/lazy-lock.json merge=ours

