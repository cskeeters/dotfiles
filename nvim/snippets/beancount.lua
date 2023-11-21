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


local dt = function()
    return os.date("%Y-%m-%d")
end

local indexOf = function (table, needle)
    for i, value in ipairs(table) do
        if value == needle then
            return i
        end
    end
    return nil
end

local toTextNodes = function(optionStrings)
    local nodes = {}
    for _, account in ipairs(optionStrings) do
        table.insert(nodes, t(account))
    end
    return nodes
end

local openAccounts = function()
    local openAccounts = {}
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for _, line in ipairs(lines) do
        local account = line:match("open (.*)")
        if account ~= nil then
            table.insert(openAccounts, account)
        end

        account = line:match("close (.*)")
        if account ~= nil then
            local j = indexOf(openAccounts, account)
            if j ~= nil then
                table.remove(openAccounts,j)
            end
        end
    end

    return c(1, toTextNodes(openAccounts))
end

return {
    s("dt", {
        f(dt),
    }),

    s("new", fmt([[
        ;; -*- mode: beancount; coding: utf-8; fill-column: 400; -*-
        option "title" "{}"
        option "operating_currency" "USD"

        {} open Equity:OpeningBalances
        {} open Assets:{}:Checking
        ]], {
            i(1, "My Ledger"),
            f(dt),
            f(dt),
            i(2, "WellsFargo"),
    })),

    s("open", fmt([[{} open {}]], {
        f(dt),
        c(1, {
            t "Assets:WellsFargo:Checking",
            t "Assets:AccountsReceivable:Lot01",
            t "Liabilities:AccountsPayable:ChadSkeeters",
            t "Income:YearlyAssessments",
            t "Expenses:Tax:Federal",
        }),
    })),

    s("tx", fmt([[
        {} * "{}"
            {}                                  {} USD
            {}]],
        {
            f(dt),
            i(1, "Food"),
            d(2, function()
                return sn(nil, openAccounts())
            end, {}),
            i(3, "-0.00"),
            d(4, function()
                return sn(nil, openAccounts())
            end, {}),
        }
    )),
    s("acc", {
        d(1, function()
            return sn(nil, openAccounts())
        end, {})
    }),
}
