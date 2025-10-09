-- Set this to a higher number to handle slow connections
Speed=0

local config_path = vim.fn.stdpath("config")
-- local data_path = vim.fn.stdpath("data")

-- Settings that might likely change should be at the top
-- vim.opt.comments="n:\""
-- vim.opt.comments="n:>"
-- vim.opt.comments="n://"
-- vim.opt.comments="sr:/***,m:*,elx:***/"

-- unnamed/unnamedplus allows copies to affect Macos Clipboard
-- unnamedplus affects the linux clipboard
-- unnamed affects the linux primary selection (middleclick)
vim.opt.clipboard='unnamedplus'
if vim.env.FORCE_OSC52 == 'true' then -- This can be set in ~/.ssh/config for remote terminals
    -- vim.g.clipboard = 'osc52' -- this does copy and paste

    -- Don't trigger OSC52 paste on p/P for security and to avoid ghostty popup.
    -- Use Cmd+v or Ctrl+Shift+v or MiddleClick to paste from OS.
    vim.g.clipboard = {
        name = 'OSC 52',
        copy = {
            ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
            ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
        },
        paste = {
            -- This function returns Neovim's internal unnamed register 
            -- instead of asking the terminal (Ghostty) for clipboard data.
            ['+'] = function() return { vim.fn.split(vim.fn.getreg('"'), '\n'), vim.fn.getregtype('"') } end,
            ['*'] = function() return { vim.fn.split(vim.fn.getreg('"'), '\n'), vim.fn.getregtype('"') } end,
        },
    }
end


vim.opt.mouse="a"                      -- Use a normally
vim.opt.mouse="i"                      -- When used in ssh, disabling mouse allows copy and paste
vim.keymap.set({'i'}, '<S-Insert>', '<MiddleMouse>')

vim.opt.textwidth=0                 -- Desired max line width. 0: none  Used in autoformatting (gq)
vim.opt.wildignore={
    'tags',
    'a.out',
    'depmod',
    '*.so',
    '*.a',
    '*.o',
    '*.dep',
    '*.class',
    '*.pyc'}

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

---- Context
vim.opt.colorcolumn = '80'           -- Show col for max line length
vim.opt.number = true                -- Show line numbers
vim.opt.relativenumber = true        -- Show relative line numbers
vim.opt.scrolloff = 6                -- Min num lines of context
vim.opt.signcolumn = "yes"           -- Show the sign column
vim.opt.modeline = true              -- enables "vim: tw=80 noet sw=2" in files to change settings
vim.opt.showcmd = true               -- Shows partial key sequences
vim.opt.joinspaces = true            -- When joining lines that end with sentance punctuation, use two spaces

if Speed < 1 then
    vim.opt.cursorline = true
    vim.opt.colorcolumn="+0"         -- Use textwidth variable
end

if Speed > 0 then
    vim.opt.synmaxcol=200            -- Don't highlight text past N'th char/line  Default 3000
    vim.opt.lazyredraw = true        -- Don't redraw screen while executing macros
    vim.opt.regexpengine=1           -- 1: Old regex engine
end

vim.opt.foldenable = false           -- disable folding completely

-- This is used for configuring lualine
vim.g.nerd_font = true

-- This will be overwritten if lualine is loaded
vim.opt.statusline="  %1* %{getcwd()} %0*" ..                       -- current root or dir
                   "  %2* %f%m %0*" ..                              -- Filename/Modified
                   "%=" ..                                          -- Right Aligned
                   "%v/%l/%L " ..                                   -- cursor pos
                   "  %3* %{&ft} %0* " ..                           -- Filetype
                   "%{&fenc?&fenc:&enc}/%{&ff} " ..                 -- Encoding/EOL
                   "%w" ..                                          -- Preview
                   "%r"                                             -- Read Only

vim.opt.rulerformat="%30(%=%y%m%r%w %l,%r%V %p%)"


vim.opt.list = true
vim.opt.listchars = "tab:> ,trail:+,extends:#,nbsp:."
if vim.fn.has('multi_byte') then
        -- For some reason UTF characters are not showing in vim
        vim.opt.listchars = "trail:·,precedes:«,extends:»,tab:▸·"
        vim.opt.listchars = "trail:·,precedes:«,extends:»,tab:▸·,nbsp:·"
        -- vim.opt.listchars = "trail:·,precedes:«,extends:»,tab:▸·,nbsp:·eol:↲"
