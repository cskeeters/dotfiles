vim.keymap.set('n', ',,xf', [[ggVG:!xmllint --format -<cr>]], { buffer=true, desc='Format XML' })
