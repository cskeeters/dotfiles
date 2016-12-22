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
set softtabstop=4               " let backspace delete indent (sts)
set shiftround                  " >> and << will round to the nearest shiftwidth

set linebreak                   " When wrap is one, break at word boundaries

set nospell
set spelllang=en_us
set dictionary=/usr/share/dict/words
set thesaurus=~/dotfiles/mthesaur.txt

" Enable 'vim: tw=80 noet sw=2' in files
set modeline

" Print settings
set printoptions=left:2cm,top:1in,right:2cm,bottom:1in,syntax:n,duplex:off,paper:letter

" Ignore settings
let g:ack_wildignore=0 " Otherwise error ack.vim line 31
let g:ackprg = 'ag'
set wildignore=tags,a.out,depmod,*.so,*.a,*.o,*.dep,*.class,*.pyc

set hidden                      " Allow buffers (unsaved) in the background (like tabs)
set virtualedit=block           " Block mode allows cursor to go where spaces don't exist
"set virtualedit+=onemore        " Allow cursor to stay one character past the end of the line
set autoindent                  " indent at the same level of the previous line
set cindent
set smartindent
set nowrap                      " wrap long lines

" iTerm2 in osx likes unnamed, not unnamedplus
" NOTE: FormatMatch osx application prevents visual block selections from being
" yanked and pasted
set clipboard=unnamed

set textwidth=0                 " Used in autoformatting (tw)
set colorcolumn=+0              " Use textwidth variable

"set comments=sl:/*,mr:*,elx:*/  " auto format comment blocks with gq see help format-comments
set comments=n:\"
set comments=n:>
set comments=n://
set comments=sr:/***,m:*,elx:***/
" set formatoptions+=a " to get format as you type in comments (fo)
" set formatoptions-=a " to disable

"set formatprg=par\ -jw60 " gqG
":.!par -jw80


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
set printoptions=left:3pc,right:3pc,number:n,header:0

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

set laststatus=2


" Broken down into easily includeable segments
set statusline=%<%f\    " Filename
set statusline+=%w%h%m%r " Options
set statusline+=\ [%{&ff}/%Y]            " filetype
set statusline+=\ [%{getcwd()}]          " current dir
set statusline+=%=%-14.(%l,%c%)\ %p%%  " Right aligned file nav info

" Highlight problematic whitespace
set list
set listchars=tab:,.,trail:.,extends:#,nbsp:.
if has('multi_byte')
    set listchars=trail:·,precedes:«,extends:»,tab:▸·
    set listchars+=nbsp:·
    "set listchars+=eol:↲
endif

" show the ruler (only if statusline isn't shown - laststatus=0 or 1
set ruler
set rulerformat=%30(%=%y%m%r%w\ %l,%r%V\ %p%)

set nobackup

set backupdir=~/.vim/backup
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif

set directory=~/.vim/tmp
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif

"set noswapfile
"
"set undofile                " Save undo's after file closes
"set undodir=$HOME/.vim/undo " where to save undo histories
"set undolevels=1000         " How many undos
"set undoreload=10000        " number of lines to save for undo

" Help escape take effect immediately
" If on MAC, may need to
" mv /etc/vimrc /etc/vimrc.disabled
set timeoutlen=1000 ttimeoutlen=0

""""""""""""""""""""""""""""""""""""""""""""""""" Keyboard Shortcuts
let mapleader = ','
let maplocalleader = '\'

" Bookmarks
"nnoremap <leader>en :e ~/Dropbox/notes/README.md<cr>:lcd %:p:h<cr>:CtrlP<CR><F5>
nnoremap <leader>en :CtrlP ~/Dropbox/notes<CR>
nnoremap <leader>eb :CtrlP ~/Documents/nci/bcst<CR>
nnoremap <leader>er :CtrlP ~/Documents/nci/2014/mts/rcmp<CR>
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap gsv :source $MYVIMRC<cr>


" Wrapped lines goes down/up to next row, rather than next line in file.
"nnoremap j gj
"nnoremap k gk

