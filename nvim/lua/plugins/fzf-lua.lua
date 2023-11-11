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
        vim.cmd('lua require("fzf-lua").files({cmd = "git status -s"})')
    elseif inHg() then
        vim.cmd('lua require("fzf-lua").files({cmd = "hg status -n"})')
    else
        print("No repository found")
    end
end

local expand_snip = function(selected, opts)
    for k, value in pairs(selected) do
        local _, _, trigger = string.find(value, "([^%s]+)%s-")
        -- The \\<cr> is required for \\<c-r>= to work
        vim.cmd('execute "normal! a'..trigger.. '\\<c-r>=UltiSnips#ExpandSnippet()\\<cr>"')
    end
end

local function search_snippets()
    vim.fn["UltiSnips#SnippetsInCurrentScope"](1)
    local list = vim.g.current_ulti_dict_info
    local triggers = {}
    for trigger, snipinfo in pairs(list) do
        local desc = snipinfo["description"]
        --local loc = snipinfo["location"]
        table.insert(triggers, trigger.." - "..desc)
    end

    -- https://github.com/ibhagwan/fzf-lua/wiki/Advanced#fzf-exec-api
    require'fzf-lua'.fzf_exec(triggers,
      {
          prompt="UltiSnips> ",
          actions = {
              ['default'] = expand_snip,
          },
          fzf_opts = {
              ['--preview-window'] = 'nohidden,down,50%',
              ['--preview'] = require'fzf-lua'.shell.action(function(items)
                  local contents = {}
                  vim.tbl_map(function(x)
                      table.insert(contents, "selected item: " .. x)
                  end, items)
                  return contents
              end)
          }
      })
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

local function edit_snippets()
    vim.fn["UltiSnips#SnippetsInCurrentScope"](1)
    local list = vim.g.current_ulti_dict_info
    local triggers = {}
    for trigger, snipinfo in pairs(list) do
        --local desc = snipinfo["description"]
        local loc = snipinfo["location"]
        table.insert(triggers, trigger.." - "..loc)
    end

    -- https://github.com/ibhagwan/fzf-lua/wiki/Advanced#fzf-exec-api
    require'fzf-lua'.fzf_exec(triggers,
      {
          prompt="Edit UltiSnips> ",
          actions = {
              ['default'] = edit_snippet,
          },
          fzf_opts = {
              ['--preview-window'] = 'nohidden,down,50%',
              ['--preview'] = require'fzf-lua'.shell.preview_action_cmd(function(items)
                  print("PREV", items[1])
                  local _, path, _ = parse_line(items[1])
                  return string.format("bat --style=default --color=always %s", path)
              end)
          }
      })
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
        local path = HOME.."/dotfiles/paths/default"
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
            ['--delimiter'] = [['	']],
            ['--with-nth'] = '2..',
        },
        debug_cmd=false, -- change to true and use :messages to see fzf command issued
        actions = {
            ['default'] = function(selected, _)
                for _, line in ipairs(selected) do
                    local _, _, dir = string.find(line, '^(.*)	')
                    vim.cmd("tcd "..dir)
                    vim.cmd("Explore .")
                    vim.notify("cd "..dir);
                end
            end
        },
    }

    require'fzf-lua'.fzf_exec(GenerateDefaultPaths, opts)
end


vim.keymap.set('n', '<Leader>d', ChangeProject, { desc="Change Project/Directory" })


return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- calling `setup` is optional for customization
    require("fzf-lua").setup({})

    -- https://github.com/ibhagwan/fzf-lua#commands
    vim.env.FZF_DEFAULT_OPTS = nil

    vim.keymap.set({'n'}, '<Leader>r', ':FzfLua resume<cr>', { desc="Reopen fzf dialog" })

    -- Search history ??
    --vim.keymap.set({'n'}, '<Leader>s', ':FzfLua search_history<cr>', { desc="??" })

    -- Execute Keymap
    vim.keymap.set('n', '<Leader>k', ':FzfLua keymaps<cr>', { desc="Execute keymap" })
    vim.keymap.set('n', '<Leader>c', ':FzfLua commands<cr>', { desc="Execute command" })
    vim.keymap.set('n', '<Leader>h', ':FzfLua command_history<cr>', { desc="Execute command from history" })

    -- This slows down exiting macros
    -- vim.keymap.set('n', 'q:',        ':FzfLua command_history<cr>', { desc="Execute command from history" })

    -- Open file
    vim.keymap.set('n', '<Leader>of', ':FzfLua files<cr>',     { desc="Open file in current directory tree (fzf)" })
    vim.keymap.set('n', '<Leader>or', fzf_rcs_files, { desc="Open file in git repository (fzf/git/hg)" })
    vim.keymap.set('n', '<Leader>om', fzf_rcs_changed_files, { desc="Open file modified in repository (fzf/git/hg)" })


    vim.keymap.set('n', '<Leader>oo', ':FzfLua oldfiles<cr>',  { desc="Open Old file from history (fzf)" })
    vim.keymap.set('n', '<Leader>oc', ':FzfLua files cwd=~/.config/nvim<cr>', { desc="Open vim Config file (fzf)" })
    vim.keymap.set('n', '<Leader>op', ':FzfLua files cwd=~/.local/share/nvim<cr>', { desc="Open vim Plugin file (fzf)" })
    vim.keymap.set('n', '<Leader>ob', ':FzfLua buffers <cr>', { desc="Open Buffer (selected via fzf)" })

    -- Jump to line
    vim.keymap.set('n', '<Leader>jb', ':FzfLua blines<cr>', { desc="Jump to line in current buffer (fzf)" })
    vim.keymap.set('n', '<Leader>jB', ':FzfLua lines<cr>',  { desc="Jump to line in open buffers (fzf)" })
    vim.keymap.set('n', '<Leader>jm', ':FzfLua marks<cr>',  { desc="Jump to line from mark (fzf)" })

    -- Misc
    vim.keymap.set('n', '<Leader>pr', ':FzfLua register<cr>',  { desc="Paste register (fzf)" })
    vim.keymap.set('n', '<Leader><Leader>ft', ':FzfLua filetypes<cr>',  { desc="Select filetype to by applied to the current buffer setf (fzf)" })
    vim.keymap.set('n', '<LocalLeader>.', ':FzfLua spell_suggest<cr>',  { desc="Suggest spelling (fzf)" })
    vim.keymap.set('n', '<LocalLeader>s', search_snippets,  { desc="Expand Snippet (fzf)" })
    vim.keymap.set('n', '<LocalLeader><LocalLeader>s', edit_snippets,  { desc="Edit Snippet (fzf)" })
    vim.keymap.set('i', '<C-y>', search_snippets,  { desc="Expand Snippet (fzf)" })

    -- vim.keymap.set({'n'}, '<Leader>ft', ':FzfLua tabs<cr>', { desc="Find tab" })

    -- Jump to file/line
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

    if not vim.fn.has("gui_running") then
        vim.keymap.set('i', '<c-x><c-k>', '<Plug>(fzf-complete-word)', { desc="Use fzf to find word to insert" })
        vim.keymap.set('i', '<c-x><c-f>', '<Plug>(fzf-complete-path)', { desc="Use fzf to find file name to insert" })
        vim.keymap.set('i', '<c-x><c-j>', '<Plug>(fzf-complete-file-ag)', { desc="Use fzf to find file name to insert with ag" })
        vim.keymap.set('i', '<c-x><c-l>', '<Plug>(fzf-complete-line)', { desc="Use fzf to find line to insert" })
    end

  end
}