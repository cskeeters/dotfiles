function FugitiveStatus()
    vim.cmd([[0G]]);
end

function FugitiveLog()
    vim.cmd([[0G log --oneline]]);
end

function FugitiveBlame()
    vim.cmd([[G blame]]);
    vim.cmd([[wincmd p]]);
end

return {
    enabled = true,
    'tpope/vim-fugitive',
    lazy = false,
    init = function()
        vim.keymap.set('n', '<leader>fs', FugitiveStatus, { desc="Fugitive/git status" });
        vim.keymap.set('n', '<leader>fl', FugitiveLog, { desc="Fugitive/git log" });
        vim.keymap.set('n', '<leader>fb', FugitiveBlame, { desc="Fugitive/git blame" });

        vim.keymap.set('n', '<leader>fd', ":Gdiffsplit<cr><C-w>l", { desc="vimdiff unstaged changes on current file" });
        vim.keymap.set('n', '<leader>fD', ":Gdiffsplit @<cr><C-w>l", { desc="vimdiff staged changes on current file" });

        vim.keymap.set('n', '<leader>fqd', ":G difftool<cr>", { desc="Load unstaged changes into quickfix list" });
        vim.keymap.set('n', '<leader>fqD', ":G difftool --staged<cr>", { desc="Load staged changes into quickfix list" });

        vim.keymap.set('n', '<leader>ftd', ":G difftool -y <cr>", { desc="vimdiff files with unstaged changes into tabs" });
        -- vim.keymap.set('n', '<leader>ftD', ":G difftool -y --staged<cr>", { desc="vimdiff files with staged changes into tabs" }); this doesn't work
    end,
}
