" vim: set ft=vim:

set nocompatible
" vi-compatible sentences have two spaces after them.
set cpo+=J " Recognize sentences by two spaces after punctuation

scriptencoding utf-8
set encoding=utf-8
set fileencoding=utf-8

if &shell =~# 'fish$'
    set shell=sh
endif

set expandtab                   " tabs are spaces, not tabs (et)
set shiftwidth=4                " use indents of 4 spaces (sw)
set tabstop=4                   " an indentation every four columns (ts)
set softtabstop=4               " let backspace delete indent (sts)
" See Keyboard shortcuts to quicly change

let g:ack_wildignore=0 " Otherwise error ack.vim line 31
let g:ackprg = 'ag'
set wildignore=tags,a.out,depmod,*.so,*.a,*.o,*.dep,*.class,*.pyc
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr', '\.o', '\.dep', '\.class']

set hidden                      " Allow buffers (unsaved) in the background (like tabs)
set virtualedit=block           " Block mode allows cursor to go where spaces don't exist
set autoindent                  " indent at the same level of the previous line
set cindent
set smartindent
set nowrap                      " wrap long lines

" iTerm2 in osx likes unnamed, not unnamedplus
" NOTE: FormatMatch osx application prevents visual block selections from being
" yanked and pasted
set clipboard=unnamed

"set textwidth=80                " Used in autoformatting
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
set relativenumber
set printoptions=left:3pc,right:3pc,number:n,header:0

set showcmd " Shows partial key sequences

set scrolloff=3                 " minimum lines to keep above and below cursor
set scrolljump=5                " lines to scroll when cursor leaves screen


" Highlight problematic whitespace
set list
set listchars=tab:,.,trail:.,extends:#,nbsp:.
if has('multi_byte')
    set listchars=trail:·,precedes:«,extends:»,tab:▸·
    set listchars+=nbsp:·
    "set listchars+=eol:↲
endif


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

" Status {
set laststatus=2

" Broken down into easily includeable segments
set statusline=%<%f\    " Filename
set statusline+=%w%h%m%r " Options
set statusline+=\ [%{&ff}/%Y]            " filetype
set statusline+=\ [%{getcwd()}]          " current dir
set statusline+=%=%-14.(%l,%c%)\ %p%%  " Right aligned file nav info

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

set dictionary=/usr/share/dict/words
set thesaurus=~/dotfiles/mthesaur.txt
set spelllang=en_us

" Help escape take effect immediately
" If on MAC, may need to
" mv /etc/vimrc /etc/vimrc.disabled
set timeoutlen=1000 ttimeoutlen=0

""""""""""""""""""""""""""""""""""""""""""""""""" Keyboard Shortcuts
let mapleader = ','

" Bookmarks
"nnoremap <leader>en :e ~/Dropbox/notes/README.md<cr>:lcd %:p:h<cr>:CtrlP<CR><F5>
nnoremap <leader>gn :CtrlP ~/Dropbox/notes<CR>
nnoremap <leader>gb :CtrlP ~/Documents/nci/bcst<CR>
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap gsv :source $MYVIMRC<cr>
nnoremap <leader>eb :e $MYVIMRC.plugins<cr>


" Wrapped lines goes down/up to next row, rather than next line in file.
"nnoremap j gj
"nnoremap k gk

nnoremap <leader>2 :set sw=2 ts=2 sts=2<cr>
nnoremap <leader>3 :set sw=3 ts=3 sts=3<cr>
nnoremap <leader>4 :set sw=4 ts=4 sts=4<cr>
nnoremap <leader>8 :set sw=8 ts=8 sts=8<cr>
nnoremap <leader>t :setlocal noexpandtab<cr>
":set et
":set noet
":retab to convert

nnoremap <leader>W :set wrap<cr>:set linebreak<cr>:set nolist<cr>
nnoremap <leader>nW :set nowrap<cr>
nnoremap <leader>p :set spell!<cr>

inoremap <C-s> <esc>:update<CR>
noremap <Leader>s :update<CR>
noremap <Leader>q :q<CR>
nnoremap <leader>mw :bd!<cr>
nnoremap <leader>w :bd<cr>
nmap <C-j> :bn<CR>
nmap <C-k> :bp<CR>

nnoremap <leader>h :noh<cr>
nnoremap <C-l> :noh<cr>

