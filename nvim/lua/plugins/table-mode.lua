return {
    enabled = true,
    'dhruvasagar/vim-table-mode',
    lazy = false,
    init = function()
        vim.g.table_mode_map_prefix = ',,t'
        vim.g.table_mode_disable_mappings = 0
        vim.g.table_mode_disable_tableize_mappings = 1
    end,
    config = function()
        vim.keymap.set('n', '\\\\tm', '<Cmd>TableModeToggle<Cr>', { desc="Toggle Table Mode" })
    end
}

--[[
Usage:

1. Create the header.
2. "||" on the next line will make an hline.
3. Put colons to align columns.

|foo|bar|
||

--]]
