return {
    enabled = false,
    "refine-sh/refine.nvim",
    keys = {
        { "<leader>rc", "<Plug>(RefineCheck)",    desc="Grammar Check (Refine)" },
        { "<leader>rs", "<Plug>(RefineShow)",     desc="Grammar Show (Refine)" },
        { "<leader>ra", "<Plug>(RefineApply)",    desc="Grammar Apply (Refine)"},
        { "<leader>rd", "<Cmd>RefineDismiss<Cr>", desc="Grammar Dismiss (Refine)"},
        { "<leader>re", "<Cmd>RefineExplain<Cr>", desc="Grammar Explain (Refine)"},
        { "<leader>rl", "<Cmd>RefineClose<Cr>",   desc="Grammar Close (Refine)"},
        { "<leader>rt", "<Cmd>RefineStatus<Cr>",  desc="Grammar Status (Refine)"},
        { "]r",         "<Plug>(RefineNext)",     desc="Refine Next" },
        { "[r",         "<Plug>(RefinePrevious)", desc="Refine Previous" },
    },
    config = function ()
        require("refine").setup({
            filetypes = {
                markdown = "markdownDocument",
                text = "plainText",
                gitcommit = "plainText",
                mail = "plainText",
                ["markdown.mail"] = "markdownDocument",
                tex = "latexDocument",
                plaintex = "latexDocument",
            },
        })
    end,
}
