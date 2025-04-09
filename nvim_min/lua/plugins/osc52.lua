return {
    enabled = true, -- only enable on servers accessed via SSH
    'ojroques/nvim-osc52',
    lazy = false,
    init = function()
        require('osc52').setup {
            max_length = 0,           -- Maximum length of selection (0 for no limit)
            silent = false,           -- Disable message on successful copy
            trim = false,             -- Trim surrounding whitespaces before copy
            tmux_passthrough = false, -- Use tmux passthrough (requires tmux: set -g allow-passthrough on)
        }

        -- Movement operator style
        -- vim.keymap.set('n', '<localleader>c', require('osc52').copy_operator, {expr = true, desc = "Copy via OSC 52"})

        -- vim.keymap.set('n', '<leader>x', '<leader>c_', {remap = true, desc = "Copy via OSC 52"})

        -- Just use visual selection
        --vim.keymap.set('v', '<leader>c', require('osc52').copy_visual)
        vim.keymap.set('v', 'y', function()
            vim.cmd('normal! ygv')
            require('osc52').copy_visual()
        end)

    end,
}