nnoremap <LocalLeader>2 :setlocal sw=2 ts=2 sts=2 expandtab<cr>
nnoremap <LocalLeader>3 :setlocal sw=3 ts=3 sts=3 expandtab<cr>
nnoremap <LocalLeader>4 :setlocal sw=4 ts=4 sts=4 expandtab<cr>
nnoremap <LocalLeader>8 :setlocal sw=8 ts=8 sts=8 expandtab<cr>
nnoremap <LocalLeader>t :setlocal noexpandtab!<cr>
nnoremap <leader>2 :set sw=2 ts=2 sts=2<cr>
nnoremap <leader>3 :set sw=3 ts=3 sts=3<cr>
nnoremap <leader>4 :set sw=4 ts=4 sts=4<cr>
nnoremap <leader>8 :set sw=8 ts=8 sts=8<cr>
nnoremap <leader>t :setlocal noexpandtab<cr>
":retab to convert

nnoremap <leader>p :set spell!<cr>        " Toggles Spelling
nnoremap <leader>W :set wrap nolist<cr>   " Go into wrap mode
nnoremap <leader>nW :set nowrap list<cr>  " Exit wrap mode

"Saving helpers
nnoremap <C-s> :update<CR>
inoremap <C-s> <esc>:update<CR>
"noremap <Leader>s :update<CR>
noremap <Leader>q :q<CR>

"Buffer Helpers
nmap <C-j> :bn<CR>
nmap <C-k> :bp<CR>

nnoremap <leader>h :noh<cr>
"nnoremap <C-l> :noh<cr>

set pastetoggle=<F10>           " pastetoggle (sane indentation on pastes)

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Reformat selected text
vnoremap <localleader>f Jgqj

" Remove trailing whitespace in current buffer
nnoremap <localleader>w :%s/\s\+$//<cr>
" Remove trailing whitespaces and ^M chars
" autocmd FileType c,cpp,java,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

" Shortcuts
cnoremap Gb ~/Documents/nci/bcst/
cnoremap Gn ~/Dropbox/notes/
cnoremap Gv ~/.vim/bundle
" Change Working Directory to that of the current file
noremap gcd :lcd %:p:h<cr>
nnoremap <localleader>u :cd ..<cr>
nnoremap <localleader>u :cd ..<cr>

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

"Remove in 2017 if no issue
"vno v <esc>

nnoremap <leader>. z=1<cr><cr>

"Paste helper
imap <S-Insert> <MiddleMouse>
set mouse=a
" viw,p will black-hole delete and paste default register
nnoremap x "_x
vnoremap <leader>d "_d

iab @@ goobsoft@gmail.com
iab ccopy Copyright 2017 Chad Skeeters, all rights reserved.

iab <expr> dts strftime("%FT%T%z")
iab <expr> ds strftime("%Y-%b-%d")

noremap <leader>k :make -j4 \| cwindow<CR>

" need to 'set clipboard=' when copy and pasting control characters
" convert signature to method in cpp
" Class name needs to be saved in c register
let @m = "^d0W\"cPa::f;xi{}j"
let @s = "^Wf:dwdF i A;0j"

" vimdiff stuff
autocmd CursorMoved,CursorMovedI * if &diff == 1 | diffupdate | endif
"autocmd BufWritePost * if &diff == 1 | diffupdate | endif
"nnoremap <leader>dg :diffget 2<cr>

" TODO: Turn into normal map
" Use sudo and tee to write the file
cmap w!! w !sudo tee % >/dev/null

" TODO: only for ft=vim, otherwise use DashSearch
nnoremap <localleader>h :help <c-r>=expand('<cWORD>')<cr><cr>

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
nnoremap ]c g,
nnoremap [c g;

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

" Open quickfix window by default after helpgrep or the like
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" Plugins
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


let g:netrw_liststyle=1
"let g:netrw_keepdir=0

function! Alt(filename)
    if stridx(a:filename, '.h') == -1
        execute 'edit '.fnamemodify(a:filename, ':r').'.h'
    else
        let cppexts = ['.cpp', '.c++', '.cc', '.c']
        for cppext in cppexts
            let cpp = fnamemodify(a:filename, ':r').cppext
            if len(glob(cpp)) > 0
                execute 'edit '.cpp
            endif
        endfor
    endif
endfunction
nmap <leader>l :call Alt(expand('%:p'))<cr>

function! HandleURL()
  let uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;]*')
  echo uri
  if uri != ""
    exec "!open ".shellescape(uri, 1)
  else
    echo "No URI found in line."
  endif
