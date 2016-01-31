set fileformat=unix

function! LoadMain(filename)
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

if match(expand("%"),"func.php")!=-1
    if line("$")==1
        call LoadMain("main.php")
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

