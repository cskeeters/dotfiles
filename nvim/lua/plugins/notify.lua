return {
    enabled = false,
    'rcarriga/nvim-notify',
    lazy = false,

    config = function()

        require("notify").setup({
            -- Minimum level for display.  Lower level msgs will be added to the history.
            level = vim.log.levels.WARN,
            top_down = false,

            -- Ensure the notification popup can't be switched to with Ctrl+w
            on_open = function (win)
                vim.api.nvim_win_set_config(win, { focusable = false })
            end,
        })

        -- Override the default vim.notify method
        vim.notify = require("notify")

        vim.keymap.set('n', '<Leader>n',  require('notify').dismiss,   { desc="Dismiss notifications" })
        vim.keymap.set('n', '<Leader>N',  '<Cmd>Notifications<cr>',    { desc="List notifications" })
        vim.keymap.set('n', '<Leader>gn', '<Cmd>Telescope notify<cr>', { desc="List notifications with telescope" })
    end,
}
