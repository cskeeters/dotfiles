-- Be sure to run TypstPreviewUpdate if there are issues
return {
    enabled = true,
    'chomosuke/typst-preview.nvim',
    lazy = true,
    ft = {'typst'},
    build = function() require 'typst-preview'.update() end,
    config = function()
        vim.keymap.set('n', '<C-k>v', '<Cmd>TypstPreviewToggle<Cr>', { buffer=true, silent=true, desc="Toggle Typst Preview" })
    end
}