endfunction
" No longer needed with vim 8.0
"map gx :call HandleURL()<cr>

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

"PLUGIN: https://github.com/cskeeters/vim-smooth-scroll
set runtimepath+=$HOME/.vim/bundle/vim-smooth-scroll
"let g:scroll_follow = 1

"PLUGIN: https://github.com/cskeeters/vim-map-enter
set runtimepath+=$HOME/.vim/bundle/vim-map-enter

"PLUGIN: https://github.com/moll/vim-bbye
set runtimepath+=$HOME/.vim/bundle/vim-bbye

"PLUGIN: https://github.com/cskeeters/vim-leave-window
set runtimepath+=$HOME/.vim/bundle/vim-leave-window
nnoremap <leader>mw :LWForceClose<cr>
nnoremap <leader>w :LWClose<cr>

" FZF requires a terminal emulator.  For this to work in MacVim, XQuartz must
" be installed so xterm can be run

" Must install fzf via brew.  This defines :FZF
"set runtimepath+=/usr/local/opt/fzf

"PLUGIN: https://github.com/junegunn/fzf.vim
"set runtimepath+=$HOME/.vim/bundle/fzf.vim

"PLUGIN: https://github.com/Shougo/neocomplete.vim
"set runtimepath+=$HOME/.vim/bundle/neocomplete.vim
"let g:acp_enableAtStartup = 0
"let g:neocomplete#enable_at_startup = 1
"let g:neocomplete#enable_smart_case = 1
"let g:neocomplete#sources#syntax#min_keyword_length = 4
"inoremap <expr> <C-g> neocomplete#undo_completion()
"inoremap <expr> <C-l> neocomplete#complete_common_string()
"inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
"inoremap <expr> <C-h> neocomplete#smart_close_popup()."\<C-h>"
"inoremap <expr> <BS>  neocomplete#smart_close_popup()."\<C-h>"

"PLUGIN: https://github.com/ervandew/supertab
"FIXME: set runtimepath+=$HOME/.vim/bundle/supertab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabClosePreviewOnPopupClose = 0

"inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<C-R>=UltiSnips#ExpandSnippet()<cr>"

"PLUGIN: https://github.com/cskeeters/closer.vim
set runtimepath+=$HOME/.vim/bundle/closer.vim
nmap <silent> <localleader>c <Plug>OpenCloser

"PLUGIN: https://github.com/plasticboy/vim-markdown
"Disable ]c to move to header since it disrupts ]c - next difference
map <Plug> <Plug>Markdown_MoveToCurHeader
set runtimepath+=$HOME/.vim/bundle/vim-markdown

"PLUGIN: https://github.com/alvan/vim-closetag
set runtimepath+=$HOME/.vim/bundle/vim-closetag

"PLUGIN: https://github.com/vim-scripts/argtextobj.vim
set runtimepath+=$HOME/.vim/bundle/argtextobj.vim
" via (visual, in, argument)
" cia (change, in, argument)
" dia (delete, in, argument)

"PLUGIN: https://github.com/michaeljsmith/vim-indent-object
set runtimepath+=$HOME/.vim/bundle/vim-indent-object
" vii (visual, in, indent)
" cii (change, in, indent)
" dii (delete, in, indent)

"PLUGIN: https://github.com/rizzatti/dash.vim
set runtimepath+=$HOME/.vim/bundle/dash.vim
nmap <silent> <localleader>d <Plug>DashSearch

"PLUGIN: https://github.com/cskeeters/javadoc.vim
let g:javadoc_path="/Users/chad/java7_doc/api"
set runtimepath+=$HOME/.vim/bundle/javadoc.vim

"PLUGIN: https://github.com/cskeeters/jcall.vim
let g:jcall_debug = 0
let g:jcall_src_build_pairs = [
            \ ['/Users/chad/jcall_test/src', '/Users/chad/jcall_test/build'],
            \ ]
set runtimepath+=$HOME/.vim/bundle/jcall.vim
nmap <leader>ch <Plug>JCallOpen
nmap <f3> <Plug>JCallJump
nmap <leader>cch <Plug>JCallClear

