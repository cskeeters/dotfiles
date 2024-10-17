-- build
vim.keymap.set('n', '<C-k>d', [[<Cmd>update<cr>:!latexmk -pdf '%' && open -a Preview.app '%:r.pdf'<cr>]], { buffer=true, desc='Build/Compile to PDF' })
