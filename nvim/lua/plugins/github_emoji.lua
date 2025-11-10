-- function is required so that require('github_emoji') will only execute when key
-- is pressed after Lua is initialized.
function SelectEmoji()
    require('github_emoji').select_emoji()
end

return {
    enabled = true,
    'cskeeters/github_emoji.nvim',
    lazy = false, -- Not lazy so that emoji can be loaded asynchronously

    -- Local plugin under development
    -- name="github_emoji.nvim",
    -- dir=os.getenv("HOME").."/working/nvim-plugins/github_emoji.nvim",

    keys = {
      { mode = {"n", "i"}, "<C-S-e>", SelectEmoji, desc = "Select GitHub Emoji" },
    },
    opts = {
        notify_min_level = vim.log.levels.INFO,
    },
}
