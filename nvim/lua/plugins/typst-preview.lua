return {
    'chomosuke/typst-preview.nvim',
    lazy = true,
    ft = {'typst'},
    version = '0.1.*',
    build = function() require 'typst-preview'.update() end,
    config = function()
        vim.keymap.set('n', '<C-k>v', '<Cmd>TypstPreviewToggle<Cr>', { buffer=true, silent=true, desc="Toggle Typst Preview" })
    end
}
