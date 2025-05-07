
return {
    enabled = true,

    -- Local plugin under development
    name="unicode.nvim",
    dir=os.getenv("HOME").."/working/nvim-plugins/unicode.nvim",

    lazy = false,

    config = function()
        require('unicode').setup({})

        vim.keymap.set('n', '<leader><leader>u', require('unicode').select_unicode, { desc="Select Unicode" })

    end,
}
