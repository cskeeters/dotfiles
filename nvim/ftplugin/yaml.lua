-- Need to have the current working directory the same as the expense file being edited
vim.keymap.set('n', '<LocalLeader>r', [[<Cmd>lcd %:p:h | split term://yfgpr<Cr>]], { buffer=true, desc='Generate Purchase Request Form (PRF)' })
vim.keymap.set('n', '<LocalLeader>t', [[<Cmd>lcd %:p:h | split term://yfgtr<Cr>]], { buffer=true, desc='Generate Travel Request (TR)' })
vim.keymap.set('n', '<LocalLeader>o', [[<Cmd>lcd %:p:h | split term://yfgpo<Cr>]], { buffer=true, desc='Generate Purchase Order (PO)' })
vim.keymap.set('n', '<LocalLeader>e', [[<Cmd>lcd %:p:h | split term://yfger<Cr>]], { buffer=true, desc='Generate Expense Report (ER)' })
vim.keymap.set('n', '<LocalLeader>p', [[<Cmd>lcd %:p:h | split term://yfgdpr<Cr>]], { buffer=true, desc='Generate Detailed Purchase Report (DPR)' })
vim.keymap.set('n', '<LocalLeader>i', [[<Cmd>lcd %:p:h | split term://yfgi<Cr>]], { buffer=true, desc='Generate Government Invoice' })
