vim.keymap.set('n', '<C-K>v', [[<cmd>!asciidoc -b html5 -a icons -a toc2 -a theme=flask "%" && open '%:r.html'<cr>]], { buffer=true, desc='Convert asciidoc to html' })
