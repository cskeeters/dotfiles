return {
    'junegunn/fzf.vim',
    dependencies = {
        {
        'junegunn/fzf',
        build = "./install --all",
        }
    },
    enabled = false,
    config = function()
        print(vim.env.FZF_DEFAULT_OPTS)

        vim.keymap.set('n', '<Leader>of', ':FZF! --reverse <cr>',     { desc="Open file in current directory tree (fzf)" })
        vim.keymap.set('n', '<Leader>oc', ':FZF! --reverse ~/.config/nvim<cr>',     { desc="Open file in current directory tree (fzf)" })
        vim.keymap.set('n', '<Leader>op', ':FZF! --reverse ~/.local/share/nvim<cr>',     { desc="Open file in current directory tree (fzf)" })
        vim.keymap.set('n', '<Leader>on', ':FZF! --reverse ~/Library/CloudStorage/Dropbox/notes<cr>',     { desc="Open file in current directory tree (fzf)" })
    end
}
