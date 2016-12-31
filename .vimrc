" NOTE: FormatMatch osx application prevents visual block selections from being yanked and pasted

" vim: set ft=vim:

set nocompatible
" vi-compatible sentences have two spaces after them.
set cpo+=J " Recognize sentences by two spaces after punctuation

scriptencoding utf-8
set encoding=utf-8
set fileencoding=utf-8

set tags=tags
set tags+=../tags
set tags+=../../tags
set tags+=../../../tags
"set tags+=../../../../tags
"set tags+=../../../../../tags
" mkdir -p tags
" cd ~/tags
" ctags -R /usr/include
"set tags+=/home/chad/tags/tags.inc

if &shell =~# 'fish$'
    set shell=sh
endif

set expandtab                   " tabs are spaces, not tabs (et)
set shiftwidth=4                " use indents of 4 spaces (sw)
set tabstop=4                   " an indentation every four columns (ts)
set softtabstop=8               " Column text should be easily aligned with this at 8
set shiftround                  " >> and << will round to the nearest shiftwidth
set smarttab                    " Make shiftwidth affect spaces added when tabs are typed

set linebreak                   " When wrap is on, break at word boundaries

set nospell
set spelllang=en_us
set dictionary=/usr/share/dict/words
set thesaurus=~/dotfiles/mthesaur.txt

" Enable 'vim: tw=80 noet sw=2' in files
set modeline
set cursorline

set printoptions=left:2cm,top:1in,right:2cm,bottom:1in,duplex:off,paper:letter,syntax:y,number:y

" Ignore settings
let g:ack_wildignore=0 " Otherwise error ack.vim line 31
set wildignore=tags,a.out,depmod,*.so,*.a,*.o,*.dep,*.class,*.pyc

set hidden                      " Allow buffers (unsaved) in the background (like tabs)
set virtualedit=block           " Block mode allows cursor to go where spaces don't exist
"set virtualedit+=onemore        " Allow cursor to stay one character past the end of the line
set autoindent                  " indent at the same level of the previous line
set cindent
set smartindent                 " New lines start indented appropriately
set nowrap                      " wrap long lines

" iTerm2 in osx likes unnamed, not unnamedplus
if $TMUX == ''
    set clipboard=unnamed
endif

set textwidth=0                 " Used in autoformatting (tw)
set colorcolumn=+0              " Use textwidth variable

"set comments=sl:/*,mr:*,elx:*/  " auto format comment blocks with gq see help format-comments
set comments=n:\"
set comments=n:>
set comments=n://
set comments=sr:/***,m:*,elx:***/
" set formatoptions+=a " to get format as you type in comments (fo)
" set formatoptions-=a " to disable

" works for normal and insert.  I want insert to work
set backspace=indent,eol,start

set incsearch                   " find as you type search
set hlsearch                    " highlight search terms
set ignorecase                  " case insensitive search
set smartcase                   " case sensitive when upper is present in search

set number
if version > 730
    set relativenumber
endif

set showcmd " Shows partial key sequences

set scrolloff=3      " minimum lines to keep above and below cursor
set scrolljump=5     " lines to scroll when cursor leaves screen


set noshowmatch                   " Use pi_paren plugin instead
set matchtime=5
"let loaded_matchparen = 1       " Disable pi_paren plugin
" see guicursor, cpoptions
"disable/enable with NoMatchParen/DoMatchParen
"highlight MatchParen cterm=lightblue guibg=lightblue
"highlight MatchParen guibg=lightred
set matchpairs=(:),{:},[:]

set wildmenu                    " show list instead of just completing
set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.

set laststatus=2                " 2 - Always show status line

" Broken down into easily includeable segments
set statusline=%<%f\                      " Filename
set statusline+=%w%h%m%r                  " Options
set statusline+=\ [%{&ff}/%Y]             " FileType
set statusline+=\ [%{getcwd()}]           " current dir
set statusline+=%=%-14.(%l,%c%)\ %p%%     " Right aligned file nav info

" Highlight problematic whitespace
set list
set listchars=tab:>\ ,trail:.,extends:#,nbsp:.
if has('multi_byte')
    set listchars=trail:·,precedes:«,extends:»,tab:▸·
    set listchars+=nbsp:·
    "set listchars+=eol:↲
endif

" show the ruler (only if statusline isn't shown - laststatus=0 or 1
set ruler
set rulerformat=%30(%=%y%m%r%w\ %l,%r%V\ %p%)

