-- BrowserSync {args}	run browser-sync server with args
-- BrowserOpen {args}	open browser-sync, if browser-sync is not start, start it with args
-- BrowserPreview {-f --port 3000}	preview current file with browser sync
-- BrowserRestart	restart browser sync
-- BrowserStop	stop browser sync
-- TagRename {newname}	rename html tag
-- HurlRun {args}	Run Hurl, when in Visual mode, run selected snippets
-- Npm {args}	Run npm, e.g. npm -i package-name
-- Yarn {args}	Run yarn, e.g. yarn add package-name
-- Pnpm {args}	Run pnpm, e.g. pnpm add package-name
-- Npx {args}	Run npx, e.g. npx add package-name
-- Node {args}	Run node, e.g. node script.js
-- JobStop {jobid}	Stop job by jobid, stop last unfinished job if jobid is nil

return {
    enabled = true,
    'ray-x/web-tools.nvim',
    lazy = false,
    config = function()
        require('web-tools').setup({
            keymaps = {
                rename = nil,  -- by default use same setup of lspconfig
                --repeat_rename = '.', -- . to repeat
            },
            hurl = {  -- hurl default
                show_headers = false, -- do not show http headers
                floating = false,   -- use floating windows (need guihua.lua)
                json5 = false,      -- use json5 parser require json5 treesitter
                formatters = {  -- format the result by filetype
                json = { 'jq' },
                html = { 'prettier', '--parser', 'html' },
                },
            },
        })
    end,

}