"PLUGIN: https://github.com/cskeeters/sr.vim
set runtimepath+=$HOME/.vim/bundle/sr.vim

"This causes problems trying to remap keys when developing plugins
"If airline/powerline is removed, run the following command to remove startup
"errors:
"    rm -f ~/.vim/view/*
"PLUGIN: https://github.com/vim-scripts/restore_view.vim
"Uses mkview to save cursor position and folds
"set runtimepath+=$HOME/.vim/bundle/restore_view.vim

"PLUGIN: https://github.com/vim-scripts/visualrepeat
set runtimepath+=$HOME/.vim/bundle/visualrepeat

"PLUGIN: https://github.com/junegunn/vim-easy-align
set runtimepath+=$HOME/.vim/bundle/vim-easy-align
vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)

"PLUGIN: https://github.com/tpope/vim-repeat
set runtimepath+=$HOME/.vim/bundle/vim-repeat

"PLUGIN: https://github.com/beloglazov/vim-online-thesaurus
" <localleader>K to activate
set runtimepath+=$HOME/.vim/bundle/vim-online-thesaurus

"PLUGIN: https://github.com/mileszs/ack.vim
if executable('ag')
    let g:ackprg = 'ag --nogroup --nocolor --column'
    " This sets up :grep to use ag too
    set grepprg=ag\ --nogroup\ --nocolor\ --column\
    set grepformat=%f:%l:%c:%m
    "set grepprg=grep\ -n\
    set runtimepath+=$HOME/.vim/bundle/ack.vim
elseif executable('ack')
    "set grepprg="ack --nogroup --nocolor "
    set runtimepath+=$HOME/.vim/bundle/ack.vim
endif
" This is better than :silent grep because
" * it respects .hgignore/.gitignore
" * grep requires <C-L> in iterm to redraw the screen
noremap <leader>/ :Ack <cword><cr>
noremap <leader>i/ :AckWindow <cword><cr>

"PLUGIN: https://github.com/kien/ctrlp.vim
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
set runtimepath+=$HOME/.vim/bundle/ctrlp.vim
nnoremap <leader>b :CtrlPBuffer<cr>

"PLUGIN: https://github.com/chriskempson/base16-vim
set runtimepath+=$HOME/.vim/bundle/base16-vim
" In order to use base16 in the terminal without blue or green lines
" You must checkout base16-shell and set g:base16_shell_path
let g:base16_shell = $HOME."/base16-shell"
" This shouldn't change, comment out when terminal is loaded with 16 colors
let g:base16_shell_path = g:base16_shell."/scripts"
let base16colorspace=256
set background=dark
colorscheme base16-default-dark

"LUGIN: https://github.com/vim-scripts/rest.vim
"set runtimepath+=$HOME/.vim/bundle/rest.vim " reStructuredText highlighting
"PLUGIN: https://github.com/tpope/vim-abolish
set runtimepath+=$HOME/.vim/bundle/vim-abolish " snake_case MixedCase camelCase UPPER_CASE

"PLUGIN: https://github.com/mbbill/undotree
nnoremap <Leader>u :UndotreeToggle<CR>
set runtimepath+=$HOME/.vim/bundle/undotree

"PLUGIN: https://github.com/Lokaltog/vim-easymotion
set runtimepath+=$HOME/.vim/bundle/vim-easymotion

"PLUGIN: https://github.com/bling/vim-airline
" Disable tabline since there's a bug that messes up the order on mac #1228
let g:airline#extensions#tabline#enabled = 0
"iTerm2 has to have the asci and non-asci (two separate font settings) set to a powerline font
let g:airline_powerline_fonts = 1
set runtimepath+=$HOME/.vim/bundle/vim-airline

"PLUGIN: https://github.com/vim-airline/vim-airline-themes
set runtimepath+=$HOME/.vim/bundle/vim-airline-themes

"PLUGIN: https://github.com/tpope/vim-surround
" change 'hi' to (hi) with cs')
" change hi chad to (hi chad) with ys2w)

" Disable mappings in insert mode (CTRL+S)
let g:surround_no_insert_mappings = 1
set runtimepath+=$HOME/.vim/bundle/vim-surround


