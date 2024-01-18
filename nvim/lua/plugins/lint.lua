return {
    enabled = true,
    'mfussenegger/nvim-lint',
    lazy = false,
    init = function()
        require('lint').linters_by_ft = {
            markdown = {'vale',}
        }
    end,
    keys = {
        {'<space>gl', '<Cmd>lua require("lint").try_lint()<Enter>', desc="Run grammar check" },
    },
}
