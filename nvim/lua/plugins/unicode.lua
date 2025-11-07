return {
    enabled = true,
    'cskeeters/unicode.nvim',
    lazy = false, -- Not lazy so that Unicode characters can be loaded asynchronously

    -- Local plugin under development
    -- name="unicode.nvim",
    -- dir=os.getenv("HOME").."/working/nvim-plugins/unicode.nvim",

    keys = {
      { "<leader><leader>u", function()
          require('unicode').select_unicode()
      end, desc = "Select Unicode" },
    },
    opts = {
        notify_min_level = vim.log.levels.ERROR,
    },
}
