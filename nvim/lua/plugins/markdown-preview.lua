return {
    "iamcco/markdown-preview.nvim",
    lazy = true,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
    config = function()
        vim.keymap.set('n', '<C-k>v', '<Cmd>MarkdownPreviewToggle<Cr>', { noremap=true, silent=true, desc="Toggle Markdown Preview" })
    end
}
