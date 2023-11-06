-- I don't like this plugin.  Will use netrw

local function open_tree()
    -- get the current buffer number
    local bufnr = vim.api.nvim_get_current_buf()

    -- get the name of the file associated with the buffer
    local filename = vim.api.nvim_buf_get_name(bufnr)
    vim.api.nvim_echo({{filename}}, true, {})

    -- check if the filename is an empty string
    if filename == "" then
        vim.cmd(":NvimTreeToggle")
    else
        vim.cmd(":NvimTreeFindFile")
    end
end

return {
    enabled = false,
    'nvim-tree/nvim-tree.lua',
    init = function()
        require("nvim-tree").setup()

        -- if the module loaded then disable netrw
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        vim.opt.termguicolors = true

        vim.api.nvim_set_keymap('n', '-', ':lua open_tree()<CR>', { noremap = true, silent = true })
    end
}