set nobackup
if $TMUX == ''
    set swapfile   " Swap file lets you know the buffer is open in another window
else
    set noswapfile
endif

set backupdir=~/.vim/backup
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif

set directory=~/.vim/tmp  " Where the swap file will go
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif

"set undofile                " Save undo's after file closes
"set undodir=$HOME/.vim/undo " where to save undo histories
"set undolevels=1000         " How many undos
"set undoreload=10000        " number of lines to save for undo

" Help escape take effect immediately.  Since escape is part of a key code,
" sometimes escape doesn't take immediately if not followed by another
" character.  ttimeoutlen=0 (set to a low value) tells vim to escape now.
"
" If on MAC, may need to
"   mv /etc/vimrc /etc/vimrc.disabled
set timeout timeoutlen=1000 ttimeout ttimeoutlen=0

"Paste helper
set mouse=a

if executable('ag')
    " Make :grep use the silver searcher (ag)
    set grepprg=ag\ --nogroup\ --nocolor\ --column\
    "set grepprg=grep\ -n\
    set grepformat=%f:%l:%c:%m
endif


""""""""""""""""""""""""""""""""" Autocmds:
augroup vimdiff
    autocmd!
    " Run diffupdate everytime Cursor is moved
    autocmd CursorMoved,CursorMovedI * if &diff == 1 | diffupdate | endif
    " in case CursorMoved,CursorMovedI is too CPU intensive
    "autocmd BufWritePost * if &diff == 1 | diffupdate | endif
augroup END

augroup quickfix
    autocmd!
    " Open quickfix window by default after helpgrep or the like
    autocmd QuickFixCmdPost [^l]* nested cwindow
    autocmd QuickFixCmdPost    l* nested lwindow
augroup END


""""""""""""""""""""""""""""""""" Keyboard Mappings: Global Settings
let mapleader = ','
let maplocalleader = ' '


""""""""""""""""""""""""""""""""" Keyboard Mappings: Built-in Modifications
" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$
" viw,p will black-hole delete and paste default register
nnoremap x "_x

if has('osx')
    nmap <silent> K <Plug>DashSearch
endif

" Make any necesary parent directories
command! -nargs=1 E execute('silent! !mkdir -p "$(dirname "<args>")"') <Bar> e <args>

"Saving helpers
nnoremap <C-s> :update<CR>
inoremap <C-s> <esc>:update<CR>

imap <S-Insert> <MiddleMouse>
nnoremap <space>y :Unite history/yank<cr>

nnoremap ]f :next<cr>
nnoremap [f :prev<cr>

nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

nnoremap ]q :cnext<cr>
nnoremap [q :cprev<cr>
nnoremap ]Q :cnewer<cr>
nnoremap [Q :colder<cr>

" Location List :lgrep :lvimgrep
nnoremap ]l :lnext<cr>
nnoremap [l :lprev<cr>

" Tag Stack (Although I normall use the jump list CTRL-O)
nnoremap ]t :tag<cr>
nnoremap [t :pop<cr>

" Jump List
nnoremap ]j <c-I>
nnoremap [j <c-O>

" Change List
"mhinz/vim-signify
nmap ]c <plug>(signify-next-hunk)
nmap [c <plug>(signify-prev-hunk)

" Matching Tag List - Loaded with :tselect or g]
nnoremap ]g :tnext<cr>
nnoremap [g :tprevious<cr>

" CTRL-W_} then cycle through matches in preview window
nnoremap ]p :ptnext<cr>
nnoremap [p :ptprev<cr>

nnoremap ]T :tabnext<cr>
nnoremap [T :tabprevious<cr>

nnoremap ]w :wincmd l<cr>
nnoremap [w :wincmd h<cr>

" Wrapped lines goes down/up to next row, rather than next line in file.
"nnoremap j gj
"nnoremap k gk

"NOTE: tpope/vim-abolish coerce:
" crs to snake_case
" crm to MixedCase
" crc to camelCase
" cru to UPPER_CASE


""""""""""""""""""""""""""""""""" Keyboard Mappings: Visual
" Delete to black hole
vnoremap <leader>d "_d

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv


