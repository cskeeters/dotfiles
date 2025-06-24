-- To enable lsp for a file type:
-- 1. Find the lsp you think is best (There might be multiple available)
-- 2. Run :Mason and install it
-- 3. Add a section of config like:
--
--        lspconfig.bashls.setup{
--            on_attach = on_attach,
--            flags = lsp_flags,
--        }


-- May create bindings for the following later...
-- vim.diagnostic.enable()
-- vim.diagnostic.disable()

-- vim.diagnostic.show()
-- vim.diagnostic.hide()

-- Severity level to jump to in goto routines
local goto_opts = {}

local set_diag_severity = function(severity)
    print("Setting to "..vim.diagnostic.severity[severity])

    vim.diagnostic.config({
        underline = {
            severity = { min=severity }
        },
        virtual_text = {
            severity = { min=severity }
        }
        -- signs = {
            -- text = {}
            -- linehl = {}
            -- numhl = {}
        -- }
    })

    goto_opts = { severity=severity }
end

local on_attach = function(client, bufnr)
    -- vim.notify("on_attach called")

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf=bufnr })

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

    vim.keymap.set('n', '<LocalLeader>le', function()
        set_diag_severity(vim.diagnostic.severity.ERROR)
    end, { noremap=true, silent=true, buffer=bufnr, desc="Set diagnostic severity min to ERROR" })

    vim.keymap.set('n', '<LocalLeader>lw', function()
        set_diag_severity(vim.diagnostic.severity.WARN)
    end, { noremap=true, silent=true, buffer=bufnr, desc="Set diagnostic severity min to WARN" })

    vim.keymap.set('n', '<LocalLeader>li', function()
        set_diag_severity(vim.diagnostic.severity.INFO)
    end, { noremap=true, silent=true, buffer=bufnr, desc="Set diagnostic severity min to INFO" })

    vim.keymap.set('n', '<LocalLeader>lh', function()
        set_diag_severity(vim.diagnostic.severity.HINT)
    end, { noremap=true, silent=true, buffer=bufnr, desc="Set diagnostic severity min to HINT" })
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
        local lspconfig = require 'lspconfig'
        local util = require 'lspconfig.util'

        require("mason").setup()
        require("mason-lspconfig").setup({
            automatic_installation = true,
            ensure_installed = { "lua_ls", "bashls", "cssls", "clangd", "rust_analyzer", "gopls", "tinymist", "harper_ls"},
        })

        vim.keymap.set('n', '<LocalLeader>e', vim.diagnostic.open_float, { noremap=true, silent=true, desc="Open Diagnostic Float" })

        vim.keymap.set('n', '[d', function()
            vim.diagnostic.jump({
                count=-1,
                wrap=true,
                severity=vim.diagnostic.severity.HINT,
                -- float=true,
            })
        end,  { noremap=true, silent=true })

        vim.keymap.set('n', ']d', function()
            vim.diagnostic.jump({
                count=1,
                wrap=true,
                severity=vim.diagnostic.severity.HINT,
                -- float=true,
            })
        end,  { noremap=true, silent=true })

        vim.keymap.set('n', '<LocalLeader>q', vim.diagnostic.setloclist, { noremap=true, silent=true })

        vim.keymap.set('n', '<Leader><Leader>lspi', ':LspInstall<cr>',   { desc="Install LSP Server" })
        vim.keymap.set('n', '<Leader><Leader>lspu', ':LspUninstall<cr>', { desc="Uninstall LSP Server" })
        vim.keymap.set('n', '<Leader><Leader>lspr', ':LspRestart<cr>', { desc="Restart LSP Server" })

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
        lspconfig.lua_ls.setup {
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
                        globals = {'vim', 'bufnr', 'hs', 'spoon', 'pandoc'},
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
        lspconfig.bashls.setup{
            on_attach = on_attach,
            flags = lsp_flags,
            capabilities = capabilities,
        }

        -- MasonInstall css-lsp
        lspconfig.cssls.setup{
            on_attach = on_attach,
            flags = lsp_flags,
            capabilities = capabilities,
        }

        -- MasonInstall phpactor (Requires php8.1 which is not available on bullseye)
        lspconfig.phpactor.setup{
            on_attach = on_attach,
            flags = lsp_flags,
            capabilities = capabilities,
        }

        -- MasonInstall pyright
        lspconfig.pyright.setup{
            on_attach = on_attach,
            flags = lsp_flags,
            capabilities = capabilities,
        }

        -- MasonInstall clangd
        lspconfig.clangd.setup{
            on_attach = on_attach,
            flags = lsp_flags,
            capabilities = capabilities,
        }

        -- MasonInstall java-language-server
        -- lspconfig.java_language_server.setup{
            -- on_attach = on_attach,
            -- flags = lsp_flags,
        -- }

        -- MasonInstall rust-analyzer
        lspconfig.rust_analyzer.setup({
            on_attach = on_attach,
            settings = {
                ["rust-analyzer"] = {
                    imports = {
                        granularity = {
                            group = "module",
                        },
                        prefix = "self",
                    },
                    cargo = {
                        buildScripts = {
                            enable = true,
                        },
                    },
                    procMacro = {
                        enable = true
                    },
                }
            }
        })

        -- MasonInstall gopls
        lspconfig.gopls.setup({
            on_attach = on_attach,
            flags = lsp_flags,
            capabilities = capabilities,
        })

        -- MasonInstall tinymist
        lspconfig.tinymist.setup{
            on_attach = on_attach,
            flags = lsp_flags,
            capabilities = capabilities,
            settings = {
                -- See https://github.com/Myriad-Dreamin/tinymist/issues/528
                --exportPdf = "onType",
                --exportPdf = "onSave",
                --outputPath = "$root/$dir/$name",
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
                        SpellCheck = true,
                        SpelledNumbers = false,
                        AnA = true,
                        SentenceCapitalization = true,
                        UnclosedQuotes = true,
                        WrongQuotes = false,
                        LongSentences = true,
                        RepeatedWords = true,
                        Spaces = false,
                        Matcher = true,
                        CorrectNumberSuffix = true,
                        NumberSuffixCapitalization = true,
                        MultipleSequentialPronouns = true,
                        LinkingVerbs = false,
                        AvoidCurses = true,
                        MerminatingConjunctions = true
                    }
                }
            },
        }

        require('lspconfig').yamlls.setup {
            settings = {
                yaml = {
                    validate = true,
                    -- disable the schema store
                    schemaStore = {
                        enable = false,
                        url = "",
                    },
                    -- manually select schemas
                    schemas = {
                        ['/Users/chad/RCC/schema/expense_schema.json'] = 'expense*.yml',
                        -- ['/Users/chad/RCC/schema/invoice_schema.json'] = 'invoice*.yml',
                        ['/Users/chad/RCC/schema/financials_schema.json'] = 'financials.yml',
                        ['/Users/chad/RCC/schema/test.json'] = 'test*.yml',
                        -- ['https://json.schemastore.org/kustomization.json'] = 'kustomization.{yml,yaml}',
                        -- ['https://raw.githubusercontent.com/docker/compose/master/compose/config/compose_spec.json'] = 'docker-compose*.{yml,yaml}',
                        -- ["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json"] = "argocd-application.yaml",
                    }
                }
            }
        }

    end
}
