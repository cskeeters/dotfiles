return {
    enabled = false,
    'mhinz/vim-signify',

    keys = {
        {'<LocalLeader>+', '<Cmd>SignifyToggle<Cr>', noremap = true, desc="Toggle Signify (git/hg diff)" },
        {']c', '<plug>(signify-next-hunk)', noremap = true, buffer=true, desc="Next Hunk (Signify)" },
        {'[c', '<plug>(signify-prev-hunk)', noremap = true, buffer=true, desc="Prev Hunk (Signify)" },
    },
}
