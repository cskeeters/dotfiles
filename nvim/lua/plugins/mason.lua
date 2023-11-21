-- To enable lsp for a file type:
-- 1. Find the lsp you think is best (There might be multiple available)
-- 2. Run :Mason and install it
-- 3. Add a section of config like:
--
--        require('lspconfig').bashls.setup{
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
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { noremap=true, silent=true, buffer=bufnr, desc="Show signature help" })
    vim.keymap.set('n', '<LocalLeader>D', vim.lsp.buf.type_definition, { noremap=true, silent=true, buffer=bufnr, desc="Show type definition" })

    -- Jumping
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap=true, silent=true, buffer=bufnr, desc="Jump to definition" })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { noremap=true, silent=true, buffer=bufnr, desc="Jump to declaration" })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { noremap=true, silent=true, buffer=bufnr, desc="Jump to implementation" })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { noremap=true, silent=true, buffer=bufnr, desc="Show references (LSP)" })

    -- Workspace
    vim.keymap.set('n', '<LocalLeader>wa', vim.lsp.buf.add_workspace_folder, { noremap=true, silent=true, buffer=bufnr, desc="Add workspace folder" })
    vim.keymap.set('n', '<LocalLeader>wr', vim.lsp.buf.remove_workspace_folder, { noremap=true, silent=true, buffer=bufnr, desc="Remove workspace folder" })
    vim.keymap.set('n', '<LocalLeader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { noremap=true, silent=true, buffer=bufnr, desc="Show workspace folders" })

    -- Modification Actions
    vim.keymap.set('n', '<LocalLeader>rn', vim.lsp.buf.rename, { noremap=true, silent=true, buffer=bufnr, desc="Rename (LSP)" })
    vim.keymap.set('n', '<LocalLeader>ca', vim.lsp.buf.code_action, { noremap=true, silent=true, buffer=bufnr, desc="LSP Fix (Code action)" })
    vim.keymap.set('v', '<LocalLeader>ca', vim.lsp.buf.code_action, { noremap=true, silent=true, buffer=bufnr, desc="LSP Fix (Code action)" })
    vim.keymap.set('n', '<LocalLeader>f', function() vim.lsp.buf.format { async = true } end, { noremap=true, silent=true, buffer=bufnr, desc="Format current file (LSP)" })
end

return {
    enabled = true,
    'williamboman/mason.nvim',
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig'
    },
    keys = {

    },
    init = function()
        require("mason").setup()
        require("mason-lspconfig").setup()

        vim.keymap.set('n', '<LocalLeader>e', vim.diagnostic.open_float, { noremap=true, silent=true })
        vim.keymap.set('n', '[d',             vim.diagnostic.goto_prev,  { noremap=true, silent=true })
        vim.keymap.set('n', ']d',             vim.diagnostic.goto_next,  { noremap=true, silent=true })
        vim.keymap.set('n', '<LocalLeader>q', vim.diagnostic.setloclist, { noremap=true, silent=true })

        vim.keymap.set('n', '<LocalLeader>lspi', ':LspInstall<cr>',   { desc="Install LSP Server" })
        vim.keymap.set('n', '<LocalLeader>lspu', ':LspUninstall<cr>', { desc="Uninstall LSP Server" })

        local lsp_flags = {
            -- This is the default in Nvim 0.7+
            debounce_text_changes = 150,
        }

        -- See :help lspconfig-quickstart

        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
        -- https://github.com/LuaLS/lua-language-server/blob/master/doc/en-us/config.md

        -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

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

        require('lspconfig').bashls.setup{
            on_attach = on_attach,
            flags = lsp_flags,
        }

        require('lspconfig').cssls.setup{
            on_attach = on_attach,
            flags = lsp_flags,
        }

        require('lspconfig').phpactor.setup{
            on_attach = on_attach,
            flags = lsp_flags,
        }

        require('lspconfig').pyright.setup{
            on_attach = on_attach,
            flags = lsp_flags,
        }

        require('lspconfig').clangd.setup{
            on_attach = on_attach,
            flags = lsp_flags,
        }

        -- require('lspconfig').java_language_server.setup{
            -- on_attach = on_attach,
            -- flags = lsp_flags,
        -- }

        -- require("lspconfig").rust_analyzer.setup {}

    end
}