end

-- border for hover windows like the popup window for K
vim.o.winborder = "rounded"

---- Filetypes
vim.opt.encoding = 'utf8'            -- String encoding to use
vim.opt.fileencoding = 'utf8'        -- File encoding to use

---- Theme
vim.opt.syntax = "ON"                -- Allow syntax highlighting
vim.opt.termguicolors = true         -- Used for terminal emulator or console
--This needs to be turned off for ttyd/vhs
vim.opt.termguicolors = true         -- If term supports ui color then enable
if os.getenv("TERM") == "linux" then
    -- We're on the console, elflord doesn't look terrible
    vim.cmd([[colorscheme elflord]])
else
    vim.cmd([[colorscheme habamax]])
end

---- Search
vim.opt.incsearch = true             -- Use incremental search
vim.opt.hlsearch = true              -- Highlight search matches
vim.opt.ignorecase = true            -- Ignore case in search patterns
vim.opt.smartcase = true             -- Override ignorecase if search contains capitals

---- Whitespace
vim.opt.expandtab = true             -- Use spaces instead of tabs
vim.opt.shiftwidth = 4               -- Size of an indent
vim.opt.softtabstop = 4              -- Number of spaces tabs count for in insert mode
vim.opt.tabstop = 4                  -- Number of spaces tabs count for
vim.opt.shiftround = true            -- >> and << will round to the nearest shiftwidth
vim.opt.smarttab = true              -- Make shiftwidth affect spaces added when tabs are typed
vim.opt.linebreak = true

vim.opt.spell = false
vim.opt.spellfile = vim.fn.expand("~/.config/nvim/spell/en.utf-8.add")
vim.opt.spelllang="en_us"
vim.opt.dictionary="/usr/share/dict/words"
vim.opt.thesaurus="~/.config/nvim/mthesaur.txt"


---- Splits
vim.opt.splitright = true            -- Place new window to right of current one
vim.opt.splitbelow = true            -- Place new window below the current one


---- Editing
vim.opt.virtualedit = "block"        -- Block mode allows cursor to go where spaces don't exist
vim.opt.autoindent = true            -- indent at the same level of the previous line
vim.opt.smartindent = false          -- New lines start indented appropriately
vim.opt.cindent = false
vim.opt.wrap = false                 -- wrap long lines
vim.opt.breakindent = true           -- When wrapping, the next line should be indented the same as the first

vim.opt.scrolloff=3                  -- minimum lines to keep above and below cursor
vim.opt.scrolljump=5                 -- lines to scroll when cursor leaves screen
vim.opt.sidescrolloff=5

-- vim.opt.ttimeoutlen=0             -- so multi key sequence doesn't timeout


-- Commands :cmd
-- wildmenu
-- Rather than :Pac<tab> changing to :PackerClean it changes to :Packer so that the user can type I<tab> to get to :PackerInstall
vim.opt.wildmode="list:longest,full" -- command <Tab> completion, list matches, then longest common part, then all.
vim.opt.history=1000                 -- command history size

-- lua setup for local and system-wide packages
local HOME = os.getenv("HOME")
package.cpath = package.cpath .. ";" ..  HOME .. "/.luarocks/lib/lua/5.1/?.so"
package.cpath = package.cpath .. ";" ..  HOME .. "/.luarocks/lib64/lua/5.1/?.so"
package.cpath = package.cpath .. ";/usr/lib/lua/5.1/?.so"
package.cpath = package.cpath .. ";/usr/lib64/lua/5.1/?.so"

---- Movement
vim.opt.cpo:append("J") -- Recognize sentences by two spaces after punctuation
-- vim.opt.cpo:remove("J")
vim.opt.tags = {
  'tags',
  '../tags',
  '../../tags',
  '../../../tags'
}

-- vim.opt.printoptions={left="2cm",top="1in",right="2cm",bottom="1in",duplex="off",paper="letter",syntax="y",number="y"}

