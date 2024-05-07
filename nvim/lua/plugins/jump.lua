return {
    enabled = true,
    lazy = false,
    'cskeeters/vim-jump',
    keys = {
        {'<Leader>gj', '<Plug>Jump', silent=true, desc="Jump (according to current line," },

        {'<Leader>mz', ':call GetMark("z")<cr>', noremap=true, desc="Save jump line to z register" },
        {'<Leader>mx', ':call GetMark("x")<cr>', noremap=true, desc="Save jump line to x register" },
        {'<Leader>mc', ':call GetMark("c")<cr>', noremap=true, desc="Save jump line to c register" },
        {'<Leader>mv', ':call GetMark("v")<cr>', noremap=true, desc="Save jump line to v register" },

        {'<LocalLeader>z', ':put z<cr>', noremap=true, desc="Paste jump line from z register" },
        {'<LocalLeader>x', ':put x<cr>', noremap=true, desc="Paste jump line from x register" },
        {'<LocalLeader>c', ':put c<cr>', noremap=true, desc="Paste jump line from c register" },
        {'<LocalLeader>v', ':put v<cr>', noremap=true, desc="Paste jump line from v register" },
    }
}

