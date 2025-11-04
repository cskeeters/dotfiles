local function ToggleTermOn()
    -- FloatermToggle doesn't take parameters
    vim.cmd([[FloatermToggle POPUP]])
    -- But we can set them with FloatermUpdate
    vim.cmd([[FloatermUpdate --name=POPUP --height=0.8 --width=0.9 --wintype=vsplit --autoclose=1]])
end

return {
    enabled = true,
    'voldikss/vim-floaterm',

    config = function()
        -- autoclose:   0: do not close   1: do not close on error   2: always close
        vim.keymap.set('n', '<Leader>gl', ':FloatermNew --height=1.0 --width=1.0 --wintype=float --name=LazyGit --position=center --autoclose=1 lazygit<cr>',
                                                                       { desc="Open file in current directory tree (fzf)" })

        vim.keymap.set('n', '<F1>', ToggleTermOn,                      { desc="Shows the floating terminal" })
        vim.keymap.set('t', '<F1>', [[<C-\><C-n>:FloatermToggle<CR>]], { desc="Hides the floating terminal" })
    end,
}
