-- Currently this causes an issue with syntax highlighting with java files.
--   https://github.com/terrastruct/d2-vim/issues/26
return {
    enabled = false,
    "J-Cowsert/classlayout.nvim",
    ft = { "c", "cpp" },
    opts = {},
    -- opts = {
        -- keymap = "<leader>cl",
        -- compiler = "clang",
        -- args = {},
        -- compile_commands = true,
        -- }
}
