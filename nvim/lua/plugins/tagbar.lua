return {
    enabled = true,
    'majutsushi/tagbar',
    lazy=false,
    init = function()
        vim.g.tagbar_autofocus=1
        vim.g.tagbar_autoclose=1
        vim.g.tagbar_ctags_bin = '/usr/local/bin/ctags'
    end,
    keys = {
        {'<Leader>T', ':TagbarToggle<cr>', noremap=true, silent=true, desc="Toggles the Tagbar" },
    }
}
