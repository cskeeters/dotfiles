return {
    enabled = true,
    "iamcco/markdown-preview.nvim",
    lazy = true,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown", "quarto", "markdown.mail" },
    build = function(plugin)
        if vim.fn.executable "npx" then
            vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
        else
            vim.cmd [[Lazy load markdown-preview.nvim]]
            vim.fn["mkdp#util#install"]()
        end
    end,
    init = function()
        if vim.fn.executable "npx" then vim.g.mkdp_filetypes = { "markdown", "markdown.mail" } end
    end,
    -- config = function()
        -- vim.g.mkdp_filetypes = { "markdown", "quarto" }
    -- end
}

