-- Rendering
-- Leave <C-k>v for markdown-preview
vim.keymap.set('n', '<C-k>p', [[<Cmd>QuartoPreview<cr>]], { buffer=true, desc='Preview Quarto' })
vim.keymap.set('n', '<C-k>d', [[<Cmd>!quarto render % --to docx && open %:r.docx<cr>]], { buffer=true, desc='Render document to docx with quarto' })

vim.keymap.set('n', '<C-k>v', '<Cmd>MarkdownPreviewToggle<Cr>', { buffer=true, silent=true, desc="Toggle Markdown Preview" })
