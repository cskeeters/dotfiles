return {
    enabled = true,
    'rebelot/kanagawa.nvim',
    init = function() -- must be disabled for ttyd/vhs
        -- Default options:
        require('kanagawa').setup({
            compile = false,             -- enable compiling the colorscheme
            undercurl = true,            -- enable undercurls
            commentStyle = { italic = true },
            functionStyle = {},
            keywordStyle = { italic = true},
            statementStyle = { bold = true },
            typeStyle = {},
            transparent = false,         -- do not set background color
            dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
            terminalColors = true,       -- define vim.g.terminal_color_{0,17}
            colors = {                   -- add/modify theme and palette colors
                palette = {},
                theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
            },
            overrides = function(colors) -- add/modify highlights
                return {
                    -- Make Conceal a bit darker to indicate difference
                    Conceal = { fg = colors.palette.dragonBlack6, bold = false },

                    ["@markup.heading"] = { link = "Number" },
                    ["@markup.heading.1"] = { link = "ModeMsg" },
                    ["@markup.heading.2"] = { link = "Boolean" },
                    ["@markup.heading.3"] = { link = "Constant" },

                    ["@markup.strong"] = { fg = colors.theme.syn.operator, bold = true },
                    ["@markup.italic"] = { fg = colors.theme.syn.identifier, italic = true },

                    ["@markup.raw"] = { fg = colors.theme.syn.string },
                    ["@markup.raw.block"] = { fg = colors.theme.syn.string },

                    ["@markup.link.label"] = { link = "PreProc" },
                    ["@markup.link.url"] = { link = "Whitespace" },
                }
            end,
            theme = "dragon",              -- Load "wave" theme when 'background' option is not set
            background = {                 -- map the value of 'background' option to a theme
                dark = "dragon",           -- try "dragon" !
                light = "lotus"
            },
        })

        -- setup must be called before loading
        vim.cmd("colorscheme kanagawa")
    end
}
