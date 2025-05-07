vim.bo.commentstring = '# %s'
vim.bo.foldenable = false

vim.keymap.set('n', '<C-k>', [[<cmd>update | lcs %:p:h | !mkdir -p output | !( cd output; tj3 --no-color '%:p' && open %:r.html )<cr>]], { buffer=true, desc='Generate HTML for Task Juggler' })
