vim.keymap.set('n', '<C-k>v', [[<Cmd>!d2 '%' && open '%:r.svg' <cr>]], { buffer=true, desc='Build/Compile' })
