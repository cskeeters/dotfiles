vim.opt_local.wrap = true
-- vim.opt.showbreak = "   "  -- When text is indented, it will be sub indented to work well for numbered and bulleted lists

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

-- Table Heading
vim.keymap.set('n', '<LocalLeader>t', [[yypV:s/[^\|]/-/g<cr><cmd>noh<cr>yyp<cmd>s/-/ /g | noh<cr>]], { buffer=true, desc='Create header separator for Table' })

-- Links
vim.keymap.set('n', '<LocalLeader>[', [[yiwi[<Esc>ea](<C-r>")<Esc>]], { buffer=true, desc='Makes word a [link](url)' })
vim.keymap.set('n', '<LocalLeader>l', [[lBi<<Esc>Ea><Esc>]],          { buffer=true, desc='Makes word a <link>' })


vim.keymap.set('v', '<LocalLeader>[', [[s[<C-r>"]()<Esc>i]], { buffer=true, desc='Makes selected text a [link](url)' })
vim.keymap.set('v', '<LocalLeader>l', [[s<<C-r>"><Esc>]],    { buffer=true, desc='Makes selected text a <link>' })

-- vim-marked command
vim.keymap.set('n', '<C-k>r', [[<Cmd>silent !~/redcarpet/render.rb '%' && open '%:r'.html<cr>]], { buffer=true, desc='Render to html with redcarpet' })
vim.keymap.set('n', '<C-k>k', [[<Cmd>silent !~/kramdown/render.rb '%' && open '%:r'.html<cr>]], { buffer=true, desc='Render to html with kramdown' })
vim.keymap.set('n', '<C-k>d', [[<Cmd>update<cr>:!pandoc -f markdown+yaml_metadata_block+simple_tables '%' -o '%:r.docx' && open '%:r.docx'<cr>]], { buffer=true, desc='Render to docx with pandoc' })

-- eMASS A&A commands
--vim.keymap.set('n', '<LocalLeader>gc', [[gg0df"ggh/Supp<Cr>ggh/Potential A<Cr>ggh/Examine:<Cr>i<Cr><Esc>ggp/Interview:<Cr>ggp/Test:<Cr>ggpggh/"<C-v><Tab><Cr>2s<Cr><Esc>d3f<Tab>i<Cr><Cr><Esc>/<C-v><Tab>"<Cr>2s<Cr><Cr><Esc>/"<C-v><Tab><Cr>2s<Cr><Cr><Esc>]], { remap=true, buffer=true, desc='Convert title to Markdown' })
vim.keymap.set('n', '<LocalLeader>gc', [[gg0xG$xo<Cr># Assessment Procedure List<Esc>gg0,gho<Esc>gg0/^Supplemental Guidance:<Cr>,gho<Esc>gg0/^Potential Assessment<Cr>,gho<Esc>gg0/^Justification to Select:<Cr>,ghgg0/^Regulatory Statutory Reference:<Cr>,ghgg0/^Examine:<Cr>,gpgg0/^Interview:<Cr>,gpgg0/^Test:<Cr>,gp]], { remap=true, buffer=true, desc='Convert RMF Control Information to Markdown' })

vim.keymap.set('n', '<LocalLeader>gh', [[0i# <Esc>f:D0<Esc>]], { buffer=true, desc='Convert title to Markdown' })
vim.keymap.set('n', '<LocalLeader>gp', [[0i## <Esc>f:s<Cr><Cr><Esc>}j]], { buffer=true, desc='Convert potential assessment method to Markdown' })
vim.keymap.set('n', '<LocalLeader>ga', [[0i## [  ] <Esc>f<Tab>s Summary (<Esc>ea)<Cr><Cr><Esc>df:xf<Tab>2s<Cr><Cr><Esc>/"<C-v><Tab><Cr>2s<Cr><Cr><Esc>A<Cr><Esc>j]], { buffer=true, desc='Convert Assessment Procedure to Markdown' })
