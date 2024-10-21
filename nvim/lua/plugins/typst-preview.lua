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
        require 'typst-preview'.setup({
            -- Setting debug to true will route tinymist's stderr to :messages
            debug = true,
            dependencies_bin = {
                ['tinymist'] = "/opt/homebrew/bin/tinymist",
            },
        })

        vim.cmd[[TypstPreviewNoFollowCursor]]
    end
}
