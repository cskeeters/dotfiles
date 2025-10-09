return {
    enabled = true,
    'cskeeters/javadoc.nvim',
    ft="java", -- Lazy load this plugin as soon as we open a file with java filetype
    init = function()
        vim.g.javadoc_path="/Users/chad/local_reference/java8_doc/api"
    end,
    keys = {
        {'K', '<Plug>JavadocOpen', buffer=true, ft="java", desc='Open javadoc api to work under cursor'},
    },
}
