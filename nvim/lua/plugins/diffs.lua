return {
    enabled = true,
    'barrettruth/diffs.nvim',
    init = function()
        -- vim.g.diffs.integrations = {
            -- fugitive = true,
            -- extra_filetypes = {
                -- "diff",
                -- "patch",
            -- },
        -- }

        vim.g.diffs = {
            integrations = {
                fugitive = true,
                neogit = true,
                neojj = false,
                gitsigns = false,
                extra_filetypes = {
                    "diff",
                    "patch",
                },
            },
        }

    end,
}
