-- Disable default java.vim
vim.b.did_ftplugin = 1

-- vim.bo.formatprg='astyle -s4pb'
vim.bo.commentstring = '// %s'

vim.bo.makeprg="gcc -std=c++11 -o %< %"
vim.keymap.set('n', '<C-k>', '<cmd>make | cwindow<cr>', { buffer=true, desc='Compile' })

-- need to 'set clipboard=' when copy and pasting control characters

-- @m macro will convert the current line from a .h style signature into a .cpp style
-- method in cpp
--
-- 1. First copy the class name into the c register
-- 2. Copy the .h signature and move the to .cpp file
-- 3. Paste in the line
-- 3. @m
vim.fn.setreg('m', [[^d0W"cPa::f;xa{}j]])

-- @s macro will convert the current line from a .cpp style signature into a .h
-- style signature
vim.fn.setreg('s', "^Wf:dwdF i A;0j")

-- NOTE: need to 'set clipboard=' when copy and pasting control characters

--vim.notify('Loaded cpp settings')
