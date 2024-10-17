local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt   -- default delimiters are {}

--- Utilities

local toTextNodes = function(optionStrings)
    local nodes = {}
    for _, option in ipairs(optionStrings) do
        table.insert(nodes, t(option))
    end
    return nodes
end

-- returns choice node for markers in the current file
local markers = function()
    local markers = {}
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for _, line in ipairs(lines) do
        local marker = line:match([[<(.*)>]])
        if marker ~= nil then
            table.insert(markers, marker)
        end
    end

    return c(1, toTextNodes(markers))
end

local to_label = function(args)
    local title = args[1][1]
    title = string.lower(title)
    title = string.gsub(title, " ", "-")
    return title
end

-- returns heading snippet
local heading = function(level)
    eq = ""
    for _ = 1,level do
        eq = eq .. "="
    end
    return s({trig = "h"..level, desc=" Heading level: "..level},
             fmt(eq..[[ {} <{}>]],
                 {
                     i(1, "Scope"),
                     f(to_label, {1}),
                 }))
end


return {

    heading(1),
    heading(2),
    heading(3),
    heading(4),
    heading(5),

    -- s({trig = "h1", desc="Heading level: 1"},
      -- fmt([[= {} <{}>]],
           -- {
               -- i(1, "Heading 1"),
               -- f(to_label, {1}),
           -- })),

    s({trig = "ref", desc=[[Inserts ref to marker (<label>)]]},
      fmt([[@{}]],
           {
             d(1,
               function()
                   return sn(nil, markers())
               end,
               {}),
           })),
}
