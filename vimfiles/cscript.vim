set cindent
vmap <F2> <c-v>I//<esc>
vmap <F3> <c-v>llx
"autocmd FileType c inoremap { <enter>{}<esc>i<enter><enter><esc>ki<tab><space><space><space><space>i
map zz :set foldmethod=indent<cr>
inoremap [[ <cr>{}<esc>i<cr><esc>kA<cr>
nmap gm :call search("int main")<cr>k

function! LoadMain(filename)
    "let s:test=input("Please input:")
    exec "0r ".$VIM."/vimfiles/".a:filename
    """echo "0r ".$VIMFILES."/py-support/".a:filename
	sil! execute "%s/<FILE_NAME>/".expand("%:t")."/g"
    sil! execute "%s/<FUN_NAME>/".expand("%:t:r")."/g"
	sil! execute "%s/<DATE>/".strftime("%Y-%m-%d %H:%M")."/g"
    sil! execute "15"
endfunction

function! PushDeclare()
    let l:prePos=getpos(".")
    call search("}.*end of function")
    sil! execute "normal %k\"fyy"
    let l:mainPos=search("int main")
    let l:preDecWord=getreg("f")
    "call search("int main")
    "sil! execute "normal k\"fpA;jj"
    "call cursor(l:prePos[1]+1,l:prePos[2])
    let l:funName=split(l:preDecWord)[1]
    call cursor(1,0)
    let l:preDecPos=search(".* ".l:funName.".*;","",line(l:mainPos))
    if l:preDecPos
        sil! execute "normal \"fpA;jj"
        sil! execute "normal k\"add"
        call cursor(l:prePos[1],l:prePos[2])
        echo "Function has been updated..."
    else
        call cursor(mainPos-1,0)
        sil! execute "normal k\"fpA;jj"
        call cursor(l:prePos[1]+1,l:prePos[2])
        echo "Function has been declared..."
    endif
endfunction 
    nmap                                  <C-i>          :call LoadMain("main.c")<cr>

 noremap    <buffer>  <silent>  <LocalLeader>if         G:call C_InsertTemplate("idioms.function")<CR>
vnoremap    <buffer>  <silent>  <LocalLeader>if    <Esc>G:call C_InsertTemplate("idioms.function", "v")<CR>
inoremap    <buffer>  <silent>  <LocalLeader>if    <Esc>G:call C_InsertTemplate("idioms.function")<CR
 noremap    <buffer>  <silent>  <LocalLeader>ud          :call PushDeclare()<CR>

if line("$")==1
    call LoadMain("c_main.template")
endif
call SingleCompile#ChooseCompiler('c', 'gcc')