"PLUGIN: https://github.com/mhinz/vim-signify
" Show diff in gutter
",gj ,gk to move between changes
let g:signify_vcs_list = ['hg']
"let g:signify_diffoptions = {'hg': '--color never --pager never' }
"let g:signify_difftool = 'diff'
let g:signify_disable_by_default = 1
"set runtimepath+=$HOME/.vim/bundle/vim-signify
nmap <leader>+ :SignifyToggle<cr>


"PLUGIN: https://github.com/tpope/vim-vinegar
set runtimepath+=$HOME/.vim/bundle/vim-vinegar

if has('nvim')
    "PLUGIN: https://github.com/Shougo/denite.nvim
    " Requires python3.  Run
    "   pip3 install neovim
    let g:unite_source_history_yank_enable = 1
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '-i --vimgrep --hidden --ignore ''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
    let g:unite_source_rec_async_command = ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', '']
    set runtimepath+=$HOME/.vim/bundle/denite.nvim

    nnoremap <leader>f :Denite -prompt=> file_rec<CR>
    nnoremap <leader>b :Denite -prompt=> buffer bookmark<CR>
    nnoremap <leader>g :Denite -prompt=> grep:.<CR>
    nnoremap <localleader>q :Denite -prompt=> quickfix<CR>
    "nnoremap <silent> <leader>b :<C-u>Denite buffer bookmark<CR>
    nnoremap <space>y :Denite history/yank<cr>
else
    "PLUGIN: https://github.com/Shougo/vimproc.vim
    "cd ~/.vim/bundle/vimproc.vim
    "make
    "Speeds up unite if /async:! is used
    set runtimepath+=$HOME/.vim/bundle/vimproc.vim
    "PLUGIN: https://github.com/Shougo/unite.vim
    let g:unite_source_history_yank_enable = 1
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '-i --vimgrep --hidden --ignore ''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
    let g:unite_enable_auto_select = 0

    set runtimepath+=$HOME/.vim/bundle/unite.vim
    "PLUGIN: https://github.com/Shougo/neomru.vim
    set runtimepath+=$HOME/.vim/bundle/neomru.vim
    "PLUGIN: https://github.com/Shougo/neoyank.vim
    set runtimepath+=$HOME/.vim/bundle/neoyank.vim
    "PLUGIN: https://github.com/tsukkee/unite-tag
    set runtimepath+=$HOME/.vim/bundle/unite-tag
    "PLUGIN: https://github.com/osyo-manga/unite-quickfix
    set runtimepath+=$HOME/.vim/bundle/unite-quickfix
    "PLUGIN: https://github.com/Shougo/unite-outline
    set runtimepath+=$HOME/.vim/bundle/unite-outline
    "PLUGIN: https://github.com/Shougo/unite-help
    set runtimepath+=$HOME/.vim/bundle/unite-help

    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    "-prompt=>
    "-start-insert
    "-direction=below
    "-no-split
    nnoremap <leader>f :Unite -start-insert -prompt=> -no-split file file_rec/async<CR>
    nnoremap <localleader>t :Unite -start-insert -prompt=> -no-split tag<CR>
    nnoremap g<c-]> :Unite -no-split -input=<C-r>=expand('<cword>')<CR> tag<CR>
    nnoremap <leader>b :Unite -start-insert -prompt=> -no-split buffer bookmark<CR>
    nnoremap <leader>g :Unite -start-insert -prompt=> -no-split grep:.<CR>
    nnoremap <localleader>q :Unite -start-insert -prompt=> -no-split quickfix<CR>
    "FIXME: Add :Unite line
    "FIXME: Add :Unite jump
    "FIXME: Add :Unite Tabularize
    "FIXME: Add :Unite cd ; :Unite menu
    nnoremap <space>y :Unite history/yank<cr>
    nnoremap <leader><leader>b :UniteBookmarkAdd<cr>

    autocmd FileType unite call s:unite_my_settings()
    function! s:unite_my_settings()
        "let b:SuperTabDisabled=1
        imap <buffer> jj      <Plug>(unite_insert_leave)
        imap <buffer> <C-w>   <Plug>(unite_delete_backward_path)
        imap <buffer><expr> j unite#smart_map('j', '')
        imap <buffer> <TAB> <Plug>(unite_select_next_line)
        imap <buffer> <C-j> <Plug>(unite_select_next_line)
        imap <buffer> <C-k> <Plug>(unite_select_previous_line)

        " Normal mode mappings
        nmap <buffer> <ESC> <Plug>(unite_exit)
        imap <buffer> <TAB> <Plug>(unite_select_next_line)
    endfunction
