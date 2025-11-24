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

function dt()
    return os.date("%Y-%m-%d")
end

function trim(s)
   return string.match(s, "^%s*(.-)%s*$")
end

function indexOf(table, needle)
    for i, value in ipairs(table) do
        if value == needle then
            return i
        end
    end
    return nil
end

return {
    s("notify", fmt([[vim.notify("{}", {})]],
        {
            i(1, ""),
            c(2, {
                t("vim.log.levels.ERROR"),
                t("vim.log.levels.WARN"),
                t("vim.log.levels.INFO"),
                t("vim.log.levels.DEBUG"),
                t("vim.log.levels.TRACE"),
            }),
        }
    )),
}
