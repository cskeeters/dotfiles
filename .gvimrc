if has("gui_macvim")
  " allows option to be used as alt with <M>
  set macmeta

  let g:airline_powerline_fonts = 1
  "set guifont=Meslo\ LG\ S\ for\ Powerline:h15
  set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h15

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
  map <A-D-Right> :bn<CR>
  map <A-D-Left> :bp<CR>
  imap <D-j> :bn<CR>
  imap <D-k> :bp<CR>
else
  set guifont=Monospace\ 13
endif
