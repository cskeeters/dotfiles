-- Set this to a higher number to handle slow connections
Speed=0

local config_path = vim.fn.stdpath("config")
-- local data_path = vim.fn.stdpath("data")

-- Settings that might likely change should be at the top
-- vim.opt.comments="n:\""
-- vim.opt.comments="n:>"
-- vim.opt.comments="n://"
-- vim.opt.comments="sr:/***,m:*,elx:***/"

-- unnamed allows copies to affect Macos Clipboard
vim.opt.clipboard='unnamed'
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

if Speed < 1 then
    vim.opt.cursorline = true
    vim.opt.colorcolumn="+0"         -- Use textwidth variable
end

if Speed > 0 then
    vim.opt.synmaxcol=200            -- Don't highlight text past N'th char/line  Default 3000
    vim.opt.lazyredraw = true        -- Don't redraw screen while executing macros
    vim.opt.regexpengine=1           -- 1: Old regex engine
end

-- This will be overwritten if vim-statusline is loaded
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

---- Filetypes
vim.opt.encoding = 'utf8'            -- String encoding to use
vim.opt.fileencoding = 'utf8'        -- File encoding to use

---- Theme
vim.opt.syntax = "ON"                -- Allow syntax highlighting
--This needs to be turned off for ttyd/vhs
vim.opt.termguicolors = true         -- If term supports ui color then enable
vim.cmd([[colorscheme habamax]])

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
vim.opt.spelllang="en_us"
vim.opt.dictionary="/usr/share/dict/words"
vim.opt.thesaurus="~/dotfiles/mthesaur.txt"

---- Splits
vim.opt.splitright = true            -- Place new window to right of current one
vim.opt.splitbelow = true            -- Place new window below the current one


---- Editing
vim.opt.virtualedit = "block"        -- Block mode allows cursor to go where spaces don't exist
vim.opt.autoindent = true            -- indent at the same level of the previous line
vim.opt.cindent = true
vim.opt.smartindent = true           -- New lines start indented appropriately
vim.opt.wrap = false                 -- wrap long lines
vim.opt.breakindent = false          -- When wrapping, the next line should be indented the same as the first

vim.opt.scrolloff=3                  -- minimum lines to keep above and below cursor
vim.opt.scrolljump=5                 -- lines to scroll when cursor leaves screen
vim.opt.sidescrolloff=5

-- vim.opt.ttimeoutlen=0             -- so multi key sequence doesn't timeout


-- Commands :cmd
-- wildmenu
-- Rather than :Pac<tab> changing to :PackerClean it changes to :Packer so that the user can type I<tab> to get to :PackerInstall
vim.opt.wildmode="list:longest,full" -- command <Tab> completion, list matches, then longest common part, then all.
vim.opt.history=1000                 -- command history size


---- Movement
table.insert(vim.opt.cpo,'J')  -- Recognize sentences by two spaces after punctuation
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



vim.g.mapleader = " "
vim.g.maplocalleader = ","

---- Non Plugin Mappings

vim.keymap.set({'n','v'}, '<Leader>', '<Nop>', { silent=true })
vim.keymap.set({'n','v'}, 'Q', ':echom "Exmode Disabled"<cr>', { noremap=true, silent=true, desc="Does nothing"})

-- This slows down exiting macro
--vim.keymap.set({'n','v'}, 'q:', ':echom "Command Search Disabled"<cr>', { noremap=true, silent=true, desc="Does nothing"})


-- Jump to tag in vertical split instead of horizonal (default)
vim.keymap.set('n', '<c-w>]', ':vertical wincmd ]<cr>', { noremap=true, silent=true, desc="Opens a new veritcal split when jumping to tag"})

---- Keyboard Mappings: Built-in

-- Yank from the cursor to the end of the line, to be consistent with C and D.
vim.keymap.set('n', 'Y', 'y$', { noremap=true, silent=true, desc="Copies text from cursor to the end of the line"})

vim.keymap.set('n', 'x', '"_x', { noremap=true, silent=true, desc="Remove character without affecting the unnamed register" })
vim.keymap.set('n', 'X', '"_X', { noremap=true, silent=true, desc="Remove character before without affecting the unnamed register" })

vim.keymap.set('v', '<LocalLeader>d', '"_d', { noremap=true, desc="Remove selected text without affecting the unnamed register" })

vim.keymap.set('n', '<C-l>', ':nohlsearch<cr>', { noremap=true, silent=true, desc="Disable search highlight" })

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
vim.keymap.set('n', ']c', '<plug>(signify-next-hunk)', { noremap = true, desc="Next hunk" })
vim.keymap.set('n', '[c', '<plug>(signify-prev-hunk)', { noremap = true, desc="Prev hunk" })

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

vim.keymap.set('n', '<Leader><Leader>m', ':make<cr>', { desc="Runs make" })

vim.cmd.iabbrev({ "<expr>", "dts", 'strftime("%FT%T%z")' })
vim.cmd.iabbrev({ "<expr>", "nds",  'strftime("%Y-%m-%d")' })
vim.cmd.iabbrev({ "<expr>", "ds",  'strftime("%Y-%b-%d")' })

-- Helper Functions
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

-- Enables the use of 'T' to move files and folders to the trash instead of rm
vim.cmd("source "..config_path.."/netrw-trash.vim")

-- To disable netrw
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1


if vim.g.neovide then
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

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

vim.keymap.set('n', '<Leader><Leader>l', ':Lazy<cr>', { desc="Opens the Lazy Package Manager UI" })

