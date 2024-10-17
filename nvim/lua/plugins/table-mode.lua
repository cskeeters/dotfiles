return {
    enabled = true,
    'dhruvasagar/vim-table-mode',
    lazy = false,
    init = function()
        vim.keymap.set('n', ',,tm', '<Cmd>TableModeToggle<Cr>', { buffer=true, silent=true, desc="Toggle Table Mode" })
    end
}
