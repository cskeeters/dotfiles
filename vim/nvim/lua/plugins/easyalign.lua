return {
    enabled = true,
    'junegunn/vim-easy-align',
    lazy = false,
    keys = {
        -- vipga= : Select paragraph (vip)  Trigger easiy align: ga Choose alignment character =
        {'ga', '<Plug>(EasyAlign)', desc="Align (gaip=) (ga3j=)" },

        {'gat', 'vip:EasyAlign<cr>*<Bar>', desc="Align Markdown table" },
        {'gat', ':EasyAlign<cr>*<Bar>', desc="Align Markdown table" },

        {'ga=', 'vip:EasyAlign<cr>=', desc="Align assignment (gaip=) (ga3j=)" },
        {'ga=', ':EasyAlign<cr>=', desc="Align assignment (gaip=) (ga3j=)" },
    },
}