---- file searching
if vim.fn.executable('ag') then
    -- Make :grep use the silver searcher (ag)
    vim.opt.grepprg = "ag --nogroup --nocolor --column "
    -- vim.opt.grepprg=grep\ -n\
    vim.opt.grepformat = "%f:%l:%c:%m"
end

-- TODO need a way to automatically open the quickfix window
--vim.cmd [[
--augroup quickfix
--    autocmd!
--    " Open quickfix window by default after helpgrep or the like
--    autocmd QuickFixCmdPost [^l]* nested cwindow
--    autocmd QuickFixCmdPost    l* nested lwindow
--augroup END
--]]

-- Insert mode for new teriminals
vim.cmd[[autocmd TermOpen * startinsert]]

vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.keymap.set('n', '<Leader><Leader>l', ':Lazy<cr>', { desc="Opens the Lazy Package Manager UI" })
vim.keymap.set('n', '<Leader><Leader>m', ':Mason<cr>', { desc="Runs Mason (Language Server Manager)" })

---- Non Plugin Mappings

vim.keymap.set({'n'}, '<Leader>b', '<Cmd>tabnew<Cr>', { silent=true })
vim.keymap.set({'n','v'}, '<Leader>o', '<Nop>', { silent=true })
vim.keymap.set({'n','v'}, 'Q', ':echom "Exmode Disabled"<cr>', { noremap=true, silent=true, desc="Does nothing"})

-- This slows down exiting macro
--vim.keymap.set({'n','v'}, 'q:', ':echom "Command Search Disabled"<cr>', { noremap=true, silent=true, desc="Does nothing"})


-- Jump to tag in vertical split instead of horizonal (default)
vim.keymap.set('n', '<c-w>]', ':vertical wincmd ]<cr>', { noremap=true, silent=true, desc="Opens a new veritcal split when jumping to tag"})

---- Keyboard Mappings: Built-in

vim.keymap.set('n', '<leader>w',  ':bdelete<cr>',  { noremap=true, silent=true, desc="Closes a buffer" })
vim.keymap.set('n', '<leader>gw', ':bdelete!<cr>', { noremap=true, silent=true, desc="Closes a buffer (Without Saving!)" })

-- Yank from the cursor to the end of the line, to be consistent with C and D.
vim.keymap.set('n', 'Y', 'y$', { noremap=true, silent=true, desc="Copies text from cursor to the end of the line"})

vim.keymap.set('n', 'x', '"_x', { noremap=true, silent=true, desc="Remove character without affecting the unnamed register" })
vim.keymap.set('v', 'x', '"_x', { noremap=true, silent=true, desc="Remove character(s) without affecting the unnamed register" })
vim.keymap.set('n', 'X', '"_X', { noremap=true, silent=true, desc="Remove character before without affecting the unnamed register" })
vim.keymap.set('n', 'c', '"oc', { noremap=true, silent=true, desc="Change operator (current value to o register)" })
vim.keymap.set('v', 'c', '"oc', { noremap=true, silent=true, desc="Change the selected text (current value to o register)" })
vim.keymap.set('n', 'C', '"oC', { noremap=true, silent=true, desc="Replace the rest of the line without affecting clipboard" })
-- Use P to paste without wiping out unnamed register

vim.keymap.set('v', '<LocalLeader>d', '"_d', { noremap=true, desc="Remove selected text without affecting the unnamed register" })

function Reset()
    vim.cmd('nohlsearch')

    local status_ok, luasnip = pcall(require, "luasnip")
    if status_ok then
        luasnip.unlink_current()
    end
end


vim.keymap.set('n', '<C-l>', Reset, { noremap=true, silent=true, desc="Disable search highlight and unlink snippet" })

vim.keymap.set('n', '<Leader>s', ':update<cr>', { noremap=true, silent=true, desc="Save the buffer" })

