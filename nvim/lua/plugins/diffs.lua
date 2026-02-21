return {
    enabled = true,
    'barrettruth/diffs.nvim',
    init = function()
        vim.g.diffs = {
            fugitive = true,
            extra_filetypes = {
                "diff",
                "patch",
            },
        }
    end,
}
