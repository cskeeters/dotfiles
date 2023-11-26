return {
    enabled = true,
    'majutsushi/tagbar',
    lazy=false,
    init = function()
        vim.g.tagbar_autofocus=1
    end,
    keys = {
        {'<Leader>t', ':TagbarToggle<cr>', noremap=true, silent=true, desc="Toggles the Tagbar" },
    }
}
