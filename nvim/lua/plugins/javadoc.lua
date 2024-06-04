return {
    enabled = true,
    'cskeeters/javadoc.nvim',
    ft="java", -- Lazy load this plugin as soon as we open a file with java filetype
    init = function()
        vim.g.javadoc_path="/opt/AMS2/net/doc/java8/api:/usr/local/Solipsys/TDF4.7.13/doc/api:/opt/AMS2/net/doc/apache-log4j-1.2.17/apidocs"
        vim.g.javadoc_debug=0
    end,
    keys = {
        {'K', '<Plug>JavadocOpen', buffer=true, ft="java", desc='Open javadoc api to work under cursor'},
    },
}
