return {
    enabled = true,
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    keys = {
    },
    init = function()
        require'nvim-treesitter.configs'.setup {
            modules = {},

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- A list of parser names, or "all" (the four listed parsers should always be installed)
            -- Fenced code blocks in markdown documentation will be highlighted if the language is in this list
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "css",
                "diff",
                "go",
                "html",
                "java",
                "javascript",
                "latex",
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
                "yaml",
            },

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = false,

            ignore_install = {},

            highlight = {
                enable = true,
                -- In case treesitter is not working fully for markdown, uncomment this
                -- additional_vim_regex_highlighting = {'markdown','markdown_inline'},
            },

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gss",
                    node_incremental = "gsn",
                    scope_incremental = "gsc",
                    node_decremental = "gsm",
                }
            },
        }
    end,
}
