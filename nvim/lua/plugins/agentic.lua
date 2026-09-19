return {
    enabled = false,
    "carlos-algms/agentic.nvim",
    event = "VeryLazy",
    opts = {
        provider = "opencode-acp",
        acp_providers = {
            ["opencode-acp"] = {
                -- Automatically switch to this model when a new session starts
                initial_model = "qwen3.6:35b-a3b-q8_0",
            },
        },
    },

    keys = {
        {
            "<C-\\>",
            function()
                require("agentic").toggle()
            end,
            desc = "Agentic Open",
            mode = { "n", "v", "i" },
        },

        {
            "<C-'>",
            function()
                require("agentic").add_selection_or_file_to_context()
            end,
            desc = "Agentic add selection or current file to context",
            mode = { "n", "v" },
        },
    },

}
