vim.opt_local.wrap = true

vim.keymap.set('n', '<LocalLeader>j', [[O.NH 1<Esc>j0]], { buffer=true, desc='Heading 1' })
vim.keymap.set('n', '<LocalLeader>k', [[O.NH 2<Esc>j0]], { buffer=true, desc='Heading 2' })

-- Text styling Bold Italic Fixed-width
-- Note: "_yiw moves cursor to the beginning of the word affecting any registers.  B doen't work when cursor is already on the first character
-- Note: Changed E to e because punctuation is more of a problem than hyphens in words needing style
vim.keymap.set('n', '<LocalLeader>b', [["_yiWi\f[B]<Esc>ea\f[]<Esc>]], { buffer=true, desc='Bold word under cursor' })
vim.keymap.set('n', '<LocalLeader>i', [["_yiWi\*[IT]<Esc>ea\f[]<Esc>]], { buffer=true, desc='Italicize word under cursor' })
vim.keymap.set('n', '<LocalLeader>`', [["_yiWi\f[CR]<Esc>ea\f[]<Esc>]], { buffer=true, desc='Monospace word under cursor' })

vim.keymap.set('v', '<LocalLeader>b', [[s\f[B]<C-r>"\f[]<Esc>]], { buffer=true, desc='Bold selected text' })
vim.keymap.set('v', '<LocalLeader>i', [[s\f[I]<C-r>"\f[]<Esc>]], { buffer=true, desc='Italicize selected text' })
vim.keymap.set('v', '<LocalLeader>`', [[s\f[CB]<C-r>"\f[]<Esc>]], { buffer=true, desc='Monospace selected text' })

-- build
vim.keymap.set('n', '<C-k>', [[<Cmd>update<cr><Cmd>!groff -Kutf8 -Tpdf -m pdfmark -mm -t % > %:r.pdf && open -a Preview.app %:r.pdf<cr>]], { buffer=true, desc='Build/Compile to PDF' })
