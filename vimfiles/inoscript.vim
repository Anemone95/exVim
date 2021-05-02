function! Compile()
    let file=getcwd().'/'.getreg('%')
    py t1=threading.Thread(target=startCompile,args=())
    py t1.start()
    exec "!arduino \"".file."\""
endfunction

function! LoadMain(filename)
    "let s:test=input("Please input:")
    sil! exec "0r ".g:VIMFILES_PATH."/".a:filename
    """echo "0r ".$VIMFILES."/py-support/".a:filename
	sil! execute "%s/<FILE_NAME>/".expand("%:t")."/g"
    sil! execute "%s/<FUN_NAME>/".expand("%:t:r")."/g"
	sil! execute "%s/<DATE>/".strftime("%Y-%m-%d %H:%M")."/g"
    sil! execute "10"
endfunction

" noremap <F9> :w<cr>:call Compile()<CR>

if line("$")==1
    call LoadMain("ino_main.template")
endif
