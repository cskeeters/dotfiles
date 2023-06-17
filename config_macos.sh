#!/bin/bash

#### Finder

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

#### Dock

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

#### Screenshots
#
# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "$HOME/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

#### TextEdit

# Open a blank document on start
defaults write -g NSShowAppCentricOpenPanelInsteadOfUntitledFile -bool false

# Do not autosave (may not work in ventura)
defaults write com.apple.TextEdit ApplePersistence -bool no

# Set default text editor to Sublime Text 4
defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers -array-add '{LSHandlerContentType=public.plain-text;LSHandlerRoleAll=com.sublimetext.4;}'
