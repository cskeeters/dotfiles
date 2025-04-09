local function inGit()
    return "" ~= vim.fn.finddir('.git', vim.fn.getcwd() .. ";")
end

local function inHg()
    return "" ~= vim.fn.finddir('.hg', vim.fn.getcwd() .. ";")
end

local function fzf_rcs_files()
    if inGit() then
        vim.cmd("FzfLua git_files")
    elseif inHg() then
        vim.cmd('lua require("fzf-lua").files({cmd = "hg status -namcu"})')
    else
        print("No repository found")
    end
end

local function fzf_rcs_changed_files()
    if inGit() then
        vim.cmd([[lua require("fzf-lua").files({cmd = "git status -s | awk '{print $2}' "})]])
    elseif inHg() then
        vim.cmd('lua require("fzf-lua").files({cmd = "hg status -n"})')
    else
        print("No repository found")
    end
end

local function parse_line(value)
    local _, _, trigger, path, line = string.find(value, "([^%s]+)%s*-%s*([^:]+):(%d+)")
    return trigger, path, line
end

local edit_snippet = function(selected, opts)
    for k, value in pairs(selected) do
        local _, path, line = parse_line(value)
        -- Open file
        vim.cmd('e '..vim.fn.fnameescape(path))
        -- Jump to line
        vim.cmd('execute "normal! '..line..'G"')
    end
end

local grep_word = function()
    local search = vim.fn.expand("<cword>")
    print("Searching for:", search)
    -- require('fzf-lua').files({ fzf_opts = { ['--query'] = vim.fn.shellescape(txt) } })
    vim.cmd("FzfLua grep search="..search)
end
-- vim.keymap.set('n', '<leader>F', function() files("'"..vim.fn.expand('<cword>')) end, { silent = true });


function GenerateDefaultPaths(fzf_cb)
    coroutine.wrap(function()
        local co = coroutine.running()

        local HOME = os.getenv("HOME")
        local path = HOME.."/.paths"
        local f = io.open(path, "rb")
        if not f then
            -- signal EOF to fzf and close the named pipe
            -- this also stops the fzf "loading" indicator
            fzf_cb()
            return
        end

        for line in io.lines(path) do
            -- coroutine.resume only gets called once uv.write completes
            fzf_cb(line, function() coroutine.resume(co) end)

            -- wait here until 'coroutine.resume' is called which only happens
            -- once 'uv.write' completes (i.e. the line was written into fzf)
            -- this frees neovim to respond and open the UI
            coroutine.yield()
        end

        -- signal EOF to fzf and close the named pipe
        -- this also stops the fzf "loading" indicator
        fzf_cb()
    end)()
end


function ChangeProject()
    local opts = {
        fzf_opts = {
            ['--delimiter'] = [[	]],
            ['--with-nth'] = '2..',
        },
        debug_cmd=false, -- change to true and use :messages to see fzf command issued
        actions = {
            ['default'] = function(selected, _)
                for _, line in ipairs(selected) do
                    local _, _, dir = string.find(line, '^(.*)	')
                    vim.cmd("lcd "..dir)
                    vim.cmd("e .")
                    vim.notify("lcd "..dir);
                end
            end
        },
    }

    require'fzf-lua'.fzf_exec(GenerateDefaultPaths, opts)
end

function GeneratePrinters(fzf_cb)
    coroutine.wrap(function()
        local co = coroutine.running()

        local printers = vim.fn.systemlist("lpstat -p | sed -nre 's/printer ([^[:space:]]+) .*/\\1/p'")

        for _, printer in ipairs(printers) do
            -- coroutine.resume only gets called once uv.write completes
            fzf_cb(printer, function() coroutine.resume(co) end)

            -- wait here until 'coroutine.resume' is called which only happens
            -- once 'uv.write' completes (i.e. the line was written into fzf)
            -- this frees neovim to respond and open the UI
            coroutine.yield()
        end

        -- signal EOF to fzf and close the named pipe
        -- this also stops the fzf "loading" indicator
        fzf_cb()
    end)()
end

function SetDefaultPrinter()
    local opts = {
        debug_cmd=false, -- change to true and use :messages to see fzf command issued
        actions = {
            ['default'] = function(selected, _)
                -- We loop here, but only one will actually be selected
                for _, printer_name in ipairs(selected) do
                    vim.cmd("!lpoptions -d "..printer_name)
                    vim.notify("Set "..printer_name.." as default");
                end
            end
        },
    }

    require'fzf-lua'.fzf_exec(GeneratePrinters, opts)