""""""""""""""""""""""""""""""""" Keyboard Mappings: Settings Modification
nnoremap \2 :setlocal sw=2 ts=2<cr>
nnoremap \3 :setlocal sw=3 ts=3<cr>
nnoremap \4 :setlocal sw=4 ts=4<cr>
nnoremap \8 :setlocal sw=8 ts=8<cr>
nnoremap \t :setlocal expandtab!<cr>
nnoremap \\2 :set sw=2 ts=2<cr>
nnoremap \\3 :set sw=3 ts=3<cr>
nnoremap \\4 :set sw=4 ts=4<cr>
nnoremap \\8 :set sw=8 ts=8<cr>
nnoremap \\t :setlocal expandtab!<cr>
":retab to convert

nnoremap \s :set spell!<cr>        " Toggles Spelling

nnoremap \w :set wrap nolist<cr>   " Go into wrap mode
nnoremap \W :set nowrap list<cr>  " Exit wrap mode

nnoremap \\v :source $MYVIMRC<cr>

" junegunn/rainbow_parentheses.vim
nnoremap \r :RainbowParentheses!!<cr>

" mhinz/vim-signify
nmap \+ :SignifyToggle<cr>

nnoremap <localleader>h :noh<cr>


""""""""""""""""""""""""""""""""" Keyboard Mappings: Directory

" Change Working Directory to that of the current file
nnoremap <c-j>. :lcd %:p:h<cr>
nnoremap <c-j>u :cd ..<cr>


""""""""""""""""""""""""""""""""" Keyboard Mappings: Jumping

"majutsushi/tagbar (outline)
nnoremap <silent> <leader>o :TagbarToggle<CR>

"beloglazov/vim-online-thesaurus
nnoremap <leader>d :OnlineThesaurusCurrentWord<cr>

nnoremap g] :Unite -input=<C-r>=expand('<cword>')<CR> tag<CR>
nnoremap <c-j>t :Unite tag<CR>

nnoremap <c-j>c :Unite quickfix<CR>
nnoremap <c-j>j :Unite jump<CR>

nnoremap g/ :Unite -input=<C-r>=expand('<cword>')<CR> line<CR>
nnoremap <c-j>; :Unite line<CR>

" Edit the snippets for the filetype of the current buffer
" cskeeters/vim-snippets
nnoremap <C-j>es :OpenSnips<cr>

" Edit the maps file for the filetype of the current buffer
nnoremap <C-j>em :execute 'edit '.globpath(&runtimepath, "ftplugin/".&filetype.".vim", v:true, v:true)[0]<cr>


""""""""""""""""""""""""""""""""" Keyboard Mappings: Buffer Management
noremap <C-p>b     :CtrlPBuffer<cr>

"cskeeters/closer.vim
nmap <C-j>d <Plug>OpenCloser

" Shougo/unite.vim
noremap <C-j>b :Unite buffer<CR>

""""""""""""""""""""""""""""""""" Keyboard Mappings: File Search

"kien/ctrlp.vim
noremap <C-p><C-p> :CtrlP .<cr>
noremap <C-p>p     :CtrlP .<cr>

" Shougo/unite.vim
" Bookmarks
noremap <leader><leader>b :UniteBookmarkAdd<cr>

noremap _ :Unite file<CR>
noremap <C-j>v :Unite file:~/.vim/bundle<CR>
if !has('nvim')
    noremap <C-j><C-j> :Unite file_rec/async<CR>
    noremap <C-j>f :Unite file_rec/async<CR>
else
    noremap <C-j><C-j> :Denite file_rec<CR>
    noremap <C-j>f :Denite file_rec<CR>
endif
noremap <C-j>k :Unite bookmark<CR>
noremap <C-j>g :Unite grep:.<CR>


let g:unite_source_menu_menus = get(g:,'unite_source_menu_menus',{})
let g:unite_source_menu_menus.projects = {'description' : 'Change Directory to favorties'}
let g:unite_source_menu_menus.projects.candidates = {
            \ 'notes':'~/Dropbox/notes',
            \ 'bcst-doc':'~/working/bcst-doc',
            \ 'bcst':'~/Documents/nci/bcst',
            \ 'dotfiles':'~/dotfiles',
            \ 'bundle':'~/.vim/bundle',
            \ 'rcmp':'~/Documents/nci/2014/mts/rcmp'
            \ }

function! g:unite_source_menu_menus.projects.map(key, value)
    return {
    \   'word': a:key,
    \   'kind': 'command',
    \   'action__command': 'cd '.a:value.' | Dirvish'
    \ }
endfunction
noremap <silent><C-j>p :Unite -silent menu:projects<CR>


""""""""""""""""""""""""""""""""" Keyboard Mappings: Text Search
"mileszs/ack.vim
" This is better than :silent grep because
" * it respects .hgignore/.gitignore
" * grep requires <C-L> in iterm to redraw the screen
noremap <leader>/ :Ack <cword><cr>
noremap <leader>i/ :AckWindow <cword><cr>


