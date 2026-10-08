return {
    enabled = true,
    -- Local development checkout of the errata.nvim fork.
    dir = "~/working/errata.nvim",
    name = "errata.nvim",
    keys = {
        { "<leader>ec", "<Plug>(ErrataCheck)",    desc="Grammar Check (Errata)" },
        { "<leader>es", "<Plug>(ErrataShow)",     desc="Grammar Show (Errata)" },
        { "<leader>ea", "<Plug>(ErrataApply)",    desc="Grammar Apply (Errata)"},
        { "<leader>ed", "<Cmd>ErrataDismiss<Cr>", desc="Grammar Dismiss (Errata)"},
        { "<leader>ee", "<Cmd>ErrataExplain<Cr>", desc="Grammar Explain (Errata)"},
        { "<leader>el", "<Cmd>ErrataClose<Cr>",   desc="Grammar Close (Errata)"},
        { "<leader>et", "<Cmd>ErrataStatus<Cr>",  desc="Grammar Status (Errata)"},
        { "]e",         "<Plug>(ErrataNext)",     desc="Errata Next" },
        { "[e",         "<Plug>(ErrataPrevious)", desc="Errata Previous" },
    },
    config = function ()
        require("errata").setup({
            -- HYDE runs Ollama over the LAN; errata's `ollama` adapter speaks
            -- the OpenAI-compatible /v1/chat/completions endpoint with no API
            -- key. (The `openai_responses` adapter hits /v1/responses and
            -- requires a key, so it cannot target a local Ollama here.)
            adapter = "ollama",
            model = "gemma4:e2b-mlx",
            -- model = "phi4:14b-q8_0",             -- FAST, uses indeed alot.  Very corporate.
            -- model = "mistral-small3.2",        -- Very good, fast enough
            adapters = {
                ollama = {
                    -- url = "http://192.168.20.11:11434",  -- Ollama on HYDE
                    url = "http://127.0.0.1:11434",  -- Ollama on localhost
                },
            },
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
