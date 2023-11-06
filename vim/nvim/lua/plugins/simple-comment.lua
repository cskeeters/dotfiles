local function UseDoubleSlash()
    vim.bo.commentstring = '// %s';
    vim.notify("Using // Comment")
end

local function UseMultiLine()
    vim.bo.commentstring = "/* %s */";
    vim.cmd('CommentMultiSlash')
    vim.notify("Using /* Comment */")
end

local function UseHTML()
    vim.bo.commentstring = '<!-- %s -->';
    vim.cmd('CommentMultiXml')
    vim.notify("Using <!-- Comment -->")
end

local function UseLua()
    vim.bo.commentstring = '-- %s';
    vim.notify("Using -- Comment")
end

-- VimScript
local function UseQuote()
    vim.bo.commentstring = '" %s';
    vim.notify('Using " Comment')
end

-- Other comment plugins are great, except for multi-line commenting
return {
    enabled = true,
    'cskeeters/vim-simple-comment',
    lazy = false,
    keys = {
        {'gcc', '<Plug>ToggleComment', desc="Comment current line" },
        {'gc',  '<Plug>ToggleAllComment', mode='v', desc="Comment current line" },
        {'qc',  '<Plug>CommentOperator', desc="Comment Operator"},
        {'ggc', '<Plug>MultiLineComment', mode='v', desc="Comment multiple lines" },

        { '\\/', UseDoubleSlash,     noremap = true, desc="Changes comment string to //" },
        { '\\*', UseMultiLine, noremap = true, desc="Changes comment string to /* */" },
        { '\\!', UseHTML, noremap = true, desc="Changes comment string to <!-- -->" },
        { '\\-', UseLua, noremap = true, desc="Changes comment string to --" },
        { '\\"', UseQuote, noremap = true, desc='Changes comment string to "' },
    },
}
