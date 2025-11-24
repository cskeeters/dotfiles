return {
    'junegunn/fzf.vim',
    dependencies = {
        {
            'junegunn/fzf',
            build = "./install --all",
        }
    },
    -- In RHEL7, bat cannot be installed, so fzf doesn't work well.
    enabled = true,
    config = function()
        -- bind from FZF_DEFAULT_OPTS do apply but Ctrl+/ doesn't work
        -- print(vim.env.FZF_DEFAULT_OPTS)

        -- Add reverse to default opts
        if vim.env.FZF_DEFAULT_OPTS ~= nil then
            vim.env.FZF_DEFAULT_OPTS = '--reverse '..vim.env.FZF_DEFAULT_OPTS
        else
            vim.env.FZF_DEFAULT_OPTS = '--reverse'
        end

        vim.keymap.set('n', '<Leader>of', ':Files!<cr>',                                      { desc="Open file in current directory tree (fzf)" })
        vim.keymap.set('n', '<Leader>og', ':GitFiles!<cr>',                                   { desc="Open git tracked file (fzf)" })
        vim.keymap.set('n', '<Leader>oc', ':Files! ~/.config/nvim<cr>',                       { desc="Open neovim config file (fzf)" })
        vim.keymap.set('n', '<Leader>op', ':Files! ~/.local/share/nvim<cr>',                  { desc="Open plugin from .local (fzf)" })
        vim.keymap.set('n', '<Leader>on', ':Files! ~/Library/CloudStorage/Dropbox/notes<cr>', { desc="Open note (fzf)" })
        vim.keymap.set('n', '<Leader>od', ':Files! ~/working/bcst-doc<cr>',                   { desc="Open bcst-doc file (fzf)" })
        vim.keymap.set('n', '<Leader>ou',
           ':Files! /opt/homebrew/Cellar/neovim/0.10.4/share/nvim/runtime<cr>',             { desc="Open neovim runtime file (fzf)" })

        vim.keymap.set('n', '<Leader>ob', ':Buffers!<cr>',                                    { desc="Open Buffer (fzf)" })
        vim.keymap.set('n', '<Leader>oo', ':History!<cr>',                                    { desc="Open Old file from history (fzf)" })
        vim.keymap.set('n', '<Leader>or', ':GFiles!<cr>',                                     { desc="Open file in git repository (fzf/git/hg)" })
        vim.keymap.set('n', '<Leader>om', ':GFiles!?<cr>',                                    { desc="Open file modified in repository (fzf/git/hg)" })

        --vim.keymap.set('n', '<Leader>gm', ':Marks!<cr>',     { desc="Open mark (fzf)" })
        --vim.keymap.set('n', '<Leader>k', ':Maps!<cr>',       { desc="Run keymap (fzf)" })
        vim.keymap.set('n', '<Leader>c', ':Commands!<cr>', { desc="Execute Ex command" })
        vim.keymap.set('n', '<Leader>H', ':History!:<cr>', { desc="Execute Ex command from history" })

        --vim.cmd([[nnoremap <expr> <Leader>oa fzf#vim#complete#path('fd --type f --hidden --no-ignore-vcs')]])
    end
}