set pastetoggle=<F10>           " pastetoggle (sane indentation on pastes)

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$
" Put all lines selected on one line and then format that line
vnoremap <localleader>f Jgqj
nnoremap <localleader>w :%s/\s\+$//<cr>

" Shortcuts
" Change Working Directory to that of the current file
cnoremap Gb ~/Documents/nci/bcst/
cnoremap Gn ~/Dropbox/notes/
cnoremap Gv ~/.vim/bundle
noremap gcd :lcd %:p:h<cr>

nnoremap gb ^
nnoremap ge $

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

vno v <esc>

nnoremap <leader>. z=1<cr><cr>

"Paste helper
imap <S-Insert> <MiddleMouse>
set mouse=a


iab @@ goobsoft@gmail.com
iab ccopy Copyright 2014 Chad Skeeters, all rights reserved.

iab <expr> dts strftime("%FT%T%z")
iab <expr> ds strftime("%Y-%b-%d")

noremap <leader>k :make -j4 \| cwindow<CR>
noremap <leader>/ :Ack

" C++ helper
nnoremap <Leader>d istd::<ESC>

" need to 'set clipboard=' when copy and pasting control characters
" convert signature to method in cpp
" Class name needs to be saved in c register
let @m = "^d0W\"cPa::f;xi{}j"
let @s = "^Wf:dwdF i A;0j"

" vimdiff stuff
" unmap ]c from python.vim
autocmd BufWritePost * if &diff == 1 | diffupdate | endif
"nnoremap <leader>dg :diffget 2<cr>

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" Some helpers to edit mode
" http://vimcasts.org/e/14
" Chad: this is not used when CtrlP is available
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%

" Easier horizontal scrolling
map zl zL
map zh zH

" Number Base translations with 0x notation for hex
nmap gd :.,.!xargs -I {} -n1 bash -c "echo 'ibase=16; {}' \| bc"
nmap gh :.,.!xargs -I {} -n1 bash -c "echo 'obase=16; {}' \| bc"
vmap gd :!xargs -I {} -n1 bash -c "echo 'ibase=16; {}' \| bc"gv
vmap gh :!xargs -I {} -n1 bash -c "echo 'obase=16; {}' \| bc"gv

" Number Base translations with 0x notation for hex
nmap gxd :.,.!xargs -I {} -n1 bash -c "echo {} \| python -i 2>&1 \| sed -nE 's/>>> (.+)/\1/p'"
nmap gxh :.,.!xargs -I {} -n1 bash -c "echo '\"0x\%02X\" \% {}' \| python -i 2>&1 \| sed -nE \"s/>>> '(.+)'/\1/p\""
vmap gxd :!xargs -I {} -n1 bash -c "echo {} \| python -i 2>&1 \| sed -nE 's/>>> (.+)/\1/p'"gv
vmap gxh :!xargs -I {} -n1 bash -c "echo '\"0x\%02X\" \% {}' \| python -i 2>&1 \| sed -nE \"s/>>> '(.+)'/\1/p\""gv

autocmd BufEnter * call FixKeys()
function! FixKeys()
  if expand("%") == ""
    " Allows enter to work with quickfix
    "echom "unmapping"
    silent! nunmap <enter>
  else
    "echom "mapping"
    nnoremap <enter> <S-o><esc>j
  endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" Plugins
