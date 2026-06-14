return {
    enabled = true,
    'hedyhli/outline.nvim',
    lazy=false,
    config = function()
        vim.keymap.set("n", "<leader>t", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

        require("outline").setup {
            outline_window = {
                auto_close = true,
                width = 70,
                relative_width = false, -- Make width work as percentage
                show_numbers = false,
                show_relative_numbers = false,
            },

            symbol_folding = {
                -- Depth past which nodes will be folded by default. Set to false to unfold all on open.
                autofold_depth = false,
            },
        }
    end,
}