-- Go to tab by number
-- vim.keymap.set('n', '<Leader>1', '1gt', { noremap=true, desc="Switch to tab number 1" })
-- vim.keymap.set('n', '<Leader>2', '2gt', { noremap=true, desc="Switch to tab number 2" })
-- vim.keymap.set('n', '<Leader>3', '3gt', { noremap=true, desc="Switch to tab number 3" })
-- vim.keymap.set('n', '<Leader>4', '4gt', { noremap=true, desc="Switch to tab number 4" })
-- vim.keymap.set('n', '<Leader>5', '5gt', { noremap=true, desc="Switch to tab number 5" })
-- vim.keymap.set('n', '<Leader>6', '6gt', { noremap=true, desc="Switch to tab number 6" })
-- vim.keymap.set('n', '<Leader>7', '7gt', { noremap=true, desc="Switch to tab number 7" })
-- vim.keymap.set('n', '<Leader>8', '8gt', { noremap=true, desc="Switch to tab number 8" })
-- vim.keymap.set('n', '<Leader>9', '9gt', { noremap=true, desc="Switch to tab number 9" })
-- vim.keymap.set('n', '<Leader>0', ':tablast<cr>', { noremap=true, desc="Switch to last tab" })

require("chad.dir") -- Working Directory Helpers

require("chad.cmd-mode-emacs") -- emacs Shortcuts in cmd

-- File formats
vim.keymap.set('n', '\\\\ffu', ':set ff=unix<CR>', { noremap = true, desc="Change to unix file format" })
vim.keymap.set('n', '\\\\ffd', ':set ff=dos<CR>', { noremap = true, desc="Change to dos file format" })
vim.keymap.set('n', '\\\\offu', ':e ++ff=unix<CR>', { noremap = true, desc="Reopen with unix file format" })
vim.keymap.set('n', '\\\\offd', ':e ++ff=dos<CR>', { noremap = true, desc="Reopen with dos file format" })

-- Files as specified on the command line
vim.keymap.set('n', ']f', ':next<CR>', { noremap = true, desc="Open next file specified on the command line" })
vim.keymap.set('n', '[f', ':prev<CR>', { noremap = true, desc="Open prev file specified on the command line" })

-- This will wrap among all buffers
vim.keymap.set('n', ']b', ':bnext<CR>', { noremap = true, desc="Next buffer" })
vim.keymap.set('n', '[b', ':bprev<CR>', { noremap = true, desc="Prev buffer" })

vim.keymap.set('n', ']q', ':cnext<CR>', { noremap = true, desc="Next quickfix" })
vim.keymap.set('n', '[q', ':cprev<CR>', { noremap = true, desc="Prev quickfix" })
vim.keymap.set('n', ']Q', ':cnewer<CR>', { noremap = true, desc="Next quickfix stack" })
vim.keymap.set('n', '[Q', ':colder<CR>', { noremap = true, desc="Prev quickfix stack" })

-- Location List :lgrep :lvimgrep
vim.keymap.set('n', ']l', ':lnext<CR>', { noremap = true, desc="Next location" })
vim.keymap.set('n', '[l', ':lprev<CR>', { noremap = true, desc="Prev location" })
vim.keymap.set('n', ']L', ':lnewer<CR>', { noremap = true, desc="Next location stack" })
vim.keymap.set('n', '[L', ':lolder<CR>', { noremap = true, desc="Prev location stack" })

-- Tag Stack (Although I normall use the jump list CTRL-O)
vim.keymap.set('n', ']t', ':tag<CR>', { noremap = true, desc="Next tag stack" })
vim.keymap.set('n', '[t', ':pop<CR>', { noremap = true, desc="Prev tag stack" })

-- Jump List
vim.keymap.set('n', ']j', '<c-I>', { noremap = true, desc="Next jump" })
vim.keymap.set('n', '[j', '<c-O>', { noremap = true, desc="Prev jump" })

-- Change List
-- "mhinz/vim-signify
-- vim.keymap.set('n', ']c', '<plug>(signify-next-hunk)', { noremap = true, desc="Next hunk" })
-- vim.keymap.set('n', '[c', '<plug>(signify-prev-hunk)', { noremap = true, desc="Prev hunk" })

-- Matching Tag List - Loaded with :tselect or g]
vim.keymap.set('n', ']g', ':tnext<CR>', { noremap = true, desc="Next tag" })
vim.keymap.set('n', '[g', ':tprev<CR>', { noremap = true, desc="Prev tag" })

