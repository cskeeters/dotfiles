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

vim.b.decimal_column = 60
vim.b.default_open_only = true

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

function trim(s)
   return string.match(s, "^%s*(.-)%s*$")
end

-- returns choice node of account names in the current file that
--   are open at the end of the file
local openAccounts = function(openOnly)
    openOnly = openOnly or default_open_only

    local openAccounts = {}
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for _, line in ipairs(lines) do
        local account = line:match("open ([^;]*)")
        if account ~= nil then
            print(type(trim(account)))
            table.insert(openAccounts, trim(account))
        end

        if openOnly then
            account = line:match("close ([^;]*)")
            if account ~= nil then
                local j = indexOf(openAccounts, trim(account))
                if j ~= nil then
                    table.remove(openAccounts,j)
                end
            end
        end
    end

    return c(1, toTextNodes(openAccounts))
end

local spaceAmt = function(args, -- text from i(2) in this example i.e. { { "456" } }
                          _,   -- parent snippet or parent node
                          _) -- user_args from opts.user_args
    -- print(vim.inspect(args[2]))
    local account = args[1][1]
    local amount = args[2][1]

    local amountToDecimal = string.find(amount, "." , 1, true)
    if amountToDecimal == nil then
        amountToDecimal = string.len(amount)+1 -- decimal is 1 *after* amount
    end

    local width = vim.b.decimal_column - 4 - string.len(account) - amountToDecimal
    print(width)
    local str = "";
    for count = 1, width, 1 do
        str = str .. " ";
    end
    return str;
end

local decimalAndCents = function(args, _, _)
    local amount = args[1][1]
    if string.len(amount) == 0 then
        return "0.00"
    end

    local amountToDecimal = string.find(amount, "." , 1, true)
    if amountToDecimal == nil then
        return ".00"
    end

    digits_after_decimal = string.len(amount) - amountToDecimal
    if digits_after_decimal == 0 then
        return "00"
    end
    if digits_after_decimal == 1 then
        return "0"
    end
    return ""
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
        {} open Expenses:Tax
        {} open Assets:{}:Checking
        ]], {
            i(1, "My Ledger"),
            f(dt),
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
            {}{}{}{} USD
            {}]],
        {
            f(dt),
            i(1, "Food"),
            d(2, function()
                return sn(nil, openAccounts())
            end, {}),
            f(spaceAmt, {2, 3}),
            i(3, "0.00"),
            f(decimalAndCents, {3}),
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
