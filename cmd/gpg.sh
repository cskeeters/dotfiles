gpg_keys() {
    PROMPT="KEY"
    if [[ $1 != "" ]]; then
        PROMPT=$1
    fi

    gpg --list-keys --with-colons | LC_ALL=C sed -n '
    /^fpr:/ {
        s/^fpr:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:\([^:]*\):.*/\1/
        h
    }
    /^uid:/ {
        s/^uid:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:\([^:]*\):.*/\1/
        G
        s/\(.*\)\n\(.*\)/\2 \1/p
    }
    ' | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf --accept-nth 1 --prompt "$PROMPT> "
}

gpg_secret_keys() {
    PROMPT="PRIVATE KEY"
    if [[ $1 != "" ]]; then
        PROMPT=$1
    fi

    gpg --list-secret-keys --with-colons | LC_ALL=C sed -n '
    /^fpr:/ {
        s/^fpr:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:\([^:]*\):.*/\1/
        h
    }
    /^uid:/ {
        s/^uid:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:\([^:]*\):.*/\1/
        G
        s/\(.*\)\n\(.*\)/\2 \1/p
    }
    ' | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf -1 --accept-nth 1 --prompt "$PROMPT> "
}

pgp_servers() {
    PROMPT="KEY SERVER"
    if [[ $1 != "" ]]; then
        PROMPT=$1
    fi

	echo 'pgp.mit.edu
keys.openpgp.org
keyserver.ubuntu.com
keyserver.pgp.com
ha.pool.sks-keyservers.net' | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf --prompt "$PROMPT> "
}
