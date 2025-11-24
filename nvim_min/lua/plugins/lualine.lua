-- A blazing fast and easy to configure Neovim statusline written in Lua.
return {
    enabled = true,
    'cskeeters/lualine.nvim',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options = {
        -- Use a simple theme like 'auto' or your installed colorscheme name
        -- theme = 'jellybeans',
        -- theme = 'tomorrow_night',
        theme = 'auto',
        -- Remove the section separators for a more minimal, flat look
        section_separators = '',
        component_separators = '',
        },
        -- All other sections/components remain the default
    },
}
