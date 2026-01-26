#!/bin/bash

# This just creates the MailDir folders for neomutt account

# FOLDER="$HOME/.home/local" ./config_mutt.sh
# FOLDER="$HOME/.home/yahoo" MAILDIRS="Inbox Sent Archive Draft Sent Bulk Trash" ./config_mutt.sh

FOLDER=${FOLDER:-$HOME/.mail/local}
MAILDIRS=${MAILDIRS:-Inbox Sent Archive Draft Sent Spam Trash}

mkmaildir() {
    mkdir -p "$1/cur"
    mkdir -p "$1/tmp"
    mkdir -p "$1/new"
}

# Don't quote MAILDIRS
for MD in $MAILDIRS; do
    mkmaildir "$FOLDER/$MD"
done
