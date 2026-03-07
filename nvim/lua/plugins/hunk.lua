return {
    enabled = false,
    "julienvincent/hunk.nvim",
    dependencies = {
        'MunifTanjim/nui.nvim',
    },
    lazy = false,
    cmd = { "DiffEditor" },
    config = function()
        require("hunk").setup()
    end,
}
