return {
    enabled = false,
    'preservim/vim-markdown',
    lazy=false;
    keys = {
    },
    init = function()
        vim.g.vim_markdown_follow_anchor = 1
        vim.g.vim_markdown_anchorexpr = "'<<'.v:anchor.'>>'"
        vim.g.vim_markdown_folding_disabled = 1
    end,
}
