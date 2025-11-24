local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt   -- default delimiters are {}
local conditions = require("luasnip.extras.conditions")

local lfs = require("lfs")

local preview_path = "/Users/chad/Library/Caches/typst/packages/preview"
local local_path = "/Users/chad/Library/Application Support/typst/packages/local"

--- Utilities

local select_raw = function(_, snip)
    return snip.env.LS_SELECT_RAW
end

local select_raw_or_input = function(snip, jump_index)
    jump_index = jump_index or 1

    if #snip.env.LS_SELECT_RAW == 0 then
        return i(jump_index, "")
    end

    local text_nodes = {}
    for _, text in ipairs(snip.env.LS_SELECT_RAW) do
        table.insert(text_nodes, text)
    end

    return t(text_nodes)

end

local MATH_NODES = {
    math = true,
    formula = true,
}

local TEXT_NODES = {
    text = true,
    content = true,
}

local CODE_NODES = {
    code = true,
}

local in_code = function()
    --retrieve the smallest non-anonymous syntax tree node that spans
    --the current cursor position** in the active buffer.
    local node = vim.treesitter.get_node({ ignore_injections = false })

    if node ~= nil then
        print(node:type())
    end

    while node do

        if CODE_NODES[node:type()] then
            vim.notify("Returning TRUE", vim.log.levels.ERROR)
            return true
        elseif TEXT_NODES[node:type()] or MATH_NODES[node:type()] then
            vim.notify("Returning FALSE", vim.log.levels.ERROR)
            return false
        end

        -- Walk up parents
        node = node:parent()
    end
    vim.notify("Returning FALSE", vim.log.levels.ERROR)
    return false
end

local not_in_code = function()
    return not in_code()
end

local in_code_cond = conditions.make_condition(in_code)
local not_in_code_cond = conditions.make_condition(not_in_code)

-- Returns "#" if not in code
local smart_pound = function()
    if not in_code() then
        return "#"
    end

    return ""
end

--- Returns a table of `text_node`s, one for each string
-- @param table of strings
-- @return A table of `text_node`s, one for each string
local to_text_nodes = function(optionStrings)
    local nodes = {}
    for _, option in ipairs(optionStrings) do
        table.insert(nodes, ls.text_node(option))
    end
    return nodes
end

-- Returns a choice_node for markers in the current file
local markers = function()
    local markers = {}
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for _, line in ipairs(lines) do
        local marker = line:match([[<(.*)>]])
        if marker ~= nil then
            table.insert(markers, marker)
        end
    end

    return c(1, to_text_nodes(markers))
end

local alignment_options = function(jump_index)
    jump_index = jump_index or 1

    -- center first since it's common
    local horizantal_alignment = {"center", "right", "left", "start", "end"}
    local vertical_alignment = {"top", "horizon", "bottom"}

    local options = {}
    for _, ha in ipairs(horizantal_alignment) do
        table.insert(options, ha)
    end

    for _, va in ipairs(vertical_alignment) do
        table.insert(options, va)
    end


    for _, ha in ipairs(horizantal_alignment) do
        for _, va in ipairs(vertical_alignment) do
            table.insert(options, ha.."+"..va)
        end
    end

    return c(jump_index, to_text_nodes(options))
end

local to_label = function(args)
    local title = args[1][1]
    title = string.lower(title)
    title = string.gsub(title, " ", "-")
    return title
end



--- Returns a table of all directory names within a given path.
-- @param directory_path The path to the directory to scan.
-- @return A table containing the names of the subdirectories.
local function get_folder_names(directory_path)
    if lfs.attributes(directory_path, "mode") ~= "directory" then
        -- Handle case where the specified path is not a directory
        return {}
    end

    local folders = {}
    for entry in lfs.dir(directory_path) do
        -- lfs.dir() iterator includes "." and ".." for the current and parent directories.
        -- We must skip these special entries.
        if entry ~= "." and entry ~= ".." then
            local path_to_check = directory_path .. "/" .. entry
            local mode = lfs.attributes(path_to_check, "mode")
            if mode == "directory" then
                table.insert(folders, entry)
            end
        end
    end

    return folders
end

