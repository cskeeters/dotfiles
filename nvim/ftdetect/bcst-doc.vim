autocmd BufRead,BufNewFile * if stridx(expand("%:p:h:t"), 'bcst-doc.git') >= 0 | setfiletype markdown | endif
