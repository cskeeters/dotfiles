return {
    enabled = true,
    'mileszs/ack.vim',
    lazy = false,

    init = function()
        if vim.fn.executable('ag') then
            vim.g.ackprg = 'ag --vimgrep'
        end

        vim.keymap.set('n', '<Leader>/', ':LAck <cword><cr>', { noremap=true, desc="Searches directory for the word under the cursor" })

        -- Not using
        vim.keymap.set('n', '<Leader>i/', ':LAckWindow <cword><cr>', { noremap=true, desc="Searches buffers open in current type for the word under the cursor" })
    end,
}
