return {
    enabled = false,
    "RRethy/nvim-base16", -- must be disabled for ttyd/vhs
    init = function() -- must be disabled for ttyd/vhs
        require('base16-colorscheme').with_config({
            telescope = true,
            indentblankline = true,
            notify = true,
            ts_rainbow = true,
            cmp = true,
            illuminate = true,
        })

        vim.cmd([[colorscheme base16-default-dark]])
    end
}
