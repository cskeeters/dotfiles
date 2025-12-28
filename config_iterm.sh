#!/bin/bash

# Capture:
#   plutil -convert xml1 ~/Library/Preferences/com.googlecode.iterm2.plist -o iterm2.xml

info "Setup iterm settings"
plutil -convert binary1 iterm2.xml -o ~/Library/Preferences/com.googlecode.iterm2.plist
