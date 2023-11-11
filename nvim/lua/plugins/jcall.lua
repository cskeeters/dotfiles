return {
    enabled = false,
    ft = java,
    'cskeeters/jcall.vim',
    keys = {
        {'<Leader>ch',  '<Plug>JCallOpen',  buffer=true, ft='java', desc='Populates the quickfix window with calls to the method under the cursor'},
        {'f3',          '<Plug>JCallJump',  buffer=true, ft='java', desc='Jump to method definition'},
        {'<Leader>cch', '<Plug>JCallClear', buffer=true, ft='java', desc='Clears the cashe for the current project'},
    },
}
