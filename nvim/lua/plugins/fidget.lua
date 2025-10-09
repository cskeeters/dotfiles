return {
    enabled = true,
    "j-hui/fidget.nvim",
    dependencies = {
        'nvim-telescope/telescope.nvim',
    },
    opts = {
        notification = {
            override_vim_notify = true,
        },
    },
    init = function()
        -- require("telescope").extensions.fidget.fidget()
        require("telescope").load_extension("fidget")

        vim.keymap.set('n', '<Leader>gn', '<Cmd>Fidget clear<cr>',    { desc="Clear notifications" })
        vim.keymap.set('n', '<Leader>N', '<Cmd>Fidget history<cr>',   { desc="List notifications" })
        vim.keymap.set('n', '<Leader>n', '<Cmd>Telescope fidget<cr>', { desc="List notifications with telescope" })
    end,
}
