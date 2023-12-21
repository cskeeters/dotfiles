return {
    enabled = true,
    'simrat39/symbols-outline.nvim',
    lazy=false,
    init = function()
        require("symbols-outline").setup({
            auto_close = true,
            width = 70,
        })
    end,
    keys = {
        {'<Leader>t', ':SymbolsOutline<cr>', noremap=true, silent=true, desc="Toggles the Symbols Outline (formerly Tagbar)" },
    }
}
