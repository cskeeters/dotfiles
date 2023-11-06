return {
    enabled = true,
    'mhinz/vim-signify',

    keys = {
        {'<LocalLeader>+', '<Cmd>SignifyToggle<Cr>', noremap = true, desc="Toggle Signify (git/hg diff)" },
    },
}