" Update Plugins with
" cd ~/.vim/bundle
" cat ~/.vimrc | sed -nre 's/^" ?PLUGIN: ([^ \"]*)/\1/p' | sed -re 's/.*\/(.*)/\1/' | xargs -I {} bash -c "cd {}; git pull"
" Checkout repositories with
" cd ~/.vim/bundle
" cat ~/.vimrc | sed -nre 's/^" ?PLUGIN: ([^ \"]*)/\1/p' | xargs -I {} git clone {}
" Download archives of plugins with:
" cd ~/.vim/bundle
" cat ~/.vimrc | sed -nre 's/^" ?PLUGIN: ([^ \"]*)/\1/p' | xargs -I {} bash -c "wget -q {}/archive/master.zip; unzip master.zip; rm -f master.zip"
" ls -1 | sed -re 's/(.*)-master/mv \1-master \1/' | bash
" Generate helptags
" cat ~/.vimrc | sed -nre 's/^" ?PLUGIN: [^ "]*\/([^ "]*)/helptags ~\/.vim\/bundle\/\1\/doc/p' | vim -e -s -

" This is like a plugin
" Remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

"swap word with ves
vnoremap s :call SwapShort()<cr>
function! SwapShort()
	let l:tmp = @"
	normal! gv"0d
	let @" = l:tmp
	normal! P
endfunction


let g:netrw_liststyle=1
"let g:netrw_keepdir=0

function! GrepWord(word)
    execute ':vimgrep '.a:word.' **/*.cpp **/*.c++ **/*.h **/*.java'
    copen
endfunction
nmap <leader>g :call GrepWord(expand('<cword>'))<cr>

function! GrepWordInFile(word)
    execute ':vimgrep '.a:word.' '.expand('%:p')
    copen
endfunction
nmap <leader>ig :call GrepWordInFile(expand('<cword>'))<cr>

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
map gx :call HandleURL()<cr>

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

"PLUGIN: https://github.com/alvan/vim-closetag
set runtimepath+=$HOME/.vim/bundle/vim-closetag

"PLUGIN: https://github.com/vim-scripts/argtextobj.vim
set runtimepath+=$HOME/.vim/bundle/argtextobj.vim

"PLUGIN: https://github.com/michaeljsmith/vim-indent-object
set runtimepath+=$HOME/.vim/bundle/vim-indent-object

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


"PLUGIN: https://github.com/vim-scripts/restore_view.vim
"Uses mkview to save cursor position and folds
set runtimepath+=$HOME/.vim/bundle/restore_view.vim

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
    set runtimepath+=$HOME/.vim/bundle/ack.vim
elseif executable('ack')
    let g:ackprg = 'ag --nogroup --nocolor --column'
    set runtimepath+=$HOME/.vim/bundle/ack.vim
elseif executable('ack-grep')
    let g:ackprg="ack-grep -H --nocolor --nogroup --column"
    set runtimepath+=$HOME/.vim/bundle/ack.vim
endif

"PLUGIN: https://github.com/kien/ctrlp.vim
"let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_max_files = 4000
set runtimepath+=$HOME/.vim/bundle/ctrlp.vim

"PLUGIN: https://github.com/chriskempson/base16-vim
let g:load_base16_shell = 1
let g:base16_shell_path = $HOME."/base16-builder/output/shell"
"autocmd QuitPre * execute "silent !bash ".g:base16_shell_path."/base16-default.dark.sh"
if version > 704
    autocmd QuitPre * colorscheme base16-default
endif
set runtimepath+=$HOME/.vim/bundle/base16-vim

set background=dark
let base16colorspace=256
colorscheme base16-default

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
let g:airline#extensions#tabline#enabled = 1
"iTerm2 has to have the asci and non-asci (two separate font settings) set to a powerline font
let g:airline_powerline_fonts = 1
set runtimepath+=$HOME/.vim/bundle/vim-airline

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
set runtimepath+=$HOME/.vim/bundle/vim-signify
nmap <leader>+ :SignifyToggle<cr>


"PLUGIN: https://github.com/tpope/vim-vinegar
set runtimepath+=$HOME/.vim/bundle/vim-vinegar


"PLUGIN: https://github.com/troydm/easytree.vim
let g:easytree_hijack_netrw = 0
nmap <silent> <Leader>f :EasyTree<CR>
" C/u - cd into/..
" cd - set cwd to folder
" f - find file
" O - open all subdirs
" X - Close all subdirs
" r/R - refresh from cursor/root
set runtimepath+=$HOME/.vim/bundle/easytree.vim



"PLUGIN: https://github.com/godlygeek/tabular
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a:: :Tabularize /:\zs<CR>
vmap <Leader>a:: :Tabularize /:\zs<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
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


"PLUGIN: https://github.com/kien/rainbow_parentheses.vim
nnoremap <leader>r :RainbowParenthesesToggle<cr>
set runtimepath+=$HOME/.vim/bundle/rainbow_parentheses.vim


"PLUGIN: https://github.com/SirVer/ultisnips
let g:UltiSnipsSnippetsDir = "~/.vim/bundle/vim-snippets/UltiSnips"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsExpandTrigger="<c-b>"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
set runtimepath+=$HOME/.vim/bundle/ultisnips
"PLUGIN: https://github.com/cskeeters/vim-snippets
set runtimepath+=$HOME/.vim/bundle/vim-snippets


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

" IF syntastic is used
"let g:syntastic_cpp_compiler_options = ' -std=c++11 -D_GLIBCXX_USE_NANOSLEEP'
"let g:syntastic_cpp_compiler_options .= ' `pkg-config --cflags --libs cairo'
"let g:syntastic_cpp_compiler_options .= ' `pkg-config --cflags --libs cairomm-1.0'

"let g:syntastic_cpp_compiler = 'clang++'
"let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'


" must be after plugins for ftdetect folders in runtimepaths to be used
filetype indent plugin on
syntax on


"""""""""""""""""""""""""""""""""""""""""" Dynamic Keyboard Mapping

autocmd BufNewFile,BufRead *.tjp call TaskJuggler()
autocmd BufNewFile,BufRead *.md call Markdown()
autocmd BufNewFile,BufRead *.txt call ReStructuredText()
autocmd BufNewFile,BufRead *.rst call ReStructuredText()
autocmd BufNewFile,BufRead *.htm call Html()
autocmd BufNewFile,BufRead *.html call Html()
autocmd BufNewFile,BufRead *.cpp set formatprg=astyle\ -s4pb

function! TaskJuggler()
  set ft=tjp
  "nnoremap <leader>v :update<cr>:silent !tj3 '%' && open %:r.html<cr>
  nnoremap <leader>v :update<cr>:!tj3 --no-color '%' && open %:r.html<cr>
endfunction


function! Html()
  let @b = "diwi<b>\"</b>"
  let @i = "diwi<i>\"</i>["
  let @t = "diwi<tt>\"</tt>"
  set wrap
  set linebreak
  nnoremap <leader>v :open '%'<cr>
endfunction

function! Markdown()
  " markdown bold and italic
  let @b = "ysiw*lysiw*"
  let @i = "ysiw*"
  let @t = "ysiw`"
  let @l = "i<lxA>"
  let @h = "0i# "
  let @j = "0i## "
  let @k = "0i### "
  set wrap
  set linebreak
  set nolist
  nmap <leader>b ysiw*lysiw*
  nmap <leader>i ysiw*
  nmap <leader>t ysiw`
  vnoremap <leader>b ysiw*lysiw*
  vnoremap <leader>i ysiw*
  vnoremap <leader>t ysiw`
  nnoremap <leader>v :MarkedOpen<cr>
  nnoremap <leader>d :update<cr>:!pandoc -f markdown+yaml_metadata_block+simple_tables '%' -o %:r.docx && open %:r.docx<cr>
endfunction

function! ReStructuredText()
  "Make underlines for headings in reStructuredText format
  let @b = "ysiw*lysiw*"
  let @i = "ysiw*"
  let @t = "ysiW`lysiW`"
  let @h = "yypv$r=j"
  let @j = "yypv$r-j"
  let @k = "yypv$r^j"
  let @l = "yypv$r~j"
  set wrap
  set linebreak
  set nolist
  set filetype=rst
  nnoremap <leader>v :update<cr>:silent !rst2html.py '%' > %:r.htm && open %:r.htm<cr>
  "nnoremap <leader>p :update<cr>:!rst2pdf '%' && open %:r.pdf<cr>
  "nnoremap <leader>p :update<cr>:silent !sed -nf ~/.rst2pdf/fb.sed '%' \| rst2pdf > %:r.pdf && open %:r.pdf<cr>
  "For sed script debugging
  nnoremap <leader><s-p> :update<cr>:!sed -nf ~/.rst2pdf/fb.sed '%' \| less<cr>
  nnoremap <leader>p :update<cr>:silent !perl -0pe 's/\n\n(.*\n=+)/\n\n.. raw:: pdf\n\n  FrameBreak 250\n\n\1/g;s/\n\n(.*\n-+)/\n\n.. raw:: pdf\n\n  FrameBreak 200\n\n\1/g' '%' \| rst2pdf > %:r.pdf && open %:r.pdf<cr>
endfunction

function! Asciidoc()
  nnoremap <leader>v :update<cr>:!asciidoc -b html5 -a icons -a toc2 -a theme=flask '%'<cr>
endfunction
