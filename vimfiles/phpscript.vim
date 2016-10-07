set fileformat=unix

function! LoadMainOld(filename)
    "let s:test=input("Please input:")
    sil! exec "0r ".$VIM."/vimfiles/php-support/".a:filename
    let l:pathArr=split(expand("%:p"),"\\")
    echo l:pathArr
	sil! execute "%s/<CATEGORY>/".toupper( l:pathArr[-1][0:-5] )."/g"
	sil! execute "%s/<PACKAGE>/".toupper( l:pathArr[-2] )."/g"
    sil! execute "%s/<LINK>/".l:pathArr[-2]."\\/".l:pathArr[-1]."/g"
    call search("<CU","W")
    sil! execute "normal \"adf>"
    sil! execute "startinsert!"
    "call TemplateReplTags()
endfunction

function! LoadMain(filename)
    "let s:test=input("Please input:")
    exec "0r ".$VIM."/vimfiles/".a:filename
    """echo "0r ".$VIMFILES."/py-support/".a:filename
	sil! execute "%s/<FILE_NAME>/".expand("%:t")."/g"
    sil! execute "%s/<FUN_NAME>/".expand("%:t:r")."/g"
	sil! execute "%s/<DATE>/".strftime("%Y-%m-%d %H:%M")."/g"
    sil! execute "9"
endfunction

if match(expand("%"),"func.php")!=-1
    if line("$")==1
        call LoadMain("php_main.template")
    endif
endif

" function! ExpectSpace()
    " call feedkeys("i,")
    " let l:nextchar=getchar()
    " if l:nextchar==36
        " call feedkeys("a ".nr2char(36))
    " else
        " call feedkeys("a".nr2char(l:nextchar))
    " endif
" endfunction

inoremap [[ <cr>{}<esc>i<cr><esc>kA<cr>
imap , ,<space>

nmap <C-i> :call LoadMain("main.php")<CR>

