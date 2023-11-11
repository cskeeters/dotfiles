return {
    enabled=false,
    'SirVer/ultisnips',
    -- tag = '3.2', UltiSnips won't work with tag 3.2
    dependencies = {
        'cskeeters/vim-snippets'
    },

    init = function()
        local data_path = vim.fn.stdpath("data")
        vim.g.UltiSnipsSnippetsDir = data_path.."/site/packer/start/vim-snippets/UltiSnips"

        -- With coq, we need to use something else
        -- vim.g.UltiSnipsExpandTrigger="<tab>"
        -- vim.g.UltiSnipsJumpForwardTrigger="<tab>"
        -- vim.g.UltiSnipsJumpBackwardTrigger="<s-tab>"

        vim.g.UltiSnipsListSnippets="<C-t>"

        vim.g.UltiSnipsExpandTrigger="<C-e>"
        vim.g.UltiSnipsJumpForwardTrigger="<C-n>"
        vim.g.UltiSnipsJumpBackwardTrigger="<C-p>"

        vim.keymap.set('n', '<Leader>es', ':OpenSnips<cr>', { noremap=true, silent=true, desc="Edits the snippets for the file type of the current buffer" })
        vim.keymap.set('n', '<Leader>eu', ':OpenUltiSnips<cr>', { noremap=true, desc="Open UltiSnips file" })
    end,
}
