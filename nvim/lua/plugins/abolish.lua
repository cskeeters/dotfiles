return {
    'tpope/vim-abolish',
    lazy = false,
    keys = {
        -- these are here so that they can be searched for
        -- In theory, I should only have to put 'crs' instead of :normal crs<cr>, but it doesn't work otherwise
        { "<localleader><localleader>crs", "<cmd>normal crs<cr>", noremap=false, desc = "Word to snake_case" },
        { "<localleader><localleader>crm", "<cmd>normal crm<cr>", noremap=false, desc = "Word to MixedCase" },
        { "<localleader><localleader>crc", "<cmd>normal crc<cr>", noremap=false, desc = "Word to camelCase" },
        { "<localleader><localleader>cru", "<cmd>normal cru<cr>", noremap=false, desc = "Word to UPPER_CASE" },
    }
}
