vim.bo.commentstring = '" %s'

-- This is better and simpler
vim.bo.keywordprg = ":help"

--local function VimHelp()
--    local word=vim.fn.expand("<cword>")
--    local line=vim.fn.getline(".")
--
--    --if line =~ '&'..word || line =~ 'set'
--    --    vim.fn.execute("help '"..word.."'")
--    --    return
--    --end
--    i, j = string.find(line, word..'(')
--    vim.notify(tostring(i))
--    vim.notify(tostring(j))
--
--    if (i ~= nil) then
--        vim.fn.execute("echo help "..word.."()")
--        return
--    end
--
--    vim.fn.execute("help "..word)
--end

--vim.keymap.set('n', 'K', VimHelp, { buffer=true, desc='Open VimHelp for the word under the cursor' })
