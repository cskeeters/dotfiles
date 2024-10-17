-- Be sure to run TypstPreviewUpdate if there are issues
return {
    enabled = true,
    'chomosuke/typst-preview.nvim',
    lazy = true,
    ft = {'typst'},
    build = function() require 'typst-preview'.update() end,
    -- Binding to only this file type can most easily be done with keys
    keys = {
        { '<C-k>v', '<Cmd>TypstPreview<Cr>',           ft="typst", mode = 'n', silent=true, desc="Toggle Typst Preview" },
        { '<C-k><C-j>', '<Cmd>TypstPreviewSyncCursor<Cr>', ft="typst", mode = 'n', silent=true, desc="Sync Cursor (Typst)" },
    },
    config = function()
        vim.cmd[[TypstPreviewNoFollowCursor]]
    end
}
