autocmd BufRead,BufNewFile * if stridx(expand("%:p:h:t"), 'bcst-doc') >= 0 | setfiletype markdown | endif
