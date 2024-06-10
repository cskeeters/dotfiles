return {
    enabled = true,
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
    },
    lazy = false,
    keys = {
    },
    init = function()
        require('nvim-treesitter.install').update { with_sync = true }

        require'nvim-treesitter.configs'.setup {
            textobjects = {
                select = {
                    enable = true,

                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,

                    keymaps = {
                        -- These don't work
                        --["a="] = { query = "@assignment.outer", desc="Select outer part of assignment"},
                        --["i="] = { query = "@assignment.inner", desc="Select inner part of assignment"},
                        --["l="] = { query = "@assignment.lhs", desc="Select left hand side of assignment"},
                        --["r="] = { query = "@assignment.rhs", desc="Select right hand side of assignment"},

                        ["aa"] = { query = "@attribute.outer", desc="Select around argument"},
                        ["ia"] = { query = "@attribute.inner", desc="Select in argument"},

                        --["ap"] = { query = "@parameter.outer", desc="Select around argument"},
                        --["ip"] = { query = "@parameter.inner", desc="Select in argument"},

                        ["ai"] = { query = "@conditional.outer", desc="Select around conditional"},
                        ["ii"] = { query = "@conditional.inner", desc="Select in conditional"},

                        ["al"] = { query = "@loop.outer", desc="Select around loop"},
                        ["il"] = { query = "@loop.inner", desc="Select in loop"},

                        ["af"] = { query = "@call.outer", desc="Select around function call"},
                        ["if"] = { query = "@call.inner", desc="Select in function call"},

                        ["am"] = { query = "@function.outer", desc="Select around function (method)"},
                        ["im"] = { query = "@function.inner", desc="Select in function (method)"},

                        ["ac"] = { query = "@class.outer", desc="Select around class"},
                        ["ic"] = { query = "@class.inner", desc="Select in class"},

                        --["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                    },

                    -- You can choose the select mode (default is charwise 'v')
                    --
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * method: eg 'v' or 'o'
                    -- and should return the mode ('v', 'V', or '<c-v>') or a table
                    -- mapping query_strings to modes.
                    selection_modes = {
                        ['@parameter.outer'] = 'v', -- charwise
                        ['@function.outer'] = 'V', -- linewise
                        ['@class.outer'] = '<c-v>', -- blockwise
                    },
                    -- If you set this to `true` (default is `false`) then any textobject is
                    -- extended to include preceding or succeeding whitespace. Succeeding
                    -- whitespace has priority in order to act similarly to eg the built-in
                    -- `ap`.
                    --
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * selection_mode: eg 'v'
                    -- and should return true of false
                    --include_surrounding_whitespace = true,
                },
                swap = {
                    enable = true,
                    swap_next = {
                        -- FIXME These bindings interfear with navigating from one sentance to another
                        --[")a"] = { query = "@attribute.outer", desc="Swap attribute with next" },
                        --[")p"] = { query = "@parameter.inner", desc="Swap argument with next" },
                        --[")m"] = { query = "@function.outer", desc="Swap function with next" },
                    },
                    swap_previous = {
                        --["(a"] = { query = "@attribute.outer", desc="Swap attribute with previous" },
                        --["(p"] = { query = "@parameter.inner", desc="Swap argument with previous" },
                        --["(m"] = { query = "@function.outer", desc="Swap function with previous" },
                    }
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]m"] = { query = "@function.outer", desc="Next function call start" },
                        ["]A"] = { query = "@attribute.outer", desc="Next attribute" },
                        ["]a"] = { query = "@attribute.inner", desc="Next attribute value" },
                    },
                    goto_previous_start = {
                        ["[m"] = { query = "@function.outer", desc="Next function call start" },
                    },
                    goto_next_end = {
                        ["[M"] = { query = "@function.outer", desc="Previous function call end" },
                    },
                    goto_previous_end = {
                        ["]M"] = { query = "@function.outer", desc="Previous function call end" },
                    },
                },
            },
        }

        local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

        -- Repeat movement with ; and ,
        -- vim way: ; goes to the direction you were moving.
        vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
        vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

        -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
        vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
    end,
}
