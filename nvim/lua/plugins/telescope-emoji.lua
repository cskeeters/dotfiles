return {
    enabled = true,
    'xiyaowong/telescope-emoji.nvim',
    lazy = false,
    dependencies = {
        'nvim-telescope/telescope.nvim',
    },
    init = function()
        require('telescope').load_extension('emoji')
    end,
    config = function()
        vim.keymap.set('n', '<C-e>', '<Cmd>Telescope emoji<Cr>', { desc="Search for emoji to put in the unnamed register" })
    end,
}
