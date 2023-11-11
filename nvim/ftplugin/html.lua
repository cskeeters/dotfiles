vim.bo.commentstring = '<!-- %s -->'

vim.keymap.set('n', '<Leader>b', 'diwi<strong><escape>pa</strong><escape>', { buffer=true, desc='Bolds word'})
vim.keymap.set('n', '<Leader>i', 'diwi<em><escape>pa</em><escape>', { buffer=true, desc='Italicize word'})
vim.keymap.set('n', '<Leader>`', 'diwi<code><escape>pa</code><escape>', { buffer=true, desc='Monospace word'})

vim.keymap.set('n', '<C-K>v', '<cmd>!open "%"<cr>', { buffer=true, desc='View HTML in browser' })
