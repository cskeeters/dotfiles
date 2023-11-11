return {
    enabled = true,
    'nvim-treesitter/nvim-treesitter',
    keys = {
    },
    init = function()
        require('nvim-treesitter.install').update { with_sync = true }

        require('nvim-treesitter.configs').setup {
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


            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = true,

            highlight = {
                enable = true,
            },
        }
    end,
}
