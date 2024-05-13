return {
    enabled = false,
    'cskeeters/vim-status',
    dependencies = {
        'cskeeters/vim-vcvars'
    },

    keys = {
        {'<C-j>s', ':OpenStatus<cr>', silent=true, desc="Opens a buffer showing which files have been modified in the drcs (status)" },
    }
}
