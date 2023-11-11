return {
    enabled = true,
    'nathangrigg/vim-beancount',
    lazy = false,
    keys = {
        {'<LocalLeader><LocalLeader>bc', '<cmd>AlignCommodity<cr>', desc="Align decimals on beancount file" },
    },
    init = function()

        vim.g.beancount_separator_col = 60
    end,
}