""""""""""""""""""""""""""""""""" Keyboard Mappings: File

noremap <Leader>s :update<CR>
" Use sudo and tee to write the file as root
nmap <leader><leader>w :w !sudo tee % >/dev/null<cr>


"cskeeters/vim-leave-window
nnoremap <leader>gw :LWClose!<cr>
nnoremap <leader>w :LWClose<cr>

noremap <leader>q :q<CR>

" cskeeters/vim-simple-alt
nmap <leader>l :Alt<cr>


""""""""""""""""""""""""""""""""" Keyboard Mappings: Text Manipulation

" Choose first spelling suggestion
nnoremap <localleader>. z=1<cr><cr>

" Remove trailing whitespace in current buffer
nnoremap <localleader><localleader>w :%s/\s\+$//<cr>

" scrooloose/nerdcommenter
map <localleader>c <plug>NERDCommenterComment
let g:NERDCreateDefaultMappings=0

" mbbill/undotree
nnoremap <localleader><localleader>u :UndotreeToggle<CR>

" junegunn/vim-easy-align
vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)

let g:unite_source_menu_menus = get(g:,'unite_source_menu_menus',{})

let g:unite_source_menu_menus.tabularize = {'description' : 'Tabularize'}
let g:unite_source_menu_menus.tabularize.candidates = { '|':'|', '=':'=', ':':':', ',':',' }

function! g:unite_source_menu_menus.tabularize.map(key, value)
    return {
    \   'word': a:key,
    \   'kind': 'command',
    \   'action__command': 'Tabularize /'.a:value
    \ }
endfunction
vnoremap <silent><space><space>t :Unite -silent menu:tabularize<CR>


""""""""""""""""""""""""""""""""" Keyboard Mappings: Remove


"Buffer Helpers
"nmap <C-j> :bn<CR>
"nmap <C-k> :bp<CR>

" Reformat selected text
"vnoremap <localleader>f Jgqj

" Shortcuts
"cnoremap Gb ~/Documents/nci/bcst/
"cnoremap Gn ~/Dropbox/notes/
"cnoremap Gv ~/.vim/bundle


""""""""""""""""""""""""""""""""" Keyboard Mappings: Abbr

iab <expr> dts strftime("%FT%T%z")
iab <expr> ds strftime("%Y-%b-%d")


