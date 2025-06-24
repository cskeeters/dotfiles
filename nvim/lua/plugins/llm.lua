return {
    enabled = false,
    'huggingface/llm.nvim',
    lazy = false,

    config = function()
        require('llm').setup({
            -- model = "codellama:7b",
            model = "qwen2.5-coder:14b",
            backend = "ollama",
            url = "http://localhost:11434", -- llm-ls uses "/api/generate"
            -- cf https://github.com/ollama/ollama/blob/main/docs/api.md#parameters
            request_body = {
                -- Modelfile options for the model you use
                options = {
                    temperature = 0.2,
                    top_p = 0.95,
                }
            },
            lsp = {
                bin_path = vim.api.nvim_call_function("stdpath", { "data" }) .. "/mason/bin/llm-ls",
            },
        })
    end,
}

