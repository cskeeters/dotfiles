-- Adds git related signs to the gutter, as well as utilities for managing changes
return {
    enabled = true,
    lazy = false,
    'lewis6991/gitsigns.nvim',
    opts = {
        on_attach = function(bufnr)
            local gitsigns = require 'gitsigns'

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map('n', ']c', function()
                if vim.wo.diff then
                    vim.cmd.normal { ']c', bang = true }
                else
                    gitsigns.nav_hunk 'next'
                end
            end, { desc = 'Jump to next git [c]hange' })

            map('n', '[c', function()
                if vim.wo.diff then
                    vim.cmd.normal { '[c', bang = true }
                else
                    gitsigns.nav_hunk 'prev'
                end
            end, { desc = 'Jump to previous git [c]hange' })

            local function stageHunkVisual()
                gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
            end
            local function resetHunkVisual()
                gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
            end
            local function diffCommit()
                gitsigns.diffthis '@'
            end

            map('n', '<leader>hs', gitsigns.stage_hunk,   { desc = 'git: Stage/Unstage hunk' })
            map('v', '<leader>hs', stageHunkVisual,       { desc = 'git: Stage/Unstage lines' })
            map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git: Stage buffer' })
            map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git: Reset buffer' })

            map('n', '<leader>hr', gitsigns.reset_hunk,   { desc = 'git: Discard unstaged hunk' })
            map('v', '<leader>hr', resetHunkVisual,       { desc = 'git: Discard unstaged lines' })

            map('n', '<leader>hd', gitsigns.diffthis,     { desc = 'git: diff against index' })
            map('n', '<leader>hD', diffCommit,            { desc = 'git: Diff against last commit' })

            map('n', '<leader>hb', gitsigns.blame_line,                { desc = 'git: Blame line popup' })
            map('n', '<leader>gb', gitsigns.toggle_current_line_blame, { desc = 'git: Toggle blame with cursor' })

            map('n', '<leader>hp', gitsigns.preview_hunk,              { desc = 'git: Preview hunk' })
            map('n', '<leader>gD', gitsigns.preview_hunk_inline,       { desc = 'git: Toggle show deleted' })

        end,
    },
}
