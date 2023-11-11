return {
    enabled = true,
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim'
    },

    keys = {
    },
    init = function()
        local actions = require("telescope.actions")
        require("telescope").setup({
            defaults = {
                mappings = {
                    i = {
                        ["<esc>"] = actions.close,
                    },
                },
            },
            pickers = {
                colorscheme = {
                    enable_preview = true
                }
            }
        })

        -- local builtin = require('telescope.builtin')
        -- NOTE: Currently Using fzf-lua
        --vim.keymap.set('n', '<leader>ff', ':Telescope find_files hidden=true<cr>', {desc= "Find File"})
        --vim.keymap.set('n', '<leader>fg', builtin.live_grep, {desc="Live Grep"})
        --vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc="Find Buffer"})
        --vim.keymap.set('n', '<leader>fh', builtin.help_tags, {desc="Find Help"})
        --vim.keymap.set('n', '<leader>k',  builtin.keymaps, {desc="Find Keymap"})
    end
}