endif

"PLUGIN: https://github.com/godlygeek/tabular
vmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a:: :Tabularize /:\zs<CR>
vmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
set runtimepath+=$HOME/.vim/bundle/tabular


"PLUGIN: https://github.com/scrooloose/nerdcommenter
"<leader>c<space>
set runtimepath+=$HOME/.vim/bundle/nerdcommenter

"PLUGIN: https://github.com/majutsushi/tagbar
nnoremap <silent> <leader>tt :TagbarToggle<CR>
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
set runtimepath+=$HOME/.vim/bundle/tagbar

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

"PLUGIN: https://github.com/junegunn/rainbow_parentheses.vim
nnoremap <leader>r :RainbowParentheses!!<cr>
set runtimepath+=$HOME/.vim/bundle/rainbow_parentheses.vim
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]


"PLUGIN: https://github.com/SirVer/ultisnips
let g:UltiSnipsSnippetsDir = "~/.vim/bundle/vim-snippets/UltiSnips"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"let g:UltiSnipsExpandTrigger="<c-b>"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
set runtimepath+=$HOME/.vim/bundle/ultisnips

"PLUGIN: https://github.com/tomtom/tlib_vim
"set runtimepath+=$HOME/.vim/bundle/tlib_vim
"PLUGIN: https://github.com/MarcWeber/vim-addon-mw-utils
"set runtimepath+=$HOME/.vim/bundle/vim-addon-mw-utils
"PLUGIN: https://github.com/garbas/vim-snipmate
"set runtimepath+=$HOME/.vim/bundle/vim-snipmate

" My personal snippets
"PLUGIN: https://github.com/cskeeters/vim-snippets
set runtimepath+=$HOME/.vim/bundle/vim-snippets
nnoremap <leader>es :OpenSnips<cr>


"PLUGIN: https://github.com/Valloric/YouCompleteMe
"Disable signs so that signify can work
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_extra_conf_globlist = ['~/rcmp/*','!~/*']
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
"set runtimepath+=$HOME/.vim/bundle/YouCompleteMe

"PLUGIN: https://github.com/itspriddle/vim-marked
" Use Marked (version 1)
let g:marked_app = "Marked"
set runtimepath+=$HOME/.vim/bundle/vim-marked
"Open in Marked with <leader>v

let g:md_doc = [["/Users/chad/working/bcst-doc", "bcst-doc"],["/Users/chad/Dropbox/notes", "notes"]]
let g:md_doc_auto_commit = 1
nnoremap <leader>ep :CtrlP ~/working/bcst-doc<CR>
set runtimepath+=$HOME/.vim/bundle/vim-md-doc

"PLUGIN: https://github.com/tpope/vim-fugitive
set runtimepath+=$HOME/.vim/bundle/vim-fugitive

"PLUGIN: https://github.com/jlfwong/vim-mercenary
set runtimepath+=$HOME/.vim/bundle/vim-mercenary

"PLUGIN: https://github.com/myint/clang-complete
" Requires python2
"set runtimepath+=$HOME/.vim/bundle/clang_complete
let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib'

"PLUGIN: https://github.com/sheerun/vim-polyglot
set runtimepath+=$HOME/.vim/bundle/vim-polyglot

" IF syntastic is used
"let g:syntastic_cpp_compiler_options = ' -std=c++11 -D_GLIBCXX_USE_NANOSLEEP'
"let g:syntastic_cpp_compiler_options .= ' `pkg-config --cflags --libs cairo'
"let g:syntastic_cpp_compiler_options .= ' `pkg-config --cflags --libs cairomm-1.0'

"let g:syntastic_cpp_compiler = 'clang++'
"let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'


" must be after plugins for ftdetect folders in runtimepaths to be used
filetype indent plugin on
syntax on
"syntax sync minlines=500
syntax sync fromstart


"""""""""""""""""""""""""""""""""""""""""" Dynamic Keyboard Mapping

