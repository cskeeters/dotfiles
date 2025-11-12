vim.opt_local.wrap = true
-- vim.opt.showbreak = "   "  -- When text is indented, it will be sub indented to work well for numbered and bulleted lists

-- Support words in kebab-case
vim.opt.iskeyword:append('-')

-- This doesn't work
-- table.insert(vim.opt_local.briopt,'list:-1')
vim.opt_local.briopt="list:-1"
vim.opt_local.formatlistpat="^\\s*\\d\\+\\.\\s\\+\\|^\\s*[-*+]\\s\\+\\|^\\[^\\ze[^\\]]\\+\\]:\\&^.\\{4\\}\\|^[>[:space:]]\\+\\s\\+"


if vim.fn.has("patch-7.4-353") == 0 then
    vim.bo.list = false
end

-- Atx style Headers (I don't really need these)
vim.keymap.set('n', '<LocalLeader>1', [[I= <Esc>$F#xd0i=<Esc>0]], { buffer=true, desc='# Heading 1' })
vim.keymap.set('n', '<LocalLeader>2', [[I= <Esc>$F#xd0i==<Esc>0]], { buffer=true, desc='## Heading 2' })
vim.keymap.set('n', '<LocalLeader>3', [[I= <Esc>$F#xd0i===<Esc>0]], { buffer=true, desc='### Heading 3' })
vim.keymap.set('n', '<LocalLeader>4', [[I= <Esc>$F#xd0i====<Esc>0]], { buffer=true, desc='#### Heading 4' })
vim.keymap.set('n', '<LocalLeader>5', [[I= <Esc>$F#xd0i=====<Esc>0]], { buffer=true, desc='##### Heading 5' })

-- Text styling Bold Italic Fixed-width
-- Note: "_yiw moves cursor to the beginning of the word affecting any registers.  B doen't work when cursor is already on the first character
-- Note: Changed E to e because punctuation is more of a problem than hyphens in words needing style
vim.keymap.set('n', '<LocalLeader>b', [["_yiWi*<Esc>ea*<Esc>]], { buffer=true, desc='Bold word under cursor' })
vim.keymap.set('n', '<LocalLeader>i', [["_yiWi_<Esc>ea_<Esc>]], { buffer=true, desc='Italicize word under cursor' })
vim.keymap.set('n', '<LocalLeader>`', [["_yiWi`<Esc>ea`<Esc>]], { buffer=true, desc='Monospace word under cursor' })

vim.keymap.set('v', '<LocalLeader>b', [[s*<C-r>"*<Esc>]], { buffer=true, desc='Bold selected text' })
vim.keymap.set('v', '<LocalLeader>i', [[s_<C-r>"_<Esc>]], { buffer=true, desc='Italicize selected text' })
vim.keymap.set('v', '<LocalLeader>`', [[s`<C-r>"`<Esc>]], { buffer=true, desc='Monospace selected text' })

-- Links
vim.keymap.set('n', '<LocalLeader>[', [[yiwi[<Esc>ea](<C-r>")<Esc>]], { buffer=true, desc='Makes word a [link](url)' })
vim.keymap.set('n', '<LocalLeader>a', [[lBi<<Esc>Ea><Esc>]],          { buffer=true, desc='Makes word a <link>' })

vim.keymap.set('v', '<LocalLeader>[', [[s[<C-r>"]()<Esc>i]], { buffer=true, desc='Makes selected text a [link](url)' })
vim.keymap.set('v', '<LocalLeader>l', [[s<<C-r>"><Esc>]],    { buffer=true, desc='Makes selected text a <link>' })

-- build
function typst_compile_open(app)
    return function()

        local uv = vim.uv

        -- This ensures that files can have single quotes in the filenames
        local src = vim.fn.shellescape(vim.fn.expand("%"))
        local out = vim.fn.shellescape(vim.fn.expand("%:r"))..".pdf"
        vim.cmd.update()

        -- Run and show error message
        -- local open = 'open ' .. out
        -- if app ~= nil then
        --     open = 'open -a '..app..' '..out
        -- end
        -- local cmd = 'typst compile '..src..' '..out..' && '..open
        -- vim.cmd("!"..cmd)

        -- execute, no error message
        -- local err = os.execute(cmd)
        -- if err == 0 then
            -- if app == nil then
                -- os.execute('open '..out)
            -- else
                -- os.execute('open -a '..app..' '..out)
            -- end
        -- else
            -- vim.notify("typst_compile_open: Error executing: "..cmd, vim.log.levels.ERROR)
        -- end


        local stdout = uv.new_pipe()
        local stderr = uv.new_pipe()

        -- local cmd = 'typst compile '..src..' '..out
        local cmd = 'echo "hi"'
        local err = {}

        local handle, pid = uv.spawn('typst', {
            args = {
                'compile',
                vim.fn.expand("%"),
                vim.fn.expand("%:r")..".pdf",
            },
            stdio = {nil, stdout, stderr}
        }, function(code, signal) -- on exit
            if code == 0 then
                vim.notify("typst_compile_open: Successfully built: "..out, vim.log.levels.INFO)
                local open = 'open ' .. out
                if app ~= nil then
                    open = 'open -a "'..app..'" '..out
                end
                os.execute(open)
            else
                vim.notify("typst_compile_open: "..out, vim.log.levels.INFO)

                uv.read_start(stderr, function(err, data)
                    if err then
                        vim.notify("typst_compile_open: Error reading stderr", vim.log.levels.ERROR)
                    else
                        if data then
                            vim.notify("typst_compile_open: Error building: "..out.."\n"..data, vim.log.levels.ERROR)
                        end
                    end
                end)

            end

            -- print("exit code", code)
            -- print("exit signal", signal)
        end)

        vim.notify("typst_compile_open: Compiling: "..vim.fn.expand("%"), vim.log.levels.INFO)

        -- uv.shutdown(stdin, function()
            -- print("stdin shutdown", stdin)
            -- uv.close(handle, function()
                -- print("process closed", handle, pid)
            -- end)
        -- end)


    end
end

vim.keymap.set('n', '<C-k>d', typst_compile_open("Adobe Acrobat.app"), { buffer=true, desc='Build/Compile to PDF, open in Default app (Acrobat)' })
vim.keymap.set('n', '<C-k>p', typst_compile_open("Preview.app"), { buffer=true, desc='Build/Compile to PDF, open in Preview.app' })
