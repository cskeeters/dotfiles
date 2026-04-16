return {
    enabled = true,
    'romus204/tree-sitter-manager.nvim',
    dependencies = {}, -- tree-sitter CLI must be installed system-wide: brew install tree-sitter-cli
    config = function()
        require("tree-sitter-manager").setup({
            -- Default Options
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "css",
                "diff",
                "go",
                "html",
                "ini",
                "java",
                "javascript",
                "json",
                -- "latex",
                "lua",
                "make",
                "markdown",
                "markdown_inline",
                "php",
                "pug",
                "rst",
                "rust",
                "sql",
                "toml",
                "typst",
                "vhs",
                "vim",
                "vimdoc",
                "yaml",
            },
            -- border = nil, -- border style for the window (e.g. "rounded", "single"), if nil, use the default border style defined by 'vim.o.winborder'. See :h 'winborder' for more info.
            -- auto_install = false, -- if enabled, install missing parsers when editing a new file
            -- highlight = true, -- treesitter highlighting is enabled by default
            -- languages = {}, -- override or add new parser sources
            -- parser_dir = vim.fn.stdpath("data") .. "/site/parser",
            -- query_dir = vim.fn.stdpath("data") .. "/site/queries",
        })
    end
}
