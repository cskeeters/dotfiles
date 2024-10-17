# CleanClip.spoon

This is a Spoon for [Hammerspoon] that enables the removal of formatting from
text in the clipboard. This watches the clipboard and when new data is copied
to the clipboard it will mutate the text based on the current mode.

## The Problem

When you copy text data from GUI programs, sometimes you want the text with formatting (font family, size, weight, etc) and sometimes your pasting into something that has formatting which you don't want to replace.  You only want the text.  Microsoft has provided _Paste Special_ functionality to help with this problem.  While this is good, it is a bit cumbersome to use, particularly for keyboard-focused users (read: vim users).

## Motivation

Motivation for creating this Spoon comes from:

* [FormatMatch] being no longer available in the App Store.
* FormatMatch removes formatting, but with the dollar sign and commas retained.  Pasting `$299.00` will not retain the *Accounting* format of a cell (`   $200.00` instead of `$   299.00`).  I just got sick of clicking on the \$ button to re-apply *Accounting* formatting after every paste - which is further complicated by not being visible unless the window is of a minimum size.

[FormatMatch]: https://download.cnet.com/formatmatch/3000-2351_4-75633869.html

## Modes

The modes are as follows:

Off
: No Modification.  In Excel, you can use *Paste Special* in this mode.

Text
: Formatting is removed from text

Text / Excel
: Like Text except data is parsed into lines and cells, and dollar signs and commas are stripped from data so that Excel will retain *Accounting* field formatting.

## Usage

Just copy and paste text using any available methods.

`Shift`+`Cmd`+`0` -- Switch modes (Alert will show new mode, which does *not* require clearing)

## Installation

```sh
cd ~
mkdir -p .hammerspoon/Spoons/CleanClip.spoon
cd .hammerspoon/Spoons/CleanClip.spoon
curl -LRO https://raw.githubusercontent.com/cskeeters/dotfiles/refs/heads/master/hammerspoon/CleanClip.spoon/init.lua
curl -LRO https://raw.githubusercontent.com/cskeeters/dotfiles/refs/heads/master/hammerspoon/CleanClip.spoon/README.md
```

Add the following to `~/.hammerspoon/init.lua`:

```
local cleanClip = hs.loadSpoon("CleanClip")
cleanClip:init()

-- CleanClip starts in Off mode.  Uncomment one of the following to change.
-- cleanClip:setMode(cleanClip.TEXT_ONLY)
-- cleanClip:setMode(cleanClip.TEXT_EXCEL)
```

NOTE: [Hammerspoon] installed separately.

[Hammerspoon]: https://www.hammerspoon.org/
