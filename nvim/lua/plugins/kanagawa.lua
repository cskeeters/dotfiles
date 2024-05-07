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
                    -- Override bold and italic for markdown
                    ["@markup.strong"] = { fg = colors.theme.syn.operator, bold = true },
                    ["@markup.italic"] = { fg = colors.theme.syn.identifier, italic = true },
                    ["@markup.raw"] = { fg = colors.theme.syn.string },
                    ["@markup.raw.block"] = { fg = colors.theme.syn.string },
                    ["@markup.link.label"] = { fg = colors.theme.syn.operator },
                    ["@markup.link.url"] = { fg = colors.theme.syn.string },
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
