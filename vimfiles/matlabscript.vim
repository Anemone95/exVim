set fileencoding=gbk
nmap <C-i> :call LoadTemplate("main.m")<CR>
function! LoadTemplate(filename)
    "let s:test=input("Please input:")
    sil! exec "0r ".$VIM."/vimfiles/matlab-support/".a:filename
    """echo "0r ".$VIMFILES."/py-support/".a:filename
    sil! execute "%s/<FILE>/".expand('%:t')[:-3]."/g"
    sil! execute "%s/<FILENAME>/".expand('%:t')."/g"
	sil! execute "%s/<DATE>/".strftime("%Y-%m-%d %H:%M")."/g"
	"sil! execute "%s/<DATE>/"."hello"."/g"
    call search("<CU","W")
    sil! execute "normal \"bdf>"
    sil! execute "startinsert!"
    "call TemplateReplTags()
endfunction
if line("$")==1
    call LoadTemplate("main.m")
endif
map <F9> :!matlab<CR>