-- Returns a choice_node for packages in path
local function package_options(path, jump_index)
    jump_index = jump_index or 1

    -- local latest_version = find_latest_version(versions)

    local package_options = {}
    for _, package_name in ipairs(get_folder_names(path)) do
        for _, version_name in ipairs(get_folder_names(path.."/"..package_name)) do
            table.insert(package_options, package_name..":"..version_name)
        end
    end

    return c(jump_index, to_text_nodes(package_options))
end


local function local_package_names()
    -- Example usage for the specified directory
    local local_packages = get_folder_names(local_packages_path)

    -- Print the results
    if #local_packages > 0 then
        print("Found the following local Typst packages:")
        for _, name in ipairs(local_packages) do
            print(" - " .. name)
        end
    else
        print("No local Typst packages found in " .. local_packages_path)
    end
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

-- Returns table of choice nodes
local function font_features(jump_index)
    jump_index = jump_index or 1

    local features = {
        "aalt", -- Access all Alternates
        "case", -- ## Case sensitive Forms
        "cpsp", -- Spacing for All Cap Text
        "cswh", -- Contextual Swash
        "c2sc", -- Small Capitals from Capitals
        "dlig", -- Discretionary Ligatures
        "dnom", -- Denominators
        "frac", -- Fractions
        "hist", -- Historical Forms
        "hlig", -- Historical Ligatures
        "kern", -- Kerning (Default on)
        "liga", -- Standard Ligatures (Default on)
        "lnum", -- Lining Figures
        "locl", -- Localized Forms
        "numr", -- Numerators
        "onum", -- Oldstyle Figures
        "ordn", -- Ordinals (No. feminine ordinal indicator ª and masculine ordinal indicator º)
        "ornm", -- Ornaments
        "pnum", -- Proportional Figures
        "salt", -- Stylistic Alternates
        "size", -- Optical size
        "smcp", -- Small Capitals

        "ss01", -- Stylistic Set 01
        "ss02", -- Stylistic Set 02
        "ss03", -- Stylistic Set 03
        "ss04", -- Stylistic Set 04
        "ss05", -- Stylistic Set 05
        "ss06", -- Stylistic Set 06
        "ss07", -- Stylistic Set 07
        "ss08", -- Stylistic Set 08
        "ss09", -- Stylistic Set 09
        "ss10", -- Stylistic Set 10
        "ss11", -- Stylistic Set 11
        "ss12", -- Stylistic Set 12
        "ss13", -- Stylistic Set 13
        "ss14", -- Stylistic Set 14
        "ss15", -- Stylistic Set 15
        "ss16", -- Stylistic Set 16
        "ss17", -- Stylistic Set 17
        "ss18", -- Stylistic Set 18
        "ss19", -- Stylistic Set 19
        "ss20", -- Stylistic Set 20

        "sinf", -- Scientific Inferiors
        "sups", -- Scientific Superior (Superscript)
        "swsh", -- Swashes
        "titl", -- Titling
        "tnum", -- Tabular Figures
        "zero", -- Slashed Zero
    }

    return to_text_nodes(features)
end

