function Normal(keys)
    local from_part = true; -- always true
    local translate_less_than = true; --<lt>
    local special = true; -- translate <CR> <Esc>
    local translated_keys = vim.api.nvim_replace_termcodes(keys, from_part, translate_less_than, special);
    vim.cmd.normal(translated_keys);
end

function FugitivePush()
    vim.cmd([[G push]])
end
function FugitiveOpen()
    Normal([[o<C-w><C-p><C-w>c]]);
end
function FugitiveDiff()
    FugitiveOpen();
    Normal([[<Leader>fd]]);
end
function FugitiveDiffTab()
    Normal([[O<Leader>fD]]);
end

vim.keymap.set('n', '<leader>gp', FugitivePush, { buffer=true, desc='Fugitive/git push' })
vim.keymap.set('n', 'go', FugitiveOpen, { buffer=true, desc='Open file in current window' })
vim.keymap.set('n', 'gd', FugitiveDiffTab, { buffer=true, desc='vimdiff on current file object' })

vim.keymap.set('n', '<leader>fd', "O<Leader>fd", { buffer=true, desc="Fugitive/git diff" });
