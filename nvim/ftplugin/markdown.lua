vim.opt_local.wrap = true
-- vim.opt.showbreak = "   "  -- When text is indented, it will be sub indented to work well for numbered and bulleted lists

-- This doesn't work
-- table.insert(vim.opt_local.briopt,'list:-1')
vim.opt_local.briopt="list:-1"
vim.opt_local.formatlistpat="^\\s*\\d\\+\\.\\s\\+\\|^\\s*[-*+]\\s\\+\\|^\\[^\\ze[^\\]]\\+\\]:\\&^.\\{4\\}\\|^[>[:space:]]\\+\\s\\+"


if vim.fn.has("patch-7.4-353") == 0 then
    vim.bo.list = false
end

vim.opt_local.conceallevel=0
vim.bo.commentstring=[[<!-- %s -->]]

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
-- Note: "_yiw moves cursor to the beginning of the word affecting any registers.  B doen't work when cursor is already on the first character
-- Note: Changed E to e because punctuation is more of a problem than hyphens in words needing style
vim.keymap.set('n', '<LocalLeader>b', [["_yiWi**<Esc>ea**<Esc>]], { buffer=true, desc='Bold word under cursor' })
vim.keymap.set('n', '<LocalLeader>i', [["_yiWi*<Esc>ea*<Esc>]], { buffer=true, desc='Italicize word under cursor' })
vim.keymap.set('n', '<LocalLeader>`', [["_yiWi`<Esc>ea`<Esc>]], { buffer=true, desc='Monospace word under cursor' })

vim.keymap.set('v', '<LocalLeader>b', [[s**<C-r>"**<Esc>]], { buffer=true, desc='Bold selected text' })
vim.keymap.set('v', '<LocalLeader>i', [[s*<C-r>"*<Esc>]], { buffer=true, desc='Italicize selected text' })
vim.keymap.set('v', '<LocalLeader>`', [[s`<C-r>"`<Esc>]], { buffer=true, desc='Monospace selected text' })

-- HTML Keyboard Wrapper
vim.keymap.set('n', '<LocalLeader>k', [["_yiwcw<kbd><C-r>"</kbd><Esc>]], { buffer=true, desc='Adds <kbd></kbd> around word under cursor' })
vim.keymap.set('v', '<LocalLeader>k', [[s<kbd><C-r>"</kbd><Esc>]], { buffer=true, desc='Adds <kbd></kbd> for selected text' })

-- Table Heading
vim.keymap.set('n', '<LocalLeader>t', [[yypV:s/[^\|]/-/g<cr><cmd>noh<cr>yyp<cmd>s/-/ /g | noh<cr>]], { buffer=true, desc='Create header separator for Table' })

-- Links
vim.keymap.set('n', '<LocalLeader>[', [[yiwi[<Esc>ea](<C-r>")<Esc>]], { buffer=true, desc='Makes word a [link](url)' })
vim.keymap.set('n', '<LocalLeader>l', [[lBi<<Esc>Ea><Esc>]],          { buffer=true, desc='Makes word a <link>' })


vim.keymap.set('v', '<LocalLeader>[', [[s[<C-r>"]()<Esc>i]], { buffer=true, desc='Makes selected text a [link](url)' })
vim.keymap.set('v', '<LocalLeader>l', [[s<<C-r>"><Esc>]],    { buffer=true, desc='Makes selected text a <link>' })

vim.keymap.set('n', '<C-k>v', '<Cmd>MarkdownPreviewToggle<Cr>', { buffer=true, silent=true, desc="Toggle Markdown Preview" })

-- Rendering
vim.keymap.set('n', '<C-k>r', [[<Cmd>silent !~/redcarpet/render.rb '%' && open '%:r'.html<cr>]], { buffer=true, desc='Render to html with redcarpet' })
vim.keymap.set('n', '<C-k>k', [[<Cmd>silent !~/kramdown/render.rb '%' && open '%:r'.html<cr>]], { buffer=true, desc='Render to html with kramdown' })
vim.keymap.set('n', '<C-k>h', [[<Cmd>update<cr>:!pandoc -f markdown+simple_tables '%' -o '%:r.html' && open '%:r.html'<cr>]], { buffer=true, desc='Render to docx with pandoc (plain)' })
vim.keymap.set('n', '<C-k>p', [[<Cmd>update<cr>:!pandoc -f markdown+simple_tables '%' -o '%:r.docx' && open '%:r.docx'<cr>]], { buffer=true, desc='Render to docx with pandoc (plain)' })
vim.keymap.set('n', '<C-k>i', [[<Cmd>update<cr>:!pandoc -f markdown+simple_tables --reference-doc=$HOME/RCC/pandoc/minutes.docx '%' -o '%:r.docx' && open '%:r.docx'<cr>]], { buffer=true, desc='Render minutes to docx with pandoc' })
vim.keymap.set('n', '<C-k>d', [[<Cmd>update<cr>:!pandoc -f markdown+simple_tables --reference-doc=$HOME/RCC/pandoc/doc.docx '%' -o '%:r.docx' && open '%:r.docx'<cr>]], { buffer=true, desc='Render document to docx with pandoc' })
vim.keymap.set('n', '<C-k>m', [[<Cmd>update<cr>:!mmd2pdf '%' && open '%:r.pdf'<cr>]], { buffer=true, desc='Render document to pdf with multimarkdown' })
vim.keymap.set('n', '<C-k>a', [[<Cmd>update<cr>:!pandoc -t typst --template md-article.template % -o %:r.typ<cr>]], { buffer=true, desc='Render document to typst article with pandoc' })

-- Just
vim.keymap.set('n', '<C-j>w', [[<Cmd>update<cr>:!just word %:t<cr>]], { buffer=true, desc='Use just to make docx and open Word' })
vim.keymap.set('n', '<C-j>o', [[<Cmd>update<cr>:!just --unstable open %:t<cr>]], { buffer=true, desc='Use just to make PDF and Open' })
--vim.keymap.set('n', '<C-j>l', [[:let g:justfile=%:t<cr>:tabnew<cr>:execute "term just watch ".g:justfile<cr>]], { buffer=true, desc='Use just to make PDF and open' })
vim.keymap.set('n', '<C-j>l', [[:let g:justfile=expand('%:t')<cr>:execute "tabedit term://just watch ".g:justfile<cr>:tabprevious<cr>]], { buffer=true, desc='Use just to watch for changes and produce PDFs' })
vim.keymap.set('n', '<C-j>t', [[<Cmd>update<cr>:!just typ %:t<cr>:e %:t:r.typ<cr>]], { buffer=true, desc='Edit Typst source from previous' })


-- Quarto
vim.keymap.set('n', '<C-k>q', [[<Cmd>QuartoPreview<cr>]], { buffer=true, desc='Preview Quarto' })


-- eMASS A&A commands
--vim.keymap.set('n', '<LocalLeader>gc', [[gg0df"ggh/Supp<Cr>ggh/Potential A<Cr>ggh/Examine:<Cr>i<Cr><Esc>ggp/Interview:<Cr>ggp/Test:<Cr>ggpggh/"<C-v><Tab><Cr>2s<Cr><Esc>d3f<Tab>i<Cr><Cr><Esc>/<C-v><Tab>"<Cr>2s<Cr><Cr><Esc>/"<C-v><Tab><Cr>2s<Cr><Cr><Esc>]], { remap=true, buffer=true, desc='Convert title to Markdown' })
vim.keymap.set('n', '<LocalLeader>gc', [[gg0xG$xo<Cr># Assessment Procedure List<Esc>gg0,gho<Esc>gg0/^Supplemental Guidance:<Cr>,gho<Esc>gg0/^Potential Assessment<Cr>,gho<Esc>gg0/^Justification to Select:<Cr>,ghgg0/^Regulatory Statutory Reference:<Cr>,ghgg0/^Examine:<Cr>,gpgg0/^Interview:<Cr>,gpgg0/^Test:<Cr>,gp]], { remap=true, buffer=true, desc='Convert RMF Control Information to Markdown' })

vim.keymap.set('n', '<LocalLeader>gh', [[0i# <Esc>f:D0<Esc>]], { buffer=true, desc='Convert title to Markdown' })
vim.keymap.set('n', '<LocalLeader>gp', [[0i## <Esc>f:s<Cr><Cr><Esc>}j]], { buffer=true, desc='Convert potential assessment method to Markdown' })
vim.keymap.set('n', '<LocalLeader>ga', [[0i## [  ] <Esc>f<Tab>s Summary (<Esc>ea)<Cr><Cr><Esc>df:xf<Tab>2s<Cr><Cr><Esc>/"<C-v><Tab><Cr>2s<Cr><Cr><Esc>A<Cr><Esc>j]], { buffer=true, desc='Convert Assessment Procedure to Markdown' })
vim.keymap.set('n', '<LocalLeader>gl', [[0i## [  ] <Esc>f<Tab>s Summary (<Esc>ea)<Cr><Cr><Esc>df:xf<Tab>2s<Cr><Cr><Esc>/"<cr>cf"<Cr><Esc>/"<Cr>C<Cr><Cr><Esc>j]], { buffer=true, desc='Convert Assessment Procedure (alt) to Markdown' })