return {
    -- simple utilities

    s(
        {trig = "i", desc="Italic (text attribute)"},
        {t([[style: "italic"]])}
    ),

    s(
        {trig = "b", desc="Bold (text attribute)"},
        {t([[weight: 700]])}
    ),

    s(
        {trig = "text", desc="text (content)"},
        fmt([=[#text({})[{}]]=],
            {
                i(2, ""),
                d(1,
                    function(args, snip)
                        return sn(nil, select_raw_or_input(snip))
                    end,
                    {}),
            }
        ),
        { condition = not_in_code_cond }
    ),

    s(
        {trig = "text", desc="text (code)"},
        fmt([=[text({}, {})]=],
            {
                i(2, ""),
                d(1,
                    function(args, snip)
                        return sn(nil, select_raw_or_input(snip))
                    end,
                    {}),
            }
        ),
        { condition = in_code_cond }
    ),

    s(
        {trig = "f", desc="Font Feature"},
        fmt([["{}", ]],
            {
                c(1, font_features()),
            }
        )
    ),

    -- s({trig = "h1", desc="Heading level: 1"},
    -- fmt([[= {} <{}>]],
    -- {
    --     i(1, "Heading 1"),
    --     f(to_label, {1}),
    -- })),

    heading(1),
    heading(2),
    heading(3),
    heading(4),
    heading(5),

    s({trig = "ref", desc=[[Inserts ref to marker (<label>)]]},
        -- "@label" is the format of a marker
        fmt([[@{}]],
        {
            d(1,
            function()
                return sn(nil, markers())
            end,
            {}),
        })),

    s({trig = "lb", desc=[[Line Break]]},
        {
            f(smart_pound),
            t("linebreak()"),
        }
    ),
    s({trig = "pb", desc=[[Page Break]]},
        {
            f(smart_pound),
            t([[pagebreak(weak: true)]]),
        }
    ),
    s({trig = "import_local", desc=[[Import Local]]},
        {
            -- return dynamic_node so it's evaluated when expanded
            d(1, function ()
                return sn(nil, {
                    f(smart_pound),
                    t([[import "@local/]]),
                    package_options(local_path),
                    t([[": *]]),
                })
            end)
        }
    ),
    s({trig = "import_preview", desc=[[Import Preview]]},
        {
            -- return dynamic_node so it's evaluated when expanded
            d(1, function ()
                return sn(nil, {
                    f(smart_pound),
                    t([[import "@preview/]]),
                    package_options(preview_path),
                    t([[": *]]),
                })
            end)
        }
    ),

    s(
        {trig = "grid", desc=[[Grid]]},
        fmt([[
            {}grid(
                columns: (1fr, 1fr),

                //gutter: 5pt,
                row-gutter: 5pt,
                column-gutter: 5pt,

                [Left],
                [Right]
            )
            ]],
            {
                f(smart_pound),
            },
            {
                indent_string = "    "
            }
        )
    ),

    s(
        {trig = "signature", desc=[[Signature]]},
        fmt([[
            {}grid(
                align: (left+bottom, bottom),
                columns: (1fr, auto),
                {{}},
                box(
                    align(left, {{
                        set block(spacing: 5pt)
                        v(1in) // Height of signature
                        line(stroke:1.5pt, length:3.5in)
                        text(weight: 500, upper([Chad Skeeters, Program Manager]))
                    }})
                )
            )
            ]],
            {
                f(smart_pound),
            },
            {
                indent_string = "    " -- indent prefix for format
            }
        )
    ),

    s(
        {trig = "align", desc="Align"},
        fmt([=[#align({})[{}]]=],
            {
                d(1,
                    function()
                        return sn(nil, alignment_options())
                    end,
                    {}),
                d(2,
                    function(args, snip)
                        return sn(nil, select_raw_or_input(snip))
                    end,
                    {}),
            }
        ),
        { condition = not_in_code_cond }
    ),

    s(
        {trig = "align", desc="Align"},
        fmt([[
            align({},
                {}
            )]],
            {
                d(1,
                    function()
                        return sn(nil, alignment_options())
                    end,
                    {}),
                d(2,
                    function(args, snip)
                        return sn(nil, select_raw_or_input(snip))
                    end,
                    {}),
            }
        ),
        { condition = in_code_cond }
    ),


    s(
        {trig = "center", desc="Center"},
        fmt("#align(center)[{}]",
            {
                f(select_raw),
            }
        ),
        { condition = not_in_code_cond }
    ),

    s(
        {trig = "center", desc="Center"},
        fmt([[
            align(center,
                {}
            )]],
            {
                f(select_raw),
            },
            {
                indent_string = "    " -- indent prefix for format
            }
        ),
        { condition = in_code_cond }
    ),

    s(
        {trig = "right", desc="Right"},
        fmt("#align(right)[{}]",
            {
                f(select_raw),
            }
        ),
        { condition = not_in_code_cond }
    ),



    ---- RCC Specific

    s(
        {trig = "rcc_logo", desc="RCC Logo"},
        fmt([[
                {}import "@local/rcc:0.1.0": *
                {}rcc_logo(width:100pt)
            ]],
            {
                f(smart_pound),
                f(smart_pound),
            })
    ),

    s(
        {trig = "rch_logo", desc="RCH Logo"},
        fmt([[
                {}import "@local/rch:0.1.0": *
                {}rch_logo(width:100pt)
            ]],
            {
                f(smart_pound),
                f(smart_pound),
            })
    ),

}