end

local function split2(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end

function split(inputstr, sep)
    sep=sep or '%s'
    local t={}
    for field, s in string.gmatch(inputstr, "([^"..sep.."]*)("..sep.."?)") do
        table.insert(t,field)
        if s=="" then
            return t
        end
    end
end

function GenerateUnicode(fzf_cb)
    local utf8 = require 'lua-utf8'

    coroutine.wrap(function()
        local co = coroutine.running()

        -- Load Unicode category map
        local categories = {}
        for line in io.lines(os.getenv("HOME").."/.local/share/unicode/categories") do
            local _, _, abbr, category = line:find("^(..) (.*)")
            categories[abbr] = category
        end

        -- Iterate through lines that store data about each unicode character
        -- From (Can modify to meet you needs:
        --   https://www.unicode.org/Public/UNIDATA/UnicodeData.txt
        -- * Can modify with:
        --     g/;CJK COMP/d
        --     g/Private Use/d
        for line in io.lines(os.getenv("HOME").."/.local/share/unicode/UnicodeData.txt") do
            local data = split(line, ";")
            -- print(vim.inspect(split(line, ";")))

            -- Generate Name
            local name = data[2]
            local name_1 = data[11]
            if name_1 ~= nil then
                if name_1 ~= "" then
                    if name == "<control>" then
                        -- Nice to use Unicode 1.0 names for characters that have the name: <control>
                        name = name_1
                    end
                end
            end

            -- Generate desc from name/category
            local category_abbr = data[3]

            local category = category_abbr

            if categories[category_abbr] ~= nil then
                category = string.format("%s - %s", category_abbr, categories[category_abbr])
            end

            local desc = string.format("%s (%s)", name, category)

            -- Generate fzf_line for fzf (Use tab delimiter instead of ; for generated lines)
            local code = data[1]
            local fzf_line = string.format("%s	%-80s	%s (%s)", code, desc, " ", code)
            if name ~= "<control>" then
                fzf_line = string.format("%s	%-80s	%s (%s)", code, desc,  utf8.char(tonumber(code, 16)), code)
            end

            -- coroutine.resume only gets called once uv.write completes
            fzf_cb(fzf_line, function() coroutine.resume(co) end)

            -- wait here until 'coroutine.resume' is called which only happens
            -- once 'uv.write' completes (i.e. the line was written into fzf)
            -- this frees neovim to respond and open the UI
            coroutine.yield()
        end

        -- signal EOF to fzf and close the named pipe
        -- this also stops the fzf "loading" indicator
        fzf_cb()
    end)()
end

function SelectUnicode()
    local utf8 = require 'lua-utf8'

    local opts = {
        debug_cmd=true, -- change to true and use :messages to see fzf command issued
        actions = {
            ['default'] = function(selected, _)
                -- We loop here, but only one will actually be selected
                for _, char in ipairs(selected) do
                    local code = tonumber(char, 16)
                    if code then
                        -- vim.fn.setreg('*', utf8.char(code))
                        vim.cmd.normal('i' .. utf8.char(code))
                        vim.notify("Set register "..char);
                    else
                        vim.notify(string.format("Code %s is not a number.", char));
                    end
                end
            end
        },
        fzf_opts = {
            ["-d"] = "	",
            ["--tabstop"] = '1',
            ["--with-nth"] = '2..',
            ["--accept-nth"] = 1,
        }
    }

    require'fzf-lua'.fzf_exec(GenerateUnicode, opts)
end

function StartLSP()
    require'fzf-lua'.fzf_exec(require('lspconfig.util').available_servers(), {
        debug_cmd=false, -- change to true and use :messages to see fzf command issued
        actions = {
            ['default'] = function(selected, _)
                -- We loop here, but only one will actually be selected
                for _, name in ipairs(selected) do
                    vim.notify("Starting LSP " .. name);
                    -- vim.lsp.stop_client(id, true)
                    vim.cmd("LspStart "..name)

                    -- local config = require('lspconfig.configs')[server_name]
                    -- if config then
                        -- config.launch()
                        -- return
                    -- end

                end
            end
        },
    })
end

function StopLSP()
    local options = {}
    for _, client in ipairs(vim.lsp.get_clients()) do
        local option = string.format("%s (%d)", client.name, client.id)
        table.insert(options, option)
    end

    require'fzf-lua'.fzf_exec(options, {
        debug_cmd=false, -- change to true and use :messages to see fzf command issued
        actions = {
            ['default'] = function(selected, _)
                -- We loop here, but only one will actually be selected
                for _, opt in ipairs(selected) do
                    local s, _, name, id_str = string.find(opt, "(.*) %(([%d]+)%)")
                    if s ~= nil then
                        local id = tonumber(id_str)
                        if id ~= nil then
                            vim.notify("Disabling LSP " .. name .. " (" .. id .. ")");
                            vim.lsp.stop_client(id, true)
                            -- Could also execute
                            -- vim.cmd("LspStop "..id_str.." ++force")
                        else
                            vim.notify("ID (" .. id_str .. ") not a number ");
                        end
                    else
                        vim.notify("Could not parse result (" .. opt .. ")");
                    end

                end
            end
        },
    })
end

local border
border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' }
local profile = "default"
if not vim.g.nerd_font then
    border = "single"
    profile = "max-perf"
end

return {
  "cskeeters/fzf-lua",
  -- cskeeters branch customizes keymap format
  branch = "cskeeters",
  enabled = true,
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- calling `setup` is optional for customization
    require("fzf-lua").setup({
        { profile },
        winopts = {
            fullscreen = true,
            -- Use square corners when nerd font is not installed
            border = border,
            preview = {
                -- el7 doesn't have bat
                default="cat",
                --border = 'noborder',
            }
        },
    })

    -- To speed up, install fd.  This will automatically be used
    -- brew install fd
    -- apt-get install fd-find
    -- Debian renamed fd to fdfind https://packages.debian.org/bullseye/fd-find

    -- https://github.com/ibhagwan/fzf-lua#commands

    -- Replace vim.ui.select menu
    -- vim.cmd[[FzfLua register_ui_select]]
    require("fzf-lua").register_ui_select()

    vim.keymap.set({'n'}, '<Leader>r', ':FzfLua resume<cr>', { desc="Reopen fzf dialog" })

    -- Search history ??
    --vim.keymap.set({'n'}, '<Leader>s', ':FzfLua search_history<cr>', { desc="??" })

    -- Execute Keymap
    vim.keymap.set('n', '<Leader>k', ':FzfLua keymaps<cr>', { desc="Execute keymap" })
    --vim.keymap.set('n', '<Leader>c', ':FzfLua commands<cr>', { desc="Execute command" })
    vim.keymap.set('n', '<Leader>H', ':FzfLua command_history<cr>', { desc="Execute command from history" })

    -- This slows down exiting macros
    -- vim.keymap.set('n', 'q:',        ':FzfLua command_history<cr>', { desc="Execute command from history" })


    -- Open file
    -- vim.keymap.set('n', '<Leader>of', ':FzfLua files<cr>',     { desc="Open file in current directory tree (fzf)" })
    -- vim.keymap.set('n', '<Leader>or', fzf_rcs_files, { desc="Open file in git repository (fzf/git/hg)" })
    -- vim.keymap.set('n', '<Leader>om', fzf_rcs_changed_files, { desc="Open file modified in repository (fzf/git/hg)" })


    -- vim.keymap.set('n', '<Leader>oo', ':FzfLua oldfiles<cr>',  { desc="Open Old file from history (fzf)" })
    -- vim.keymap.set('n', '<Leader>ob', ':FzfLua buffers <cr>', { desc="Open Buffer (selected via fzf)" })

    -- Specific, commonly opened locations
    -- vim.keymap.set('n', '<Leader>oc', ':FzfLua files cwd=~/.config/nvim<cr>', { desc="Open vim Config file (fzf)" })
    -- vim.keymap.set('n', '<Leader>op', ':FzfLua files cwd=~/.local/share/nvim<cr>', { desc="Open vim Plugin file (fzf)" })
    -- vim.keymap.set('n', '<Leader>on', ':FzfLua files cwd=~/Library/CloudStorage/Dropbox/notes<cr>', { desc="Open Note (fzf)" })

    -- Jump to line
    vim.keymap.set('n', '<Leader>jb', ':FzfLua blines previewer=none<cr>', { desc="Jump to line in current buffer (fzf)" })
    vim.keymap.set('n', '<Leader>jB', ':FzfLua lines previewer=none<cr>',  { desc="Jump to line in open buffers (fzf)" })
    vim.keymap.set('n', '<Leader>jm', ':FzfLua marks<cr>',  { desc="Jump to line from mark (fzf)" })

    -- Misc
    vim.keymap.set('n', '<Leader>pr', ':FzfLua registers<cr>',  { desc="Paste register (fzf)" })
    vim.keymap.set('n', '<Leader><Leader>ft', ':FzfLua filetypes<cr>',  { desc="Select filetype to by applied to the current buffer setf (fzf)" })
    vim.keymap.set('n', '<LocalLeader>.', ':FzfLua spell_suggest<cr>',  { desc="Suggest spelling (fzf)" })

    -- vim.keymap.set({'n'}, '<Leader>ft', ':FzfLua tabs<cr>', { desc="Find tab" })

    -- Jump to file/line
    vim.keymap.set('n', '<Leader>js', ':FzfLua btags<cr>',  { desc="Jump to method signature in current buffer (fzf/ctags)" })
    vim.keymap.set('n', '<Leader>jS', ':FzfLua tags<cr>',  { desc="Jump to method signature in current directory (fzf/ctags)" })
    vim.keymap.set('n', '<Leader>jt', ':FzfLua tagstack<cr>',  { desc="Jump in tagstack (fzf)" })
    vim.keymap.set('n', '<Leader>jj', ':FzfLua jumps<cr>',  { desc="Jump in jumps (fzf)" })
    vim.keymap.set('n', '<Leader>jc', ':FzfLua changes<cr>',  { desc="Jump in changes (fzf)" })

    vim.keymap.set('n', '<Leader>jq', ':FzfLua quickfix<cr>', { desc="Jump to file/line from Quickfix (fzf)" })
    vim.keymap.set('n', '<Leader>jQ', ':FzfLua quickfix_stack<cr>', { desc="Change quickfix stack (fzf)" })
    vim.keymap.set('n', '<Leader>jl', ':FzfLua loclist<cr>', { desc="Jump to file/line location list (fzf)" })
    vim.keymap.set('n', '<Leader>jL', ':FzfLua loclist_stack<cr>', { desc="Change location list stack (fzf)" })


    -- Searching for Text
    vim.keymap.set('n', '<Leader>jw', grep_word, { noremap=true, desc="Searches directory for the word under the cursor" })

    vim.keymap.set('n', '<Leader>jg',  ':FzfLua grep<cr>', { desc="Jump to line found by text search (fzf grep)" })
    vim.keymap.set('n', '<Leader>jlg', ':FzfLua live_grep<cr>', { desc="Jump to line found by text search (fzf live_grep)" })
    vim.keymap.set('n', '<Leader>jng', ':FzfLua live_grep_native<cr>', { desc="Jump to line found by text search (fzf live_grep_native)" })

    vim.keymap.set('n', '<Leader>jng', ':FzfLua live_grep_native<cr>', { desc="Jump to line found by text search (fzf live_grep_native)" })

    vim.keymap.set('n', '<Leader>jh', ':FzfLua help_tags<cr>', { desc="Jump to help tag (fzf)" })
    vim.keymap.set('n', '<Leader>m',  ':FzfLua man_pages<cr>', { desc="Jump to manpage" })


    --vim.keymap.set({'n'}, '<Leader>flg', ':FzfLua grep_last<cr>', { desc="Find text with last search" })
    -- vim.keymap.set({'n'}, '<Leader><Tab>', '<Plug>(fzf-maps-n)', { desc="Search normal mode maps" })

    vim.keymap.set('n', '<Leader>d', ChangeProject, { desc="Change Project/Directory" })

    vim.keymap.set('n', '<localleader>p', SetDefaultPrinter, { desc="Set Default Printer" })
    vim.keymap.set('n', '<leader><leader>u', SelectUnicode, { desc="Select Unicode" })

    vim.keymap.set('n', '<localleader><localleader>lsp_stop', StopLSP, { desc="Stop LSP" })
    vim.keymap.set('n', '<localleader><localleader>lsp_start', StartLSP, { desc="Start LSP" })

    if not vim.fn.has("gui_running") then
        vim.keymap.set('i', '<c-x><c-k>', '<Plug>(fzf-complete-word)', { desc="Use fzf to find word to insert" })
        vim.keymap.set('i', '<c-x><c-f>', '<Plug>(fzf-complete-path)', { desc="Use fzf to find file name to insert" })
        vim.keymap.set('i', '<c-x><c-j>', '<Plug>(fzf-complete-file-ag)', { desc="Use fzf to find file name to insert with ag" })
        vim.keymap.set('i', '<c-x><c-l>', '<Plug>(fzf-complete-line)', { desc="Use fzf to find line to insert" })
    end
  end
}
