-- https://github.com/Saghen/blink.cmp/discussions/2149

-- Function to handle both blink.cmp and default <C-n> behavior
function C_n_handler()
    local blink = require('blink.cmp')
    if blink.is_menu_visible() then
        blink.select_next()
    else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-n>", true, true, true), "n", true)
    end
end

-- Function to handle both blink.cmp and default <C-p> behavior
function C_p_handler()
    local blink = require('blink.cmp')
    if blink.is_menu_visible() then
        blink.select_prev()
    else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-p>", true, true, true), "n", true)
    end
end

return {
    enabled = true,
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = {
        'rafamadriz/friendly-snippets',
        'L3MON4D3/LuaSnip',
    },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = {
            preset = 'default',

            -- ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
            -- ['<C-e>'] = { 'cancel', 'fallback' },
            -- ['<C-y>'] = { 'select_and_accept', 'fallback' },

            -- ['<Up>']   = { 'select_prev', 'fallback' },
            -- ['<Down>'] = { 'select_next', 'fallback' },
            -- ['<C-p>']  = { 'select_prev', 'fallback_to_mappings' },
            -- ['<C-n>']  = { 'select_next', 'fallback_to_mappings' },

            -- ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
            -- ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

            -- ['<Tab>'] = { 'snippet_forward', 'fallback' },
            -- ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

            -- ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' }




            -- ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },

            -- ['<C-y>'] = { 'accept', 'fallback' },
            -- -- ['<C-k>'] = { 'show_signature', 'fallback' },
            -- ['<C-j>'] = { 'show', 'select_next', 'fallback' },
            -- ['<C-k>'] = { 'select_prev', 'fallback' },

            ['<C-n>'] = false,
            ['<C-p>'] = false,

            -- ['<Tab>'] = false,
            -- ['<S-Tab>'] = false,

            -- ['<Up>'] = { 'select_prev', 'fallback' },
            -- ['<Down>'] = { 'select_next', 'fallback' },
        },

        snippets = { preset = 'luasnip' },

        appearance = {
            -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = 'Nerd Font Mono'
        },

        -- (Default) Only show the documentation popup when manually triggered
        completion = {
            documentation = { auto_show = true },

            menu = {
                -- Don't automatically show the completion menu
                auto_show = false,
            },

            ghost_text = { enabled = true },
        },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
            -- default = { 'buffer' },
        },

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        fuzzy = { implementation = "prefer_rust_with_warning" },

        signature = { enabled = true },
    },

    opts_extend = { "sources.default" },

    init = function()
        vim.keymap.set("i", "<C-n>", C_n_handler, { noremap = true, silent = true })
        vim.keymap.set("i", "<C-p>", C_p_handler, { noremap = true, silent = true })
    end,
}
