function! LoadTemplate(filename)
    "let s:test=input("Please input:")
    sil! exec "0r ".g:VIMFILES_PATH."/".a:filename
    sil! exec "%s/<FILE_NAME>/".expand("%:t")."/g"
    sil! exec "%s/<FUN_NAME>/".expand("%:t:r")."/g"
    sil! exec "%s/<DATE>/".strftime("%Y-%m-%d %H:%M")."/g"
    sil! exec "15"
endfunction
if line("$")==1
    call LoadTemplate("py_main.template")
endif
if match( getline(1),"django" )!=-1||match(getline(3),"django")!=-1
    " map <F9> :Dmanage runserver<cr>
endif
if match( getline(10),"scrapy" )!=-1||match(getline(6),"scrapy")!=-1
    map <F9> :!python main.py<cr>
endif
