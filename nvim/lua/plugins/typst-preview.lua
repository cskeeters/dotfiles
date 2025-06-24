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
        { '<C-k><C-j>', '<Cmd>TypstPreviewSyncCursor<Cr>', ft="typst", mode = 'n', silent=true, desc="Scroll Browswer Preview to Vim Cursor (Typst) (Be on second letter of a word)" },
    },
    config = function()
        require 'typst-preview'.setup({
            -- Setting debug to true will route tinymist's stderr to :messages
            debug = false,
            dependencies_bin = {
                ['tinymist'] = "/opt/homebrew/bin/tinymist",
                -- ['tinymist'] = "/Users/chad/working/src/tinymist/target/release/tinymist",
            },
        })

        vim.cmd[[TypstPreviewNoFollowCursor]]
    end
}
