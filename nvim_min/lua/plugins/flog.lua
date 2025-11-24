return {
    enabled = true,
    "rbong/vim-flog",
    lazy = true,
    cmd = { "Flog", "Flogsplit", "Floggit" },
    dependencies = {
        "tpope/vim-fugitive",
    },
    init = function()
        vim.g.flog_permanent_default_opts = { format = "[%h] %ad %s%d" };

        vim.keymap.set('n', '<leader>fl', [[<Cmd>Flog -date=relative<Cr>]], { desc="Flog/git log (Relative date)" });
        vim.keymap.set('n', '<leader>fL', [[<Cmd>Flog -date=short<Cr>]], { desc="Flog/git log" });
    end
}
