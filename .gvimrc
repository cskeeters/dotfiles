if has("gui_macvim")
  " allows option to be used as alt with <M>
  set macmeta

  macmenu File.Print key=<nop>
  map <D-p> :CtrlP<CR>
  imap <D-p> <C-p>
  macmenu File.New\ Window key=<nop>
  imap <D-n> <C-n>

  macmenu File.Save key=<nop>
  imap <D-s> fd:w<CR>
  map <D-s> :w<CR>

  macmenu &File.Close key=<nop>
  nmap <D-w> :CommandW<CR>
  imap <D-w> <Esc>:CommandW<CR>
  map <A-D-Right> :bn<CR>
  map <A-D-Left> :bp<CR>
  map <D-j> :bn<CR>
  map <D-k> :bp<CR>
else
  set guifont=Monospace\ 13
endif

color solarized
"color default
"color desertEx
"color eclipse
"color fruit
"color kate
"color lightcolors
