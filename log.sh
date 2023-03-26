#!/bin/bash

############ LOG FUNCTIONS
show() {
    if [[ -t 1 ]]; then
        # Coloring is ok
        printf -- "\x1b[$2m$1\x1b[m\n"
    else
        printf -- "$1\n"
    fi
}

error() { show "ERROR: $1" 31; } # 31 is red
warn()  { show "WARN: $1" 33; }  # 33 is yellow
info()  { show "INFO: $1" 34; }  # 34 is blue
# Outputs the first parameter and terminates with exit 1
die() {
    error "$1"
    exit 1
}
