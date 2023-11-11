return {
    enabled = true,
    'jlfwong/vim-mercenary',
    lazy = false,
    keys = {
        {'<LocalLeader>mb', ':HGblame<cr>', noremap = true, desc="Toggle blame (hg blame)"},
    },
}
