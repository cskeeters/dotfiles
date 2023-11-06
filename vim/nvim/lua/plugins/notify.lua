return {
    enabled = true,
    'rcarriga/nvim-notify',
    lazy = false,
    keys = {
        {'<LocalLeader><LocalLeader>n', '<cmd>Notifications<cr>', desc="Show a list of notificiations" },
    },
    init = function()
        -- Override the default vim.notify method
        vim.notify = require("notify")

        --vim.notify("This is an error message.\nSomething went wrong!", "error", {
        --    title = plugin,
        --    on_open = function()
        --        vim.notify("Attempting recovery.", vim.log.levels.WARN, {
        --        title = plugin,
        --        })
        --        local timer = vim.loop.new_timer()
        --        timer:start(2000, 0, function()
        --        vim.notify({ "Fixing problem.", "Please wait..." }, "info", {
        --            title = plugin,
        --            timeout = 3000,
        --            on_close = function()
        --            vim.notify("Problem solved", nil, { title = plugin })
        --            vim.notify("Error code 0x0395AF", 1, { title = plugin })
        --            end,
        --        })
        --        end)
        --    end,
        --    })
    end,
}
