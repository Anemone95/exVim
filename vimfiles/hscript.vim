 function! LoadMain(filename)
    "let s:test=input("Please input:")
    sil! exec "0r ".$VIMFILES."/c-support/templates/".a:filename
    """echo "0r ".$VIMFILES."/py-support/".a:filename
	"sil! execute "%s/<FILENAME>/".substitute(toupper(expand("%")),"\\.","_","g")."/g"
	sil! execute "%s/<FILENAME>/".toupper(expand("%:r"))."_H"."/g"
	sil! execute "%s/<DATE>/".strftime("%Y-%m-%d %H:%M")."/g"
	"sil! execute "%s/<DATE>/"."hello"."/g"
    call search("<CU","W")
    sil! execute "normal df>"
    sil! execute "startinsert!"
    "call TemplateReplTags()
endfunction   
set cindent
vmap <F2> <c-v>I//<esc>
vmap <F3> <c-v>llx
set foldmethod=indent
inoremap [[ <cr>{}<esc>i<cr><esc>kA<cr>
nmap <C-i> :call LoadMain("header.h")<cr>
