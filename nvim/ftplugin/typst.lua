vim.opt_local.wrap = true
-- vim.opt.showbreak = "   "  -- When text is indented, it will be sub indented to work well for numbered and bulleted lists

-- Support words in kebab-case
vim.opt.iskeyword:append('-')

-- This doesn't work
-- table.insert(vim.opt_local.briopt,'list:-1')
vim.opt_local.briopt="list:-1"
vim.opt_local.formatlistpat="^\\s*\\d\\+\\.\\s\\+\\|^\\s*[-*+]\\s\\+\\|^\\[^\\ze[^\\]]\\+\\]:\\&^.\\{4\\}\\|^[>[:space:]]\\+\\s\\+"

vim.opt_local.makeprg = 'typst compile %:S'
vim.opt_local.errorformat='%f:%l:%c:%m,%f:%l:%m'

-- unique augroup name
local augroup_name = "AutoOpenQuickfixGroup"
vim.api.nvim_create_augroup(augroup_name, { clear = true })

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
    pattern = "make", -- Matches ANY command that uses the quickfix list (:make, :grep, etc.)
    group = augroup_name,
    nested = true, -- Allows syntax highlighting in the quickfix window
    callback = function()
        vim.notify("Compiled with: "..vim.opt_local.makeprg._value, vim.log.levels.INFO)

        vim.cmd("cwindow")

        local qflist = vim.fn.getqflist()
        if #qflist == 0 then
            local pdf_filename = vim.fn.expand("%:r")..".pdf"
            local escaped_pdf_filename = vim.fn.shellescape(pdf_filename)
            local open_cmd = 'open "' .. pdf_filename ..'"'
            if vim.b.pdf_app ~= nil then
                open_cmd = 'open -a "'..vim.b.pdf_app..'" '.. escaped_pdf_filename
            end
            os.execute(open_cmd)
        end
    end,
})


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

local function typst_compile_open(app)
    -- Return closure with `app` in the context
    return function()
        vim.cmd.update() -- Save buffer
        vim.b.pdf_app = app -- Set default app
        vim.cmd([[:silent make]]) -- `silent` so user doesn't have to press enter after
    end
end

local function choose_pdf_standard()
    vim.ui.select({
        'default - Typst Default',
        'a-1b    - PDF 1.4 (2001)',
        'a-1a    - PDF 1.7 (2006), Text Searchable, Accessible',
        'a-2b    - PDF 1.7 (2006),                              Transparant Images',
        'a-2u    - PDF 1.7 (2006), Text Searchable,             Transparant Images',
        'a-2a    - PDF 1.7 (2006), Text Searchable, Accessible, Transparant Images',
        'a-3b    - PDF 1.7 (2006),                              Transparant Images, Attachments',
        'a-3u    - PDF 1.7 (2006), Text Searchable,             Transparant Images, Attachments',
        'a-3a    - PDF 1.7 (2006), Text Searchable, Accessible, Transparant Images, Attachments',
        }, {
        prompt = 'Select PDF Standard:',
    }, function(choice)
        if choice == nil then
            vim.notify("User did not choose a standard", vim.log.levels.INFO)
        else
            local standard = string.match(choice, "(%S+)")
            if standard == nil then
                vim.notify("Could not find first word in "..choice, vim.log.levels.INFO)
            else
                vim.notify("Using PDF standard " .. standard, vim.log.levels.INFO)
                if standard == 'default' then
                    vim.opt_local.makeprg = 'typst compile %:S'
                else
                    vim.opt_local.makeprg = 'typst compile --diagnostic-format short --pdf-standard '.. standard .. ' %:S'
                end
            end
        end
    end)
end

vim.keymap.set('n', '<localleader>p', choose_pdf_standard,             { buffer=true, desc='Choose PDF/A Standard' })
vim.keymap.set('n', '<C-k>d', typst_compile_open("Adobe Acrobat.app"), { buffer=true, desc='Build/Compile to PDF, open in Acrobat.app' })
vim.keymap.set('n', '<C-k>p', typst_compile_open("Preview.app"),       { buffer=true, desc='Build/Compile to PDF, open in Preview.app' })
