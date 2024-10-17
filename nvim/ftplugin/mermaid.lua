-- build
vim.keymap.set('n', '<C-k>v', [[<Cmd>update<cr><Cmd>!mmdc -i % -o %:r.svg && open %:r.svg<cr>]], { buffer=true, desc='Generate and View Mermaid' })
