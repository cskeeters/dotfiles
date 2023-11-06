-- Disable default java.vim
if vim.b.did_ftplugin ~= 1 then
    vim.b.did_ftplugin = 1

    vim.bo.commentstring = '// %s'

    -- Not needed because: cskeeters/vim-make
    -- :compiler ant

    -- Running the macro @i will convert the contents in the clipboard from a copy
    -- of the class name from javadoc into an import statement.
    --
    -- 1. First copy the package and class name from javadoc
    -- 2. Move the cursor where you want the import
    -- 3. @i
    vim.fn.setreg('i', [[i*a;kkIimport Jcf .]])
end