-- CTRL-W_} then cycle through matches in preview window (Not used)
-- vim.keymap.set('n', ']p', ':ptnext<CR>', { noremap = true, desc="Next tag (show in preview window)" })
-- vim.keymap.set('n', '[p', ':ptprev<CR>', { noremap = true, desc="Prev tag (show in preview window)" })

vim.keymap.set('v', '<', '<gv', { noremap = true, desc="Shift left  then reselect the previous selected text (gv)" })
vim.keymap.set('v', '>', '>gv', { noremap = true, desc="Shift right then reselect the previous selected text (gv)" })

vim.keymap.set('n', '\\2', ':setlocal sw=2 ts=2<cr>', { noremap = true, desc="Switch to 2 space indention" })
vim.keymap.set('n', '\\3', ':setlocal sw=3 ts=3<cr>', { noremap = true, desc="Switch to 3 space indention" })
vim.keymap.set('n', '\\4', ':setlocal sw=4 ts=4<cr>', { noremap = true, desc="Switch to 4 space indention" })
vim.keymap.set('n', '\\8', ':setlocal sw=8 ts=8<cr>', { noremap = true, desc="Switch to 8 space indention" })
vim.keymap.set('n', ',,i16', ':setlocal sw=16 ts=16<cr>', { noremap = true, desc="Switch to 16 space indention" })
vim.keymap.set('n', ',,i32', ':setlocal sw=32 ts=32<cr>', { noremap = true, desc="Switch to 32 space indention" })
vim.keymap.set('n', '\\t', ':setlocal noexpandtab<cr>', { noremap = true, desc="Switch to using tabs" })
vim.keymap.set('n', '\\T', ':setlocal expandtab<cr>', { noremap = true, desc="Switch to using spaces" })

-- Not working
-- vim.keymap.set('n', '\\R', ':retab<cr>', { noremap = true, silent=true, desc="Replace whitespace to match tapstop" })
-- vim.keymap.set('v', '\\R', ":retab<cr>", { noremap = true, silent=true, desc="Replace whitespace to match tapstop" })

-- This facilitates copying multiple lines of text from terminal vim
vim.keymap.set('n', '\\n', ':set number relativenumber signcolumn=auto<cr>', { noremap = true, silent=true, desc="Enable line numbers" })
vim.keymap.set('n', '\\N', ':set nonumber norelativenumber signcolumn=no<cr>', { noremap = true, silent=true, desc="Disable line numbers" })

vim.keymap.set('n', '\\s', ':set spell!<cr>', { noremap = true, silent=true, desc="Toggle spell checking" })

vim.keymap.set('n', '\\w', ':set wrap<cr>', { noremap = true, silent=true, desc="Enable line wrapping" })
vim.keymap.set('n', '\\W', ':set nowrap<cr>', { noremap = true, silent=true, desc="disable line wrapping" })

vim.keymap.set('n', '\\\\5', ':syntax sync minlines=500<cr>', { noremap = true, desc="Syntax highlight with previous 500 lines" })
vim.keymap.set('n', '\\\\x', ':syntax sync fromstart<cr>', { noremap = true, desc="Syntax highlight from start (slow)" })

vim.keymap.set('n', '<LocalLeader><LocalLeader>sw', ':w !sudo tee % > /dev/null<cr>', { desc="Writes the file after running sudo" })

vim.keymap.set('n', '<Leader>q', ':q<cr>', { desc="Closes the current window" })

vim.keymap.set('n', '<LocalLeader>w', ':%s/\\s\\+$//<cr>', { desc="Removes all trailing whitespace in current buffer" })

-- I may not need this
--vim.keymap.set('n', '<LocalLeader>p', ':put "<cr>:normal ddkP<cr>', { desc="Paste buffer as a sparate line" })

-- vim.keymap.set('n', '<Leader><Leader>m', ':make<cr>', { desc="Runs make" })

vim.keymap.set('t', '<C-\\>p', '<C-\\><C-o>p<space>', { desc="Paste to Terminal" })

vim.keymap.set('n', '<Leader>gp', 'pv\']=', { desc="Paste and Format" })

