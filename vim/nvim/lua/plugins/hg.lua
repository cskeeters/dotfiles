return {
    enabled = true,
    'cskeeters/vim-hg',
    lazy = false,
    keys = {

        -- HgAnnotate will open a new buffer with a diff for the commit in
        -- which the line at the cursor was last added or modified.  It will
        -- also include a log of every commit that included the current file.
        -- by pressing gd on one of these log lines, you jump to a new buffer
        -- showing the diff for that revision.
        --
        -- HgAnnotate maps gf and gF go version of open file and open file line
        -- that work in this context.

        { '<LocalLeader>ma', '<cmd>HgAnnotate<cr>',   noremap = true, desc="Annotates the current file (hg blame)" },
        { '<LocalLeader>ml', '<cmd>HgGlog<cr>',       noremap = true, desc="Shows mercurial graph log (hg gl)" },

        --{ '<LocalLeader>hd', '<cmd>HgDiff<cr>',       noremap = true, desc="Shows the changes in the current file (hg diff)" },

        -- These is mapped by HgAnnotate
        -- { '<LocalLeader>hg', '<cmd>HgGoFile<cr>',     noremap = true, desc="Opens the file from status" },
        -- { '<LocalLeader>hg', '<cmd>HgGoFileLine<cr>', noremap = true, desc="Opens the file from status" },
    },
}
