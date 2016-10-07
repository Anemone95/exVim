set fileencoding=gbk
nmap <C-i> :call LoadTemplate("main.m")<CR>
function! LoadTemplate(filename)
    "let s:test=input("Please input:")
    sil! exec "0r ".$VIM."/vimfiles/".a:filename
    """echo "0r ".$VIMFILES."/py-support/".a:filename
    sil! execute "%s/<FILENAME>/".expand('%:t')."/g"
	sil! execute "%s/<DATE>/".strftime("%Y-%m-%d %H:%M")."/g"
    sil! execute "6"
    "call TemplateReplTags()
endfunction
if line("$")==1
    call LoadTemplate("matlab_main.template")
endif
map <F9> :!matlab<CR>
