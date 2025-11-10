-- function is required so that require('unicode') will only execute when key
-- is pressed after lua is initialized.
function SelectUnicode()
    require('unicode').select_unicode()
end

return {
    enabled = true,
    'cskeeters/unicode.nvim',
    lazy = false, -- Not lazy so that Unicode characters can be loaded asynchronously

    -- Local plugin under development
    -- name="unicode.nvim",
    -- dir=os.getenv("HOME").."/working/nvim-plugins/unicode.nvim",

    keys = {
      { mode = {"n", "i"}, "<C-S-u>", SelectUnicode, desc = "Select Unicode" },
    },
    opts = {
        notify_min_level = vim.log.levels.TRACE,
    },
}
