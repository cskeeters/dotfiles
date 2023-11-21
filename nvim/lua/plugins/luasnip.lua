-- args is a table, where 1 is the text in Placeholder 1, 2 the text in
-- placeholder 2,...
local function copy(args)
	return args[1]
end

local reloadSnippets = function()
    local from_snipmate = require("luasnip.loaders.from_snipmate")
    from_snipmate.lazy_load()

    local from_lua = require("luasnip.loaders.from_lua")
    from_lua.load({paths = "~/dotfiles/nvim/snippets"})
    vim.notify("Snippets Reloaded")
end

return {
    enabled = true,
    'L3MON4D3/LuaSnip',
    lazy = false,
    build = "make install_jsregexp",

    init = function()
        -- This will load snippets from any directory named 'snippets' in the runtime path of vim.
        local from_snipmate = require("luasnip.loaders.from_snipmate")
        from_snipmate.lazy_load()

        local from_lua = require("luasnip.loaders.from_lua")
        from_lua.load({paths = "~/dotfiles/nvim/snippets"})

        local ls = require("luasnip")
        -- some shorthands...
        local s = ls.snippet
        local sn = ls.snippet_node
        local t = ls.text_node
        local i = ls.insert_node
        local f = ls.function_node
        local c = ls.choice_node
        local d = ls.dynamic_node
        local r = ls.restore_node
        local l = require("luasnip.extras").lambda
        local rep = require("luasnip.extras").rep
        local p = require("luasnip.extras").partial
        local m = require("luasnip.extras").match
        local n = require("luasnip.extras").nonempty
        local dl = require("luasnip.extras").dynamic_lambda
        local fmt = require("luasnip.extras.fmt").fmt
        local fmta = require("luasnip.extras.fmt").fmta
        local types = require("luasnip.util.types")
        local conds = require("luasnip.extras.conditions")
        local conds_expand = require("luasnip.extras.conditions.expand")

        ls.config.set_config({
            history = true,
            -- Enables dynamic changes as you type
            updateevents = "TextChanged,TextChangedI",
            -- Autosnippets are snippets that are automatically expanded.  Enable here.
            enable_autosnippets = true,

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
        vim.keymap.set({"i", "s"}, "<C-k>", function() ls.jump(1) end, {silent = true, desc='Complete snippet'})

        -- Cycle through choice nodes
        vim.keymap.set({"i", "s"}, "<C-l>", function()
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end, {silent = true, desc='Select the next choice'})

        vim.keymap.set({"i", "s"}, "<C-j>", function() ls.jump(-1) end, {silent = true, desc='Move to prev jump point in snippet'})

        vim.keymap.set({"i", "s"}, "<C-e>", function()
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end, {silent = true})

        -- Use vim.ui.select to select from choices
        -- Install nvim-telescope/telescope-ui-select.nvim to use telescope
        vim.keymap.set("i", "<C-u>", require "luasnip.extras.select_choice", { desc='Select from choices'})

        vim.keymap.set("n", "<leader><leader>s", reloadSnippets, { desc='Reload Snippets'})
    end,
}
