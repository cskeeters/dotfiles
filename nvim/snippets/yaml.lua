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

local parse_control_id = function(id)
  -- Captures                                               1        2    3     4
  local family, number, _, enhancement = string.match(id, [[([A-Z]+)-(%d+)(%s*\((%d+)\))]])

  if family ~= nil then
    return {
      family=family,
      number=tonumber(number),
      enhancement=tonumber(enhancement),
    }
  end

  -- Captures                               1        2
  local family, number = string.match(id, [[([A-Z]+)-(%d+)]])

  if family ~= nil then
    return {
      family=family,
      number=tonumber(number),
      enhancement=nil,
    }
  end

  error("Could not parse control id: " .. id)
end

local format_control_id = function(id_dict, pad, space)
  local number_str = ""
  local enhancement_str = ""

  if pad then
    number_str = string.format("%02d", id_dict.number)
  else
    number_str = tostring(id_dict.number)
  end

  if id_dict.enhancement ~= nil then
    if space then
      enhancement_str = " "
    end
    if pad then
      enhancement_str = enhancement_str .. string.format("%02d", id_dict.enhancement)
    else
      enhancement_str = enhancement_str .. "(" .. tostring(id_dict.enhancement) .. ")"
    end
  end
  return id_dict.family.."-"..number_str..enhancement_str
end

local get_split = function(str, delim, field)
    print("running get_split")
    local i = 0
    for token in string.gmatch(str, "[^"..delim.."]+") do
        print("got field: "..i)
        if field == i then
            return token
        end
        i = i + 1
    end
    return "NO MATCH"
end

local excel = function(column)
    print("running excel")
    -- Data may be quoted
    local data = get_split(vim.fn.getreg(), '	', column)
    print("got data: "..data)

    local unquoted = string.match(data, [[^"(.*)"$]])
    if unquoted then
        print("returning unquoted")
        return vim.split(unquoted, "\n", { trimempty = false })
    end

    print("returning data: "..data)

    -- LuaSnip will throw if function node returns string with newlines instead of list
    return vim.split(data, "\n", { trimempty = false })
end

local control_id = function()
    -- First line of first column should be the id
    local id_dict = parse_control_id(excel(0)[1])
    return format_control_id(id_dict, true, false)
end

local non_empty = function(t)
    local r = {}
    for _,v in ipairs(t) do
        v = v:gsub("^%s+", "")
        v = v:gsub("%s+$", "")
        if v ~= "" then
            table.insert(r, v)
        end
    end
    return r
end

local get_placeholder = function(desc, n)
    desc = table.concat(desc, " ")
    local p = "%[([^:]*):%s+(.*)%]"
    i = 1
    count = 0
    local si, ei = string.find(desc, p, i)
    while si do
        count = count + 1
        if count == n then
            local _, placeholder = string.match(string.sub(desc, si, ei), p)
            return placeholder
        end

        si, ei = string.find(desc, p, i)
    end
    return "placeholder not found"
end

local odps = function()

    local id_dict = parse_control_id(excel(0)[1])
    local id = format_control_id(id_dict, true, false)

    local lines = {}

    local desc = excel(2)

    local avs = non_empty(excel(3))

    table.insert(lines, "# "..id)
    for i,av in ipairs(avs) do
      table.insert(lines, "- odp: "..id.."_ODP["..string.format("%02d",i).."]")
      table.insert(lines, "  desc: ")
      table.insert(lines, "  placeholder: "..get_placeholder(desc, i))
    end

    table.insert(lines, "")
    table.insert(lines, "# "..id)
    for i,av in ipairs(avs) do
      table.insert(lines, "- odp: "..id.."_ODP["..string.format("%02d",i).."]")
      table.insert(lines, "  value: "..av)
    end

    return lines
end

return {
    s("ctl", fmt([[

  - id: {}
    name: {}
    desc: |-
      {}
    ccis:

  {}

    ]], {
        f(control_id),
        f(function()
            return excel(1)
        end),
        f(function()
            return excel(2)
        end),
        f(odps),
    })),
    s("cci", fmt([[

  - cci: CCI-00{}
    status: {}
    date: {}
    desc: |-
      {}
    ]], {
        i(1, "0000"),
        i(2, "C"),
        f(dt),
        i(3, ""),
    })),
}
