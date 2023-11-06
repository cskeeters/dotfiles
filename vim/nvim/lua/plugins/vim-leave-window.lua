return {
    enabled=true,
    "cskeeters/vim-leave-window",
    dependencies = {
        "moll/vim-bbye"
    },

    lazy=false,

    init = function()
        vim.keymap.set('n', '<leader>w',  ':LWClose<cr>',  { noremap=true, silent=true, desc="Closes a buffer" })
        vim.keymap.set('n', '<leader>gw', ':LWClose!<cr>', { noremap=true, silent=true, desc="Closes a buffer (Without Saving!)" })
    end,

    -- keys = {
        --   { "<leader>w",  "<cmd>LWCLose<cr>",  noremap=true, silent=true, desc = "Closes a buffer" },
        --   { "<leader>gw", "<cmd>LWCLose!<cr>", noremap=true, silent=true, desc = "Closes a buffer (Without Saving!)" },
        -- }
}