""""""""""""""""""""""""""""""""" Builtin: Configuration

"Disable netrw
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

let g:netrw_liststyle=1
"let g:netrw_keepdir=0

" Enables % to work on html tags etc
" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif



""""""""""""""""""""""""""""""""" Plugins:
" Update Plugins with:
" sed -ne 's/^" *PLUGIN: \([^ \"]*\)/\1/p' ~/.vimrc | sed -e 's:.*/\(.*\):\1:' | xargs -I {} bash -c "cd ~/.vim/bundle/{}; git pull"
"
" Checkout repositories with:
" ( cd ~/.vim/bundle; sed -ne 's/^" *PLUGIN: \([^ \"]*\)/\1/p' ~/.vimrc | xargs -I {} git clone {} )
"
" Generate helptags with:
" sed -ne 's#^" *PLUGIN: [^ "]*/\([^ "]*\)#helptags ~/.vim/bundle/\1/doc#p' ~/.vimrc | vim -e -s -
"
" Download archives of plugins with:
" cd ~/.vim/bundle
" sed -nre 's/^" ?PLUGIN: ([^ \"]*)/\1/p' ~/.vimrc | xargs -I {} bash -c "wget -q {}/archive/master.zip; unzip master.zip; rm -f master.zip"
" ls -1 | sed -re 's/(.*)-master/mv \1-master \1/' | bash

""""""""""""""""""""""""""""""""" Plugins: Built-in Extension

call plug#begin()
Plug 'tpope/vim-sensible'

Plug 'https://github.com/vim-scripts/argtextobj.vim'
" cia (change, in, argument)
Plug 'https://github.com/michaeljsmith/vim-indent-object'
" cii (change, in, indent)

Plug 'https://github.com/vim-scripts/visualrepeat'
Plug 'https://github.com/cskeeters/vim-smooth-scroll'
"let g:scroll_follow = 1
Plug 'https://github.com/tpope/vim-repeat'

if !has('nvim')
    "Speeds up Unite with asynchronous commands
    Plug 'https://github.com/Shougo/vimproc.vim', { 'do': 'make' }
endif


"Plug '~/working/base16-builder-php/templates/vim'
Plug 'https://github.com/chriskempson/base16-vim',
    \ { 'do': 'git clone https://github.com/chriskempson/base16-shell.git ~/.vim/base16-shell' }
if $TERM != "konsole"
    " As a work around for the following bugs in kde4's konsole:
    " https://github.com/chriskempson/base16-shell/issues/31
    let g:base16_shell_path = $HOME."/.vim/base16-shell/scripts"
    let base16colorspace=256
endif
set background=dark

Plug 'https://github.com/bling/vim-airline'
" Disable tabline since there's a bug that messes up the order on mac #1228
let g:airline#extensions#tabline#enabled = 0
"iTerm2 has to have the asci and non-asci (two separate font settings) set to a powerline font
let g:airline_powerline_fonts = 1

Plug 'https://github.com/vim-airline/vim-airline-themes'

Plug 'https://github.com/junegunn/rainbow_parentheses.vim'
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]


""""""""""""""""""""""""""""""""" Plugins: Ease of use

Plug 'https://github.com/moll/vim-bbye'
Plug 'https://github.com/cskeeters/vim-leave-window'
Plug 'https://github.com/cskeeters/closer.vim'
Plug 'https://github.com/cskeeters/vim-simple-alt'
Plug 'https://github.com/cskeeters/vim-map-enter'
Plug 'https://github.com/mbbill/undotree'
Plug 'https://github.com/tpope/vim-abolish'
Plug 'https://github.com/scrooloose/nerdcommenter'

Plug 'https://github.com/majutsushi/tagbar'
" Add support for markdown files in tagbar.
" https://github.com/majutsushi/tagbar/wiki#markdown
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '~/bin/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1


"Plug 'https://github.com/Lokaltog/vim-easymotion'
"Plug 'https://github.com/tpope/vim-vinegar'

Plug 'https://github.com/justinmk/vim-dirvish'

Plug 'https://github.com/mileszs/ack.vim'
if executable('ag')
    let g:ackprg = 'ag --nogroup --nocolor --column'
endif

Plug 'https://github.com/junegunn/vim-easy-align'

"junegunn/vim-easy-align doesn't work for tables
Plug 'https://github.com/godlygeek/tabular'


""""""""""""""""""""""""""""""""" Plugins: File Searcher

Plug 'https://github.com/Shougo/neomru.vim'
Plug 'https://github.com/Shougo/neoyank.vim'
Plug 'https://github.com/tsukkee/unite-tag'
Plug 'https://github.com/osyo-manga/unite-quickfix'
Plug 'https://github.com/Shougo/unite-outline'
Plug 'https://github.com/Shougo/unite-help'

let g:unite_source_history_yank_enable = 1
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '-i --vimgrep --hidden --ignore ''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
let g:unite_source_rec_async_command = ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', '']
let g:unite_enable_auto_select = 0

if has('nvim')
    " Requires python3.  Run
    "   pip3 install neovim
    Plug 'https://github.com/Shougo/denite.nvim'
endif
Plug 'https://github.com/Shougo/unite.vim'

Plug 'https://github.com/kien/ctrlp.vim'
"let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_max_files = 4000
if executable('ag')
    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif

""""""""""""""""""""""""""""""""" Plugins: Tab Completion

Plug 'https://github.com/ervandew/supertab'
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabClosePreviewOnPopupClose = 0

"Plug 'https://github.com/Valloric/YouCompleteMe'
"Disable signs so that signify can work
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_extra_conf_globlist = ['~/rcmp/*','!~/*']
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'


""""""""""""""""""""""""""""""""" Plugins: snippets

Plug 'https://github.com/SirVer/ultisnips'
let g:UltiSnipsSnippetsDir = "~/.vim/bundle/vim-snippets/UltiSnips"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"let g:UltiSnipsExpandTrigger="<c-b>"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

"Plug 'https://github.com/tomtom/tlib_vim'
"Plug 'https://github.com/MarcWeber/vim-addon-mw-utils'
"Plug 'https://github.com/garbas/vim-snipmate'

" Personal snippets
"URL: https://github.com/cskeeters/vim-snippets
Plug '~/.vim/bundle/vim-snippets'


""""""""""""""""""""""""""""""""" Plugins: DRCS git/hg

" Show diff in gutter
Plug 'https://github.com/mhinz/vim-signify'
let g:signify_vcs_list = ['hg']
let g:signify_disable_by_default = 1

Plug 'https://github.com/tpope/vim-fugitive'
":Gblame :Gdiff

Plug 'https://github.com/jlfwong/vim-mercenary'
":HGblame :HGdiff


""""""""""""""""""""""""""""""""" Plugins: Lookup/Help
if has('osx')
    Plug 'https://github.com/rizzatti/dash.vim'
endif

Plug 'https://github.com/beloglazov/vim-online-thesaurus'
let g:online_thesaurus_map_keys = 0

"
""""""""""""""""""""""""""""""""" Plugins: File-type specific

"keyboard mappings and settings per file type
"URL: https://github.com/cskeeters/vim-maps
Plug '~/.vim/bundle/vim-maps'

Plug 'https://github.com/sheerun/vim-polyglot'

Plug 'https://github.com/cskeeters/sr.vim'

" reStructuredText highlighting
"Plug 'https://github.com/vim-scripts/rest.vim'
"setf rest

""""""""""""""""""""""""""""""""" Plugins: Markdown
Plug 'https://github.com/plasticboy/vim-markdown'
" Disable ]c to move to header since it disrupts ]c - next difference
map <Plug> <Plug>Markdown_MoveToCurHeader
let g:vim_markdown_folding_disabled = 1

"URL: https://github.com/cskeeters/vim-markdown-maps
Plug '~/.vim/bundle/vim-markdown-maps'

"TODO: Not available on github.
Plug '~/.vim/bundle/vim-md-doc'
let g:md_doc = [
            \ ["/Users/chad/working/bcst-doc", "bcst-doc"],
            \ ["/Users/chad/Dropbox/notes", "notes"] ]
let g:md_doc_auto_commit = 1

Plug 'https://github.com/itspriddle/vim-marked'
" Use Marked (version 1)
let g:marked_app = "Marked"

""""""""""""""""""""""""""""""""" Plugins: HTML
Plug 'https://github.com/alvan/vim-closetag'


""""""""""""""""""""""""""""""""" Plugins: Java
Plug 'https://github.com/cskeeters/javadoc.vim', { 'for': 'java' }
let g:javadoc_path="/Users/chad/java8_doc/api"


Plug 'https://github.com/cskeeters/jcall.vim', { 'for': 'java' }
let g:jcall_debug = 0
let g:jcall_src_build_pairs = [
            \ ['/Users/chad/jcall_test/src', '/Users/chad/jcall_test/build'],
            \ ]

""""""""""""""""""""""""""""""""" Plugins: c++

Plug 'https://github.com/myint/clang-complete', { 'for': 'cpp' }
let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib'


" IF syntastic is used
"let g:syntastic_cpp_compiler_options = ' -std=c++11 -D_GLIBCXX_USE_NANOSLEEP'
"let g:syntastic_cpp_compiler_options .= ' `pkg-config --cflags --libs cairo'
"let g:syntastic_cpp_compiler_options .= ' `pkg-config --cflags --libs cairomm-1.0'

"let g:syntastic_cpp_compiler = 'clang++'
"let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'


""""""""""""""""""""""""""""""""" Plugins: experimental

" FZF requires a terminal emulator.  For this to work in MacVim, XQuartz must
" be installed so xterm can be run

" Must install fzf via brew.  This defines :FZF
"set runtimepath+=/usr/local/opt/fzf

"Plug 'https://github.com/junegunn/fzf.vim', { 'dir': '~/.fzf', 'do': './install --all' }
"set runtimepath+=$HOME/.vim/bundle/fzf.vim


"This causes problems trying to remap keys when developing plugins
"If airline/powerline is removed, run the following command to remove startup
"errors:
"    rm -f ~/.vim/view/*
"PLUGIN: https://github.com/vim-scripts/restore_view.vim
"Uses mkview to save cursor position and folds
"set runtimepath+=$HOME/.vim/bundle/restore_view.vim


call plug#end()

function! AirlineInit()
    " Let me see the cwd
    let g:airline_section_b = airline#section#create(['%{fnamemodify(getcwd(), ":t")}', g:airline_symbols.space, 'hunks', 'branch'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()

if has('nvim')
    call denite#custom#source('file_rec', 'matchers', ['matcher_ignore_globs'])
endif
call unite#custom#profile('default', 'context', { 'start_insert':1, 'prompt':'>', 'no_split':1, 'wipe':1 })
call unite#filters#matcher_default#use(['matcher_glob'])

colorscheme base16-default-dark

"syntax sync minlines=500
syntax sync fromstart
