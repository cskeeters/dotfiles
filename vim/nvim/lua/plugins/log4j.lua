return {
    enabled = true,
    'cskeeters/vim-log4j',
    ft="java", -- Lazy load this plugin as soon as we open a file with java filetype
    keys = {
        {'<LocalLeader><LocalLeader>ld', '<cmd>Log4jDebug<cr>', buffer=true, ft="java", desc='Add line in log4j.properties to enable DEBUG for the current class'},
    },
}
