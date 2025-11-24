-- Pros for telescope over fzf-lua
--  * can hide the preview window (F2) by cycling layouts
--  * luasnip extention for searching snippets (could be converted)
--  * less display artifacts
--  * can load results into quickfix list
-- Cons for telescope over fzf-lua
--  * No Ctrl+a Ctrl+e beginning/end of line
--  * Slower to search through many files
--  * Stops searching after first characters typed
--  * have to hit escape twice or lose normal mode bindings/actions gg/G, H, M, L
--
-- fzf.vim
-- * Has same bindings in shell as in vim (though Ctrl-/) doen't work
-- * Can change preview location (f3) or disable preview (f2)
-- * The fastest
return {
    enabled = true,
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'benfowler/telescope-luasnip.nvim',
        -- 'rcarriga/nvim-notify',
        --'nvim-telescope/telescope-ui-select.nvim',
    },

    keys = {
    },
    init = function()
        local actions = require("telescope.actions")
        local action_layout = require("telescope.actions.layout")

        require("telescope").setup({
            defaults = {
                layout_strategy = 'horizontal',
                layout_config = {
                    height = 0.99,
                    width = 0.99,
                    horizontal = {
                        preview_width = 0.4,
                        prompt_position = "top",
                    },
                    center = {
                        preview_cutoff = 1,           -- don't show preview if it can't be this many lines tall
                        prompt_position = "top",
                    },

                },
                cycle_layout_list = {
                    "center",
                    "horizontal",
                },
                sorting_strategy = "ascending",
                mappings = {
                    i = {
                        -- See https://github.com/nvim-telescope/telescope.nvim?tab=readme-ov-file#default-mappings
                        -- :help telescope.actions
                        ["<esc>"] = actions.close, -- esc enters normal mode
                        --["<ctrl-c>"] = actions.exit normal mode (don't see an action for this)
                        --["<ctrl-c>"] = "<esc>",
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<F2>"] = action_layout.cycle_layout_next, -- this effectively disables the preview, which matches fzf
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
        -- require('telescope').load_extension('notify')
        --require('telescope').load_extension('ui-select')
        -- require("telescope").load_extension("git_worktree")

        -- 'nvim-telescope/telescope-fzf-native.nvim',
        require('telescope').load_extension('fzf')

        vim.keymap.set('n', '<LocalLeader>s', ':Telescope luasnip<cr>', {desc= "Search for Snippet"})
        -- Not sure why, but backspace is needed to remove 'A' from the search string in telegram
        vim.keymap.set('i', '<C-s>', '<Esc><Cmd>Telescope luasnip<cr>', {desc= "Search for Snippet"})

        local builtin = require('telescope.builtin')
        -- NOTE: Currently Using fzf-lua
        --vim.keymap.set('n', '<leader>of', ':Telescope find_files<cr>', {desc= "Open file in current directory tree (fzf)"})
        --vim.keymap.set('n', '<leader>of', '<Cmd>lua require("telescope.builtin").find_files({find_command={"fd", "--type", "f"}})<cr>', {desc= "Open file in current directory tree (fzf)"})
        --vim.keymap.set('n', '<leader>om', builtin.marks, {desc="Find Buffer"})

        --vim.keymap.set('n', '<leader>oc', ':Telescope find_files cwd=~/.config/nvim<cr>',                       {desc= "Open vim Config file (fzf)"})
        --vim.keymap.set('n', '<Leader>op', ':Telescope find_files cwd=~/.local/share/nvim<cr>',                  {desc="Open neovim Plugin file (fzf)" })
        --vim.keymap.set('n', '<leader>on', ':Telescope find_files cwd=~/Library/CloudStorage/Dropbox/notes<cr>', {desc= "Open Note (fzf)"})
        --vim.keymap.set('n', '<Leader>od', ':Telescope find_files cwd=~/working/bcst-doc<cr>',                   {desc="Open bcst-doc file (fzf)" })

        vim.keymap.set('n', '<leader>gm', ':Telescope marks<cr>', {desc="Goto Mark (fzf)"})

        --vim.keymap.set('n', '<leader>fg', builtin.live_grep, {desc="Live Grep"})
        --vim.keymap.set('n', '<leader>fh', builtin.help_tags, {desc="Find Help"})
        --vim.keymap.set('n', '<leader>k',  builtin.keymaps, {desc="Find Keymap"})
    end
}
