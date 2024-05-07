-- Emacs keys in cmd mode

-- These already work
-- vim.keymap.set('c', '<C-p>', '<Up>', { desc="Previous command" })
-- vim.keymap.set('c', '<C-n>', '<Down>', { desc="Next Command" })

vim.keymap.set('c', '<C-a>', '<Home>', { desc="Home (Command)" })
vim.keymap.set('c', '<C-e>', '<End>', { desc="End (Command)" })

vim.keymap.set('c', '<C-b>', '<Left>', { desc="Back one character (Command)" })
vim.keymap.set('c', '<C-f>', '<Right>', { desc="Forward one character (Command)" })

-- These prevent quick exit
--vim.keymap.set('c', '<Esc><C-f>', '<S-Right>', { desc="Forward one word (Command)" })
--vim.keymap.set('c', '<Esc><C-b>', '<S-Left>', { desc="Back one word (Command)" })

if vim.g.neovide ~= nil then
    print("neovide")
    -- These will only work in Neovide where alt doesn't get converted to <Esc> and exit command mode
    vim.keymap.set('c', '∫', '<S-Left>', { desc="Back one word (Command)" })
    vim.keymap.set('c', 'ƒ', '<S-Right>', { desc="Forward one word (Command)" })
end

vim.keymap.set('c', '<C-d>', '<Del>', { desc="Delete character (Command)" })
vim.keymap.set('c', '<C-k>', '<C-\\>estrpart(getcmdline(),0,getcmdpos()-1)<CR>', { desc="Kill remaining part of the command" })
