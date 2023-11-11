return  {
    enabled = true,
    'cskeeters/vim-make',
    dependencies = {
        'cskeeters/vim-vcvars'
    },
    lazy = false;
    keys = {
        {'g<C-k>', ':RootBuild<cr>', desc="Change directory to the root and run make" },
    },
}
