vim.opt_local.expandtab = false             -- Use tabs
vim.opt_local.listchars = "trail:·,precedes:«,extends:»,tab:  ,nbsp:·,lead:·"

vim.keymap.set('n', '<C-k>', [[<Cmd>!go build<cr>]], { buffer=true, desc='Build/Compile' })
