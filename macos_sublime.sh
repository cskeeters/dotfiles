#!/bin/bash

# Show current association
# duti -x json

# com.sublimetext.4
APPID=$(osascript -e 'id of app "/Applications/Sublime Text.app"')

for TYPE in public.plain-text public.shell-script public.make-source lua md conf json; do
    echo Configuring all $TYPE to use $APPID
    duti -s "$APPID" $TYPE all
done
