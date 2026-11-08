-- Disable default java.vim
if vim.b.did_ftplugin ~= 1 then
    vim.b.did_ftplugin = 1

    vim.bo.commentstring = '// %s'
end
