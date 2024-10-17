-- python3 -m pip config set global.break-system-packages true
-- python3 -m pip install pynvim --upgrade
-- python3 -m pip install beancount --upgrade
-- or --
-- python3 -m pip install pynvim --break-system-packages
-- python3 -m pip install beancount --break-system-packages

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