autocmd BufEnter *.tjp call TaskJuggler()
autocmd BufEnter *.md call Markdown()
"autocmd BufEnter *.txt call ReStructuredText()
autocmd BufEnter *.rst call ReStructuredText()
autocmd BufEnter *.twig setf php
autocmd BufEnter *.htm call Html()
autocmd BufEnter *.html call Html()
autocmd BufEnter *.cpp set formatprg=astyle\ -s4pb
autocmd BufEnter *.tjp call TaskJuggler()

function! TaskJuggler()
  set ft=tjp
  "nnoremap <leader>v :update<cr>:silent !tj3 '%' && open %:r.html<cr>
  nnoremap <leader>v :update<cr>:!tj3 --no-color '%' && open %:r.html<cr>
endfunction


function! Html()
  "With vim-closetag don't need the end tag
  nmap <buffer> <localleader>b diwi<strong>p
  nmap <buffer> <localleader>i diwi<em>p
  nmap <buffer> <localleader>t diwi<tt>p
  setlocal wrap
  setlocal linebreak
  nnoremap <leader>v :!open '%'<cr>
endfunction

function! Markdown()
  setlocal wrap
  setlocal linebreak
  setlocal list
  setf markdown
  setlocal conceallevel=0

  nmap <buffer> <localleader>h yypVr=
  nmap <buffer> <localleader>j yypVr-

  nmap <buffer> <localleader>b ysiW*lysiW*
  nmap <buffer> <localleader>i ysiW*
  nmap <buffer> <localleader>t ysiW`
  "Make Link
  nmap <buffer> <localleader>l lBi<Ea>
  vnoremap <buffer> <localleader>b ysiW*lysiW*
  vnoremap <buffer> <localleader>i ysiW*
  vnoremap <buffer> <localleader>t ysiW`
  "vim-marked command
  nnoremap <buffer> <leader>v :MarkedOpen<cr>
  nnoremap <buffer> <leader>r :silent !~/redcarpet/render.rb '%' && open '%:r'.html<cr>
  nnoremap <buffer> <localleader>k :silent !~/kramdown/render.rb '%' && open '%:r'.html<cr>
  nnoremap <buffer> <leader>d :update<cr>:!pandoc -f markdown+yaml_metadata_block+simple_tables '%' -o %:r.docx && open %:r.docx<cr>
endfunction

function! ReStructuredText()
  "Make underlines for headings in reStructuredText format
  nmap <buffer> <localleader>b ysiw*lysiw*
  nmap <buffer> <localleader>i ysiw*
  nmap <buffer> <localleader>t ysiW`lysiW`
  nmap <buffer> <localleader>h yypv$r=j
  nmap <buffer> <localleader>j yypv$r-j
  nmap <buffer> <localleader>k yypv$r^j
  nmap <buffer> <localleader>l yypv$r~j
  setlocal textwidth=80
  setlocal wrap
  setlocal linebreak
  setlocal list
  setlocal filetype=rst
  nnoremap <leader>v :update<cr>:silent !rst2html.py '%' > %:r.htm && open %:r.htm<cr>
  "nnoremap <leader>p :update<cr>:!rst2pdf '%' && open %:r.pdf<cr>
  "nnoremap <leader>p :update<cr>:silent !sed -nf ~/.rst2pdf/fb.sed '%' \| rst2pdf > %:r.pdf && open %:r.pdf<cr>
  "For sed script debugging
  nnoremap <leader><s-p> :update<cr>:!sed -nf ~/.rst2pdf/fb.sed '%' \| less<cr>
  nnoremap <leader>p :update<cr>:silent !perl -0pe 's/\n\n(.*\n=+)/\n\n.. raw:: pdf\n\n  FrameBreak 250\n\n\1/g;s/\n\n(.*\n-+)/\n\n.. raw:: pdf\n\n  FrameBreak 200\n\n\1/g' '%' \| rst2pdf > %:r.pdf && open %:r.pdf<cr>
  "No page breaks
  nnoremap <leader>p :update<cr>cat '%' \| rst2pdf > %:r.pdf && open %:r.pdf<cr>
endfunction

function! Asciidoc()
  nnoremap <leader>v :update<cr>:!asciidoc -b html5 -a icons -a toc2 -a theme=flask '%'<cr>
endfunction
