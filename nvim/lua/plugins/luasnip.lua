-- This will load snippets from any directory named 'snippets' in the runtime path of vim.
local doReloadSnippets = function()
    local from_snipmate = require("luasnip.loaders.from_snipmate")
    from_snipmate.lazy_load()

    local from_lua = require("luasnip.loaders.from_lua")
    -- https://github.com/L3MON4D3/LuaSnip/blob/master/lua/luasnip/loaders/types.lua
    from_lua.load({paths = "~/dotfiles/nvim/snippets"})
end

local reloadSnippets = function()
    doReloadSnippets()
    vim.notify("Snippets Reloaded")
end

return {
    enabled = true,
    'L3MON4D3/LuaSnip',
    lazy = false,
    build = "CC=clang make install_jsregexp",

    init = function()
        doReloadSnippets()

        local ls = require("luasnip")
        local types = require("luasnip.util.types")

        ls.config.set_config({
            history = true,
            -- Enables dynamic changes as you type
            updateevents = "TextChanged,TextChangedI",
            -- Autosnippets are snippets that are automatically expanded.  Enable here.
            enable_autosnippets = true,
            cut_selection_keys = "<tab>",

            ext_opts = {
                -- Enables ghost text indicating the node type
                [types.choiceNode] = {
                    active = {
                        virt_text = { { " « ", "Error" } },
                    },
                },
            },
        })

        vim.keymap.set({"i"}, "<C-a>", function() ls.expand() end, {silent = true, desc='Complete snippet'})

        vim.keymap.set({"i", "s"}, "<C-j>", function() ls.jump( 1) end, {silent = true, desc='Move to next jump point in snippet'})
        vim.keymap.set({"i", "s"}, "<C-k>", function() ls.jump(-1) end, {silent = true, desc='Move to prev jump point in snippet'})

        -- Cycle through choice nodes
        vim.keymap.set({"i", "s"}, "<C-l>", function()
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end, {silent = true, desc='Select the next choice'})


        vim.keymap.set({"i", "s"}, "<C-e>", function()
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end, {silent = true, desc = "Change choice for luasnip field"})

        -- Use vim.ui.select to select from choices
        -- Install nvim-telescope/telescope-ui-select.nvim to use telescope
        vim.keymap.set("i", "<C-u>", require "luasnip.extras.select_choice", { desc='Select from choices'})

        vim.keymap.set("n", "<LocalLeader>rs", reloadSnippets, { desc='Reload Snippets'})
    end,
}
