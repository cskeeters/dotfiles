return {
    enabled = true,
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'benfowler/telescope-luasnip.nvim',
        --'nvim-telescope/telescope-ui-select.nvim',
    },

    keys = {
    },
    init = function()
        local actions = require("telescope.actions")
        local action_layout = require("telescope.actions.layout")

        require("telescope").setup({
            defaults = {
                layout_strategy = 'cursor',
                layout_config = {
                    height = 0.99,
                    width = 0.99,
                    cursor = {
                        preview_width = 0.4,
                        width = 0.99,
                        height = 0.99,
                    },
                    center = {
                        preview_cutoff = 1,
                        prompt_position = "top",
                        width = 0.99,
                        height = 0.99,
                    },

                },
                cycle_layout_list = {
                    "center",
                    "cursor",
                },
                sorting_strategy = "ascending",
                mappings = {
                    i = {
                        -- :help telescope.actions
                        --["<esc>"] = actions.close, -- esc enters normal mode
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<F2>"] = action_layout.cycle_layout_next,
                    },
                },
            },
            pickers = {
                colorscheme = {
                    enable_preview = true
                }
            }
        })

        require('telescope').load_extension('luasnip')
        --require('telescope').load_extension('ui-select')
        require("telescope").load_extension("git_worktree")

        -- 'nvim-telescope/telescope-fzf-native.nvim',
        require('telescope').load_extension('fzf')

        vim.keymap.set('n', '<LocalLeader>s', ':Telescope luasnip<cr>', {desc= "Search for Snippet"})

        -- local builtin = require('telescope.builtin')
        -- NOTE: Currently Using fzf-lua
        --vim.keymap.set('n', '<leader>ff', ':Telescope find_files hidden=true<cr>', {desc= "Find File"})
        --vim.keymap.set('n', '<leader>fg', builtin.live_grep, {desc="Live Grep"})
        --vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc="Find Buffer"})
        --vim.keymap.set('n', '<leader>fh', builtin.help_tags, {desc="Find Help"})
        --vim.keymap.set('n', '<leader>k',  builtin.keymaps, {desc="Find Keymap"})
    end
}
