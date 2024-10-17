local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta

--- Conditions

-- NOTE: Don't have vimtex installed
-- local env = function(name)
--     local is_inside = vim.fn["vimtex#env#is_inside"](name)
--     return (is_inside[1] > 0 and is_inside[2] > 0)
-- end
-- 
-- local in_math = function()
--     return vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 1
-- end
-- 
-- local in_text = function()
--     return env("document") and not in_math()
-- end
-- 
-- local in_comment = function()
--     return vim.fn["vimtex#syntax#in_comment"]() == 1
-- end
-- 
-- local in_preamble = function()
--     return not env("document")
-- end
-- 
-- local in_tikz = function()
--     return env("tikzpicture")
-- end
-- 
-- local in_bullets = function()
--     return env("itemize") or env("enumerate")
-- end
-- 
-- local in_align = function()
--     return env("align") or env("align*") or env("aligned")
-- end

--- Utilities

local toTextNodes = function(optionStrings)
    local nodes = {}
    for _, account in ipairs(optionStrings) do
        table.insert(nodes, t(account))
    end
    return nodes
end

-- returns choice node for markers in the current file
local markers = function()
    local markers = {}
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for _, line in ipairs(lines) do
        local marker = line:match([[\label{(.*)}]])
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
local heading = function(trig, command, name, level)
    return s({trig = trig, desc=name.." Heading level: "..level},
      fmta(command..[[{<>} \label{<>}]],
           {
               i(1, name.." 1"),
               f(to_label, {1}),
           }))
end

return {

    ---- Headings

    heading("p", [[\part]], "Part", -1),
    heading("c", [[\chapter]], "Chapter", 0),
    heading("s", [[\subsection]], "Section", 1),
    heading("ss", [[\subsubsection]], "Sub Section", 2),
    heading("sss", [[\subsubsection]], "Sub Sub Section", 3),
    heading("par", [[\paragraph]], "Paragraph", 4),
    heading("sp", [[\subparagraph]], "Sub Paragraph", 5),

    ---- Markers

    s({trig = "ar", desc=[[Inserts autoref to marker (\label)]]},
      fmta([[\autoref{<>}]],
           {
             d(1,
               function()
                   return sn(nil, markers())
               end,
               {}),
           })),

    s({trig = "pr", desc=[[Inserts page reference to marker (\label)]]},
      fmta([[\pageref{<>}]],
           {
             d(1,
               function()
                   return sn(nil, markers())
               end,
               {}),
           })),

    s({trig = "hr"},
      fmta([[\hyperref[<>]{<>}]],
           {
             d(1,
               function()
                   return sn(nil, markers())
               end,
               {}),
             i(2)
           })),
}
