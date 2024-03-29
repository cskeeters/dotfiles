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


-- function OF(index)
--     return f(function(arg)
--         return arg[1][1]
--     end, {index})
-- end

return {
    -- s("chad", fmt([[example {} {}]], {i(1, "default"), OF(1)})),
    -- s("choice", fmt([[printf("With: %d\n", {});]], {c(1, {t "hello", t "world"})})),
    s("date", {f(function() return os.date("%Y-%m-%d") end)}),
}
