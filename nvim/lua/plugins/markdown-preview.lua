return {
    "iamcco/markdown-preview.nvim",
    lazy = true,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown", "quarto" },
    build = function() vim.fn["mkdp#util#install"]() end,
    config = function()
        vim.g.mkdp_filetypes = { "markdown", "quarto" }
    end
}
