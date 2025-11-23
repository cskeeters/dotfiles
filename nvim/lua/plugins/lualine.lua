-- A blazing fast and easy to configure Neovim statusline written in Lua.
return {
    enabled = true,
    'cskeeters/lualine.nvim',
    lazy = false,
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    init = function()

        local component_separators = { left = ' ', right = ' '}
        local section_separators = { left = ' ', right = ' '}

        if vim.g.nerd_font then
            component_separators = { left = '', right = ''}
            section_separators = { left = '', right = ''}
        end

        require('lualine').setup({
            options = {
                icons_enabled = vim.g.nerd_font,
                theme = 'auto',
                component_separators = component_separators,
                section_separators = section_separators,
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_c = {'filename'},
                lualine_x = {'encoding', 'fileformat', 'filetype'},
                lualine_y = {'progress'},
                lualine_z = {'location'}
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {'filename'},
                lualine_x = {'location'},
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        })
    end,
}
