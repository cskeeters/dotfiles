"Default : aegimrLtT  linux : aciM
set guioptions=rLt

if has("gui_macvim")
    "set guifont=Monospace\ 13

    let g:airline_powerline_fonts = 1
    "set guifont=Meslo\ LG\ S\ for\ Powerline:h15
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h15
elseif has("x11")
    set guifont=Consolas:h13
else
    set guifont=Consolas:h13
endif

" MacVim specific settings
if has("gui_macvim")
    " allows option to be used as alt with <M>
    set macmeta

    macmenu File.Print key=<nop>
    map <D-p> :CtrlP<CR>
    imap <D-p> <C-p>
    macmenu File.New\ Window key=<nop>
    imap <D-n> <C-n>

    macmenu File.Save key=<nop>
    imap <D-s> <esc>:w<CR>
    map <D-s> :w<CR>

    macmenu &File.Close key=<nop>
    nmap <D-w> :CommandW<CR>
    imap <D-w> <Esc>:CommandW<CR>
endif

