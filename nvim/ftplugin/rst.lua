vim.bo.textwidth=80
vim.bo.wrap=true

-- Setext style headers
vim.keymap.set('n', '<LocalLeader>h', 'yypVr=', { buffer=true, desc='Make Header 1'})
vim.keymap.set('n', '<LocalLeader>j', 'yypVr-', { buffer=true, desc='Make Header 2'})
vim.keymap.set('n', '<LocalLeader>k', 'yypVr^', { buffer=true, desc='Make Header 3'})
vim.keymap.set('n', '<LocalLeader>l', 'yypVr~', { buffer=true, desc='Make Header 4'})

-- Make underlines for headings in reStructuredText format
vim.keymap.set('n', '<LocalLeader>b', '_yiWi**<Esc>lEa**<Esc>', { buffer=true, desc='Bold word'})
vim.keymap.set('n', '<LocalLeader>i', '_yiWi*<Esc>lEa*<Esc>', { buffer=true, desc='Italicize word'})
vim.keymap.set('n', '<LocalLeader>`', '_yiWi`<Esc>lEa`<Esc>', { buffer=true, desc='Monospace word'})

vim.keymap.set('n', '<C-k>v', '<cmd>update | silent ~rst2html.py "%" > %:r.htm && open %:r.htm<cr>', { buffer=true, desc='Monospace word'})

-- For sed script debugging
vim.keymap.set('n', '<C-k>s', '<cmd>update | !sed -nf ~/.rst2pdf/fb.sed "%" | less<cr>', { buffer=true, desc='Run through fb.sed'})

-- pip install rst2pdf
vim.keymap.set('n', '<C-k>p',      [[<cmd>update | :!rst2pdf "%" -o "%:r.pdf" && open "%:r.pdf"<cr>]], { buffer=true, desc='Generate PDF'})
vim.keymap.set('n', '<C-k><C-k>p', [[<cmd>update | :silent !perl -0pe 's/\n\n(.*\n=+)/\n\n.. raw:: pdf\n\n  FrameBreak 250\n\n\1/g;s/\n\n(.*\n-+)/\n\n.. raw:: pdf\n\n  FrameBreak 200\n\n\1/g' '%' \| rst2pdf > %:r.pdf && open %:r.pdf<cr>]], { buffer=true, desc='Generate PDF with TOC??'})
