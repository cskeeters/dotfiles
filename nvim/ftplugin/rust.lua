vim.keymap.set('n', '<C-k>c', [[<Cmd>term rustc --edition=2024 -g --color always % 2>&1 | less<Cr>]], { buffer=true, desc='Rust: Compile' })
vim.keymap.set('n', '<C-k>R', [[<Cmd>term rustc --edition=2024 -g % && RUST_BACKTRACE=1 ./%:r<Cr>]], { buffer=true, desc='Rust: Compile and Run' })
vim.keymap.set('n', '<C-k>b', [[<Cmd>term cargo build --color always 2>&1 | less<Cr>]], { buffer=true, desc='Cargo: Build and Run' })
vim.keymap.set('n', '<C-k>r', [[<Cmd>term RUST_BACKTRACE=1 cargo run<Cr>]], { buffer=true, desc='Cargo: Build and Run' })
