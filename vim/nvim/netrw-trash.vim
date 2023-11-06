" Credit to Matt for trash solution
" https://vi.stackexchange.com/a/22463/4831
" https://github.com/morgant/tools-osx/blob/master/src/trash

function! NetrwDoTrash(flist)
    for path in a:flist
        call system('trash '.fnameescape(path))
    endfor
endfunction

augroup MyNetrw | au!
    autocmd FileType netrw nmap <buffer>h -
    autocmd FileType netrw nmap <buffer>l <enter>
    " TODO: Need a faster way to mark files
    " autocmd FileType netrw nmap <buffer>m mfj
    autocmd FileType netrw noremap <buffer>T :call Netrw_trash()<CR>
    autocmd FileType netrw vnoremap <buffer>T :call Netrw_vtrash()<CR>
augroup end

" implement normal mode deletion
function! Netrw_trash()
    " get selected file list (:h netrw-mf)
    let l:flist = netrw#Expose('netrwmarkfilelist')
    if l:flist is# 'n/a'
        " no selection -- get name under cursor
        let l:flist = [b:netrw_curdir . '/' . netrw#GX()]
    else
        " remove selection as files will be deleted soon
        call netrw#Call('NetrwUnmarkAll')
    endif

    call NetrwDoTrash(l:flist)

    " Manual refresh seems to be required
    "call feedkeys("\<C-l>")
    call netrw#Call('NetrwRefresh', 1, b:netrw_curdir)
endfunction

" implement delete over Visual range
function! g:Netrw_vtrash() range
    if isdirectory(b:netrw_curdir)
        " assume it's local dir
        " get all file names over selected lines
        let l:flist = []
        for l:lnum in range(a:firstline, a:lastline)
            execute l:lnum
            call add(l:flist, b:netrw_curdir . '/' . netrw#GX())
        endfor
        " do delete and then refresh view
        call NetrwDoTrash(l:flist)
        call netrw#Call('NetrwRefresh', 1, b:netrw_curdir)
        return
    endif

    " remote delete over visual range -- NOT IMPLEMENTED
    " Note: call() cannot supply non-trivial range,
    " so we have to process line range manually (sigh),
    " and then call `s:NetrwRemoteRmFile()` in a loop
endfunction

" vim: et ts=4 sts=4 sw=4
