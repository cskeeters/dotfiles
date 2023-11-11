return {
    enabled = true,
    'hrsh7th/nvim-cmp',
    lazy = false,
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        -- Neovim
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-cmdline',

        'hrsh7th/cmp-nvim-lsp-signature-help',

        -- For ultisnips users.
        'SirVer/ultisnips',
        'quangnguyen30192/cmp-nvim-ultisnips',

        -- Icons
        'onsails/lspkind.nvim',
    },

    init = function()

        require("cmp_nvim_ultisnips").setup{}

        local lspkind = require('lspkind')

        local cmp = require('cmp')

        cmp.setup {
            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                end,
            },
            sources = {
                { name = 'nvim-lsp' },
                { name = 'nvim_lua' },
                { name = 'buffer' },
                { name = 'path' },
                { name = "ultisnips" },
                --{ name = 'nvim_lsp_signature_help' },
            },
            mapping = {
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-e>'] = cmp.mapping.abort(), -- close the menu, at least until another char is typed
                ['<C-y>'] = cmp.mapping.confirm {
                    --behavior = cmp.ConfirmBehavior.Insert,
                    select = true,
                },
                ['<C-space>'] = cmp.mapping.complete(),
            },
            formatting = {
                format = lspkind.cmp_format({
                    mode = 'symbol',
                    ellipsis_char = '...',
                })
            },
            experimental = {
                native_menu = false,
                ghost_text = true,
            },
        }

        -- `/` cmdline setup.
        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        -- `:` cmdline setup.
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                {
                    name = 'cmdline',
                    option = {
                        ignore_cmds = { 'Man', '!' }
                    }
                }
            })
        })
    end,
}
