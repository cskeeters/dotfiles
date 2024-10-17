-- To enable lsp for a file type:
-- 1. Find the lsp you think is best (There might be multiple available)
-- 2. Run :Mason and install it
-- 3. Add a section of config like:
--
--        lspconfig.bashls.setup{
--            on_attach = on_attach,
--            flags = lsp_flags,
--        }

local on_attach = function(client, bufnr)
    -- vim.notify("on_attach called")
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions

    -- Context Help
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap=true, silent=true, buffer=bufnr, desc="Show method definition in hovering window" })
    vim.keymap.set('n', ',<C-k>', vim.lsp.buf.signature_help, { noremap=true, silent=true, buffer=bufnr, desc="Show signature help" })
    vim.keymap.set('n', '<LocalLeader>D', vim.lsp.buf.type_definition, { noremap=true, silent=true, buffer=bufnr, desc="Show type definition" })

    -- Jumping
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap=true, silent=true, buffer=bufnr, desc="Jump to definition" })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { noremap=true, silent=true, buffer=bufnr, desc="Jump to declaration" })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { noremap=true, silent=true, buffer=bufnr, desc="Jump to implementation" })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { noremap=true, silent=true, buffer=bufnr, desc="Show references (LSP)" })

    -- Workspace
    vim.keymap.set('n', '<LocalLeader><LocalLeader>wa', vim.lsp.buf.add_workspace_folder, { noremap=true, silent=true, buffer=bufnr, desc="Add workspace folder" })
    vim.keymap.set('n', '<LocalLeader><LocalLeader>wr', vim.lsp.buf.remove_workspace_folder, { noremap=true, silent=true, buffer=bufnr, desc="Remove workspace folder" })
    vim.keymap.set('n', '<LocalLeader><LocalLeader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { noremap=true, silent=true, buffer=bufnr, desc="Show workspace folders" })

    -- Modification Actions
    vim.keymap.set('n', '<LocalLeader>rn', vim.lsp.buf.rename, { noremap=true, silent=true, buffer=bufnr, desc="Rename (LSP)" })
    vim.keymap.set('n', '<LocalLeader>ca', vim.lsp.buf.code_action, { noremap=true, silent=true, buffer=bufnr, desc="LSP Fix (Code action)" })
    vim.keymap.set('v', '<LocalLeader>ca', vim.lsp.buf.code_action, { noremap=true, silent=true, buffer=bufnr, desc="LSP Fix (Code action)" })
    vim.keymap.set('n', '<LocalLeader>f', function() vim.lsp.buf.format { async = true } end, { noremap=true, silent=true, buffer=bufnr, desc="Format current file (LSP)" })

    -- vim.diagnostic.setloclist()
    -- vim.diagnostic.setqflist()
    vim.keymap.set('n', '<Leader>D',  "<cmd>lua vim.diagnostic.setqflist()<cr>", { noremap=true, silent=true, buffer=bufnr, desc="Load diagnostics in Quickfix" })
end

-- Generates table for ltex-ls dictionary
local spelling_words = function()
    local words = {}
    local spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
    for word in io.open(spellfile, "r"):lines() do
        table.insert(words, word)
    end
    return words
end

return {
    enabled = true,
    'williamboman/mason.nvim',
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
        --'hrsh7th/cmp-nvim-lsp',
    },
    lazy=false,
    init = function()
        require("mason").setup()
        require("mason-lspconfig").setup()

        vim.keymap.set('n', '<LocalLeader>e', vim.diagnostic.open_float, { noremap=true, silent=true })
        vim.keymap.set('n', '[d',             vim.diagnostic.goto_prev,  { noremap=true, silent=true })
        vim.keymap.set('n', ']d',             vim.diagnostic.goto_next,  { noremap=true, silent=true })
        vim.keymap.set('n', '<LocalLeader>q', vim.diagnostic.setloclist, { noremap=true, silent=true })

        vim.keymap.set('n', '<Leader><Leader>lspi', ':LspInstall<cr>',   { desc="Install LSP Server" })
        vim.keymap.set('n', '<Leader><Leader>lspu', ':LspUninstall<cr>', { desc="Uninstall LSP Server" })

        local lsp_flags = {
            -- This is the default in Nvim 0.7+
            debounce_text_changes = 150,
        }

        -- See :help lspconfig-quickstart

        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
        -- https://github.com/LuaLS/lua-language-server/blob/master/doc/en-us/config.md

        -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..

        local capabilities = nil
        local status, lsp = pcall(require, 'cmp_nvim_lsp')
        if status then
            capabilities = require('cmp_nvim_lsp').default_capabilities()
        end


        -- MasonInstall lua-language-server
        require("lspconfig").lua_ls.setup {
            on_attach = on_attach,

            flags = lsp_flags,

            settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = {'vim', 'bufnr', 'hs', 'spoon'},
                    },
                    workspace = {
                        checkThirdParty = false,
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                    -- Do not send telemetry data containing a randomized but unique identifier
                    telemetry = {
                        enable = false,
                    },
                },
            },
            capabilities = capabilities,
        }

        -- MasonInstall bash-language-server
        require('lspconfig').bashls.setup{
            on_attach = on_attach,
            flags = lsp_flags,
            capabilities = capabilities,
        }

        -- MasonInstall css-lsp
        require('lspconfig').cssls.setup{
            on_attach = on_attach,
            flags = lsp_flags,
            capabilities = capabilities,
        }

        -- MasonInstall phpactor (Requires php8.1 which is not available on bullseye)
        require('lspconfig').phpactor.setup{
            on_attach = on_attach,
            flags = lsp_flags,
            capabilities = capabilities,
        }

        -- MasonInstall pyright
        require('lspconfig').pyright.setup{
            on_attach = on_attach,
            flags = lsp_flags,
            capabilities = capabilities,
        }

        -- MasonInstall clangd
        require('lspconfig').clangd.setup{
            on_attach = on_attach,
            flags = lsp_flags,
            capabilities = capabilities,
        }

        -- MasonInstall java-language-server
        -- require('lspconfig').java_language_server.setup{
            -- on_attach = on_attach,
            -- flags = lsp_flags,
        -- }

        -- MasonInstall rust-analyzer
        -- require("lspconfig").rust_analyzer.setup {}

        -- MasonInstall gopls
        require("lspconfig").gopls.setup({
            on_attach = on_attach,
            flags = lsp_flags,
            capabilities = capabilities,
        })

        -- MasonInstall typst-lsp
        require'lspconfig'.typst_lsp.setup{
            on_attach = on_attach,
            flags = lsp_flags,
            capabilities = capabilities,
            settings = {
                -- Not sure if this is supported in neovim
                exportPdf = "never" -- Choose onType, onSave or never.
                -- serverPath = "" -- There is no need if .typ file is in git repository
            }
        }

        -- MasonInstall ltex-ls
        -- lspconfig.ltex.setup{
        --     -- Override filetypes in server_configuration/ltex to enable typst
        --     filetypes = { "latex", "typst", "typ", "bib", "markdown", "plaintex", "tex" },
        --     --filetypes = { "latex", "typst", "typ", "bib", "plaintex", "tex" },
        --     on_attach = on_attach,
        --     flags = lsp_flags,
        --     capabilities = capabilities,
        --     settings = {
        --         ltex = {
        --             language = "en-US",
        --             enabled = { "latex", "typst", "typ", "bib", "markdown", "plaintex", "tex" },

        --             -- see https://valentjn.github.io/ltex/settings.html#ltexdictionary
        --             dictionary = {
        --                 -- ["en-US"] = {'Callsign', 'callsign'} -- works
        --                 ["en-US"] = spelling_words()
        --             },
        --             -- https://valentjn.github.io/ltex/settings.html#ltexdisabledrules
        --             -- https://community.languagetool.org/rule/list?lang=en-US
        --             disabledRules = {
        --                 ['en-US'] = { 'PROFANITY', 'MORFOLOGIK_RULE_EN_US', 'WHITESPACE_RULE' }
        --             },
        --         },
        --     }
        -- }

        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#harper_ls
        lspconfig.harper_ls.setup {
            on_attach = on_attach,
            filetypes = { "text", "markdown", "rust", "typescript", "typescriptreact", "javascript", "python", "go", "c", "cpp", "ruby", "swift", "cs", "toml", "lua", "gitcommit", "java", "html" },
            settings = {
                ["harper-ls"] = {
                    userDictPath = "~/.config/nvim/harper_dict.txt",
                    diagnosticSeverity = "hint", -- Can also be "information", "warning", or "error"
                    linters = {
                        spell_check = true,
                        spelled_numbers = true,
                        an_a = true,
                        sentence_capitalization = true,
                        unclosed_quotes = true,
                        wrong_quotes = false,
                        long_sentences = true,
                        repeated_words = true,
                        spaces = false,
                        matcher = true,
                        correct_number_suffix = true,
                        number_suffix_capitalization = true,
                        multiple_sequential_pronouns = true,
                        linking_verbs = false,
                        avoid_curses = true,
                        terminating_conjunctions = true
                    }
                }
            },
        }

        }
    end
}