vim.keymap.set('n', '<localleader>ggggrmsw', '<cmd>!rm -rf ~/.local/state/nvim/swap/*<CR>', { desc="Removes all neovim swap files" })

vim.keymap.set('n', 'q:', '<nop>', { desc="Disables command history" })
vim.keymap.set('n', 'q/', '<nop>', { desc="Disables command history" })
vim.keymap.set('n', 'q?', '<nop>', { desc="Disables command history" })

-- Enables user to select lines and move them and automatically adjust indent
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")

vim.keymap.set('n', '<localleader>g120', '<cmd>lua vim.opt.textwidth=120<cr>', { desc="Sets textwidth to 120 to enable hard wrapping" })
vim.keymap.set('n', '<localleader><localleader>gs', [[<cmd>exec 'mkspell! ' . &spellfile . '.spl' &spellfile<cr>]], { desc="Regenerate Spelling file (.spl)" })

-- use v to mark the current cursor position
-- <C-w> removes '<,'> that gets inserted by default when pressing ":" in visual block mode
-- %s applies substitute to the entire file, but \%V limits to current visual block selection
-- \u will uppercase the next letter
-- \< matches the start of a word, '.' matches one character.
vim.keymap.set('v', '<localleader>gc', [=[mvugv:<C-w>%s/\%V\<.[^[:space:]]\{3\}/\u&/g<enter><esc>`v<cmd>noh<cr>]=], { desc="Capitalize First Letter of each Word" })

vim.keymap.set('n', '<C-S-l>', [=[<Cmd>vertical resize -1<Cr>]=], { desc="Decrease Vertical Window Size" })
vim.keymap.set('n', '<C-S-h>', [=[<Cmd>vertical resize +1<Cr>]=], { desc="Increase Vertical Window Size" })

vim.keymap.set('n', '<Leader><Leader>i', [=[<Cmd>Inspect<Cr>]=], { desc="Inspect Tree-sitter Highlighting" })
vim.keymap.set('n', '<Leader><Leader>t', [=[<Cmd>InspectTree<Cr>]=], { desc="Tree-sitter Tree (TSPlayground)" })

vim.keymap.set('n', [[<LocalLeader>']], [["_yiWi'<Esc>ea'<Esc>]], { buffer=true, desc='Add single quotes around word' })
vim.keymap.set('n', [[<LocalLeader>"]], [["_yiWi"<Esc>ea"<Esc>]], { buffer=true, desc='Add double quotes around word' })
vim.keymap.set('n', [[<LocalLeader>(]], [["_yiWi(<Esc>ea)<Esc>]], { buffer=true, desc='Add parenthisis around word' })
vim.keymap.set('n', [[<LocalLeader>[]], [["_yiWi[<Esc>ea]<Esc>]], { buffer=true, desc='Add bracket around word' })
vim.keymap.set('n', [[<LocalLeader>{]], [["_yiWi{<Esc>ea}<Esc>]], { buffer=true, desc='Add brace around word' })

vim.keymap.set('v', [[<LocalLeader>']], [[s'<C-r>"'<Esc>]], { buffer=true, desc='Add single quotes around visual selection' })
vim.keymap.set('v', [[<LocalLeader>"]], [[s"<C-r>""<Esc>]], { buffer=true, desc='Add double quotes around visual selection' })
vim.keymap.set('v', [[<LocalLeader>(]], [[s(<C-r>")<Esc>]], { buffer=true, desc='Add parenthisis around visual selection' })
vim.keymap.set('v', [[<LocalLeader>[]], [[s[<C-r>"]<Esc>]], { buffer=true, desc='Add bracket around visual selection' })
vim.keymap.set('v', [[<LocalLeader>{]], [[s{<C-r>"}<Esc>]], { buffer=true, desc='Add brace around visual selection' })


function ToggleConceal()
    if vim.opt.conceallevel:get() == 0 then
        vim.opt.conceallevel = 2
    else
        vim.opt.conceallevel = 0
    end
end

vim.keymap.set('n', [[\c]], ToggleConceal, { desc='Conceal: Toggle' })

vim.keymap.set('n', '<LocalLeader><LocalLeader>c0', '<Cmd>set conceallevel=0<Cr>', { desc='Conceal: Disable' })
vim.keymap.set('n', '<LocalLeader><LocalLeader>c2', '<Cmd>set conceallevel=2<Cr>', { desc='Conceal: Replace with cchar (set list-style)' })
vim.keymap.set('n', '<LocalLeader><LocalLeader>c3', '<Cmd>set conceallevel=3<Cr>', { desc='Conceal: Hide' })

function Hardcopy()
    vim.cmd([[w !lp - ]])
end

vim.api.nvim_create_user_command('Hardcopy', Hardcopy, {force = true})
vim.keymap.set('n', '<space><space><C-p>', Hardcopy, { desc="Hardcopy (Print)" })

-- add this wether OSC52 is detected or not
vim.keymap.set('v', '<leader>y', function()
    vim.cmd([[normal! ]]) -- Exit visual mode right now, setting marks

    local start_pos = vim.fn.getpos("'<") -- returns [bufnum, lnum, col, off]
    local end_pos = vim.fn.getpos("'>")

    local lines = vim.api.nvim_buf_get_text(
        0,
        start_pos[2] - 1,  -- Convert 1-indexed line to 0-indexed
        start_pos[3] - 1,  -- Convert 1-indexed line to 0-indexed
        end_pos[2] - 1,    -- Convert 1-indexed line to 0-indexed
        end_pos[3] - 1,    -- Convert 1-indexed line to 0-indexed
        {} -- No special options needed
    )

    local selected_text = table.concat(lines, "\n")
    local osc52_sequence = string.format('\027]52;c;%s\027\\', vim.base64.encode(selected_text))
    io.stderr:write(osc52_sequence)
end, { desc = "Copy to clipboard via OSC 52" })


-- This enables the lines in the current Quickfix window to be updated after modification (i.e. cdo s/old/new/)
function UpdateQuickfix()
    vim.cmd([[call setqflist(map(getqflist(), 'extend(v:val, {"text":get(getbufline(v:val.bufnr, v:val.lnum),0)})'))]])
end
vim.keymap.set('n', 'gqq', UpdateQuickfix, { desc="Update Quickfix" })

-- Helper Functions

---Outputs all fields and sub-objects of the object provided
---@param o (object) the object to dump
---@return nil
-- NOTE: can also use print(vim.inspect(data))
local function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

-- Netrw Settings
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 0
vim.g.netrw_keepdir = 1 -- having this 0 make harpoon loose track of project (at least for mercurial repos)
vim.g.netrw_bufsettings = 'nomodifiable nomodified readonly number relativenumber nobuflisted nowrap'

-- Enables the use of 'T' to move files and folders to the trash instead of rm
vim.cmd("source "..config_path.."/netrw-trash.vim")

-- To disable netrw
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

vim.api.nvim_create_autocmd("FileType", {
  pattern = "mail",
  callback = function()
    vim.opt_local.filetype = "markdown.mail"
  end,
})

if vim.g.neovide then
    vim.o.guifont = "Hack Nerd Font Mono:h15"
    vim.g.neovide_scroll_animation_length = 0.0
    vim.g.neovide_remember_window_size = true

    -- This might be cool, but hard to get used to
    --vim.g.neovide_cursor_animation_length = 0.13
    vim.g.neovide_cursor_animation_length = 0
    vim.g.neovide_cursor_animate_in_insert_mode = false
    vim.g.neovide_cursor_animate_command_line = false

    -- So we don't start at the root of the machine
    vim.cmd([[cd ~]])

    vim.g.neovide_input_use_logo = 1

    vim.keymap.set('n', '<D-v>', '"+p<Cr>', { desc="macOS Paste" })
    vim.keymap.set('i', '<D-v>', '<C-r>+', { desc="macOS Paste (Insert)" })
    vim.keymap.set('c', '<D-v>', '<C-r>+', { desc="macOS Paste (Command)" })
    vim.keymap.set('t', '<D-v>', '<C-r>+', { desc="macOS Paste (Terminal)" })
    vim.keymap.set('v', '<D-c>', '"+y', { desc="macOS Copy (Visual)" })
end

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        import = "plugins",
    },
    change_detection = {
        enabled = false,
        notify = false
    },
})
