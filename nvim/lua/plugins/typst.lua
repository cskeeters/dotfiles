return {
    enabled = false, -- using tree-sitter parser
    'kaarmu/typst.vim',
    ft = 'typst',
    lazy = false,
    init = function()
        vim.g.typst_conceal = 0
        vim.g.typst_conceal_math = 0
        vim.g.typst_conceal_emoji = 0
        vim.g.typst_embedded_languages = 0
    end,
}
