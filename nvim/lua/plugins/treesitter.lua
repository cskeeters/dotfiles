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
            ensure_installed = {
                "c",
                "cpp",
                "css",
                "go",
                "html",
                "java",
                "javascript",
                "lua",
                "make",
                "markdown",
                "markdown_inline",
                "php",
                "pug",
                "rst",
                "rust",
                "sql",
                "vhs",
                "vim",
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
