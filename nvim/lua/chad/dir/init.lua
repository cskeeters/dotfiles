function DirUp(cnt)
    if cnt == 0 then
        vim.cmd([[:lcd ..]])
    else
        vim.cmd([[:lcd ..]])
        for i = 1, cnt, 1 do
            vim.cmd([[:lcd ..]])
        end
    end
end

vim.keymap.set('n', '<Leader>.',  ':lcd %:p:h<cr>',          { noremap=true, desc="Change directory containing current buffer" })
vim.cmd([[command! -nargs=1 FooCmd call DirUp(<args>)]])
vim.keymap.set('n', '<Leader>u', ':<C-U>lua DirUp(vim.v.count)<cr>', {noremap=true, desc="Change directory to parent" })

-- local data_path = vim.fn.stdpath("data")
-- vim.keymap.set('n', '<Leader>u', ':<C-U>lua DirUp(vim.v.count)<cr>', {noremap=true, desc="Change directory to parent" })
