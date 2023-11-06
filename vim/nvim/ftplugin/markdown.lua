vim.opt_local.wrap = true

if vim.fn.has("patch-7.4-353") == 0 then
    vim.bo.list = false
end

vim.opt_local.conceallevel=0
vim.bo.commentstring=[[<!--\ %s\ -->]]

-- Since vim overrides this, we need a way to reset it

vim.keymap.set('n', [[\c]], [[<cmd>setlocal commentstring=<!--\ %s\ --><cr>]], { buffer=true, desc='Changes comment to html/xml style' })


-- Setext style headers
vim.keymap.set('n', '<LocalLeader>h', [[yypVr=]], { buffer=true, desc='Heading 1' })
vim.keymap.set('n', '<LocalLeader>j', [[yypVr-]], { buffer=true, desc='Heading 2' })

-- Atx style Headers (I don't really need these)
vim.keymap.set('n', '<LocalLeader>1', [[I# <Esc>$F#xd0i#<Esc>0]], { buffer=true, desc='# Heading 1' })
vim.keymap.set('n', '<LocalLeader>2', [[I# <Esc>$F#xd0i##<Esc>0]], { buffer=true, desc='## Heading 2' })
vim.keymap.set('n', '<LocalLeader>3', [[I# <Esc>$F#xd0i###<Esc>0]], { buffer=true, desc='### Heading 3' })
vim.keymap.set('n', '<LocalLeader>4', [[I# <Esc>$F#xd0i####<Esc>0]], { buffer=true, desc='#### Heading 4' })
vim.keymap.set('n', '<LocalLeader>5', [[I# <Esc>$F#xd0i#####<Esc>0]], { buffer=true, desc='##### Heading 5' })

-- Text styling Bold Italic Fixed-width
-- Note: "_yiw moves cursor to the beginning of the word without affecting any registers
vim.keymap.set('n', '<LocalLeader>b', [["_yiWi**<Esc>lEa**<Esc>]], { buffer=true, desc='Bold word under cursor' })
vim.keymap.set('n', '<LocalLeader>i', [["_yiWi*<Esc>lEa*<Esc>]], { buffer=true, desc='Italicize word under cursor' })
vim.keymap.set('n', '<LocalLeader>`', [["_yiWi`<Esc>lEa`<Esc>]], { buffer=true, desc='Monospace word under cursor' })

vim.keymap.set('v', '<LocalLeader>b', [[s**<C-r>"**<Esc>]], { buffer=true, desc='Bold selected text' })
vim.keymap.set('v', '<LocalLeader>i', [[s*<C-r>"*<Esc>]], { buffer=true, desc='Italicize selected text' })
vim.keymap.set('v', '<LocalLeader>`', [[s`<C-r>"`<Esc>]], { buffer=true, desc='Monospace selected text' })

-- HTML Keyboard Wrapper
vim.keymap.set('n', '<LocalLeader>k', [["_yiwcw<kbd><C-r>"</kbd><Esc>]], { buffer=true, desc='Adds <kbd></kbd> around word under cursor' })
vim.keymap.set('v', '<LocalLeader>k', [[s<kbd><C-r>"<kbd><Esc>]], { buffer=true, desc='Adds <kbd></kbd> for selected text' })

-- Table Heading
vim.keymap.set('n', '<LocalLeader>t', [[yypV:s/[^\|]/-/g<cr><cmd>noh<cr>yyp<cmd>s/-/ /g | noh<cr>]], { buffer=true, desc='Create header separator for Table' })

-- Links
vim.keymap.set('n', '<LocalLeader>[', [[yiwi[<Esc>Ea](<C-r>")<Esc>]], { buffer=true, desc='Makes word a [link](url)' })
vim.keymap.set('n', '<LocalLeader>l', [[lBi<<Esc>Ea><Esc>]],          { buffer=true, desc='Makes word a <link>' })


vim.keymap.set('v', '<LocalLeader>[', [[s[<C-r>"]()<Esc>i]], { buffer=true, desc='Makes selected text a [link](url)' })
vim.keymap.set('v', '<LocalLeader>l', [[s<<C-r>"><Esc>]],    { buffer=true, desc='Makes selected text a <link>' })

-- vim-marked command
vim.keymap.set('n', '<C-k>v', [[<Cmd>MarkedOpen<cr>]], { buffer=true, desc='View in Marked' })
vim.keymap.set('n', '<C-k>r', [[<Cmd>silent !~/redcarpet/render.rb '%' && open '%:r'.html<cr>]], { buffer=true, desc='Render to html with redcarpet' })
vim.keymap.set('n', '<C-k>k', [[<Cmd>silent !~/kramdown/render.rb '%' && open '%:r'.html<cr>]], { buffer=true, desc='Render to html with kramdown' })
vim.keymap.set('n', '<C-k>d', [[<Cmd>update<cr>:!pandoc -f markdown+yaml_metadata_block+simple_tables '%' -o %:r.docx && open %:r.docx<cr>]], { buffer=true, desc='Render to docx with pandoc' })
