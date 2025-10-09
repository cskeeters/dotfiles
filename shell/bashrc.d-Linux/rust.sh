### Rust

if [[ -d ~/.cargo/bin ]]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

if [[ -d ~/.cargo/env ]]; then
    . "$HOME/.cargo/env"
fi
