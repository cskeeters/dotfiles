return {
    enabled = false,
    'justinmk/vim-dirvish',
    keys = {
        {'-', '<Plug>(dirvish_up)', noremap=true, desc="Opens the <count> directory above the current buffer" },
    },
    init = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
    end,
}
