function! dirvishmap#Mkdir()
    let dir = inputdialog("Directory name ->")
    silent execute "!mkdir -p ".dir
    normal R
    redraw!
endfunction

function! dirvishmap#Remove()
    let fullpath = getline(".")
    let confirm = inputdialog("Are you sure you want to remove ".l:fullpath."? ->", "y", "")
    if confirm == 'y'
        silent execute "!rm -rf '".l:fullpath."'"
        " Reloads the current directory in dirvish
        normal R
        redraw!
    else
        echo "Canceled Remove"
    endif
endfunction

function! dirvishmap#RemoveAll()
    normal! gv
    let start = line("'<")
    let end = line("'>")

    let filelist=[]

    let i=start
    while i <= end
        let filelist+=[getline(i)]
        let i+=1
    endwhile

    let confirm = inputdialog("Are you sure you want to remove ALL SELECTED files? ->", "y", "")
    if confirm == 'y'

        "Handle spaces in filename
        let filelist = map(filelist, '"\"".v:val."\""')

        execute "normal! \<esc>"
        execute "normal! ".start."G"
        silent execute "!rm -rf ".join(l:filelist, " ")

        " Reloads the current directory in dirvish
        normal R
        redraw!
    else
        echo "Canceled Remove"
    endif
endfunction
