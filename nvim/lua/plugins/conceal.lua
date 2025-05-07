return {
    enabled = false,

    -- Local plugin under development
    name="conceal.nvim",
    dir=os.getenv("HOME").."/working/nvim-plugins/conceal.nvim",

    lazy = false,

    dependencies = {
        'libnotify.nvim',
    },

    config = function()
        require('conceal').setup({})

        vim.keymap.set({'n'}, '<Leader>z', require('conceal').enable_unicode, { desc="Enable unicode extmarks" })
    end,
}
