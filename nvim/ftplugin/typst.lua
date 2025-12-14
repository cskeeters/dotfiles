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

        -- Save the buffer for external compilation
        vim.cmd.update()

        -- No need to use shellescape for vim.system
        local typ_filename = vim.fn.expand("%")
        local pdf_filename = vim.fn.expand("%:r")..".pdf"

        -- This must be called outside of vim.system
        local escaped_pdf_filename = vim.fn.shellescape(pdf_filename)
        local open_cmd = 'open ' .. pdf_filename
        if app ~= nil then
            open_cmd = 'open -a "'..app..'" '.. escaped_pdf_filename
        end

        local sys_obj = vim.system({'typst',
                'compile',
                typ_filename,
                pdf_filename,
            }, { text = true}, function(exit_obj)
                vim.schedule(function()
                    if exit_obj.code == 0 then
                        vim.notify("typst_compile_open: Successfully built: "..pdf_filename, vim.log.levels.INFO)

                        -- open the PDF
                        os.execute(open_cmd)
                    else
                        vim.notify("typst_compile_open: Error compiling "..typ_filename, vim.log.levels.ERROR)
                        -- vim.cmd.echom((exit_obj.stderr or ""))
                        vim.ui.input((exit_obj.stderr or "") .. "\n\n[Press Enter to continue]")
                    end
                end)
            end)

        vim.notify("typst_compile_open: Compiling: "..vim.fn.expand("%"), vim.log.levels.INFO)
    end
end

vim.keymap.set('n', '<C-k>d', typst_compile_open("Adobe Acrobat.app"), { buffer=true, desc='Build/Compile to PDF, open in Default app (Acrobat)' })
vim.keymap.set('n', '<C-k>p', typst_compile_open("Preview.app"), { buffer=true, desc='Build/Compile to PDF, open in Preview.app' })
