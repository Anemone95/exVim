" noremap    <buffer>  <silent>  <LocalLeader>rr         :w<enter>:!python %<enter>
 " map  <buffer>  <silent>  <F9>       :w<CR>:!python %<CR>
" imap  <buffer>  <silent>  <F9>  <C-C>:w<CR>:!python %<CR>
"map <C-i> ggO#!/usr/bin/env python<CR>#coding=utf-8<CR>#Edit by Anemone at :<cr><esc>I#<esc>o#E-mail:x565178035@126.com<esc>oif __name__ == '__main__':<cr>main(<esc>2kodef main(<esc>la:<cr>
"autocmd BufNewFile ggO#!/usr/bin/env python<CR>#coding=utf-8<CR>#Edit by Anemone at :<esc>:r !date <esc>I#<esc>o#E-mail:x565178035@126.com<esc>oif __name__ == '__main__':<cr>main(<esc>2kodef main(<esc>la:<cr>
vmap <Tab> <c-v>I<Tab><Esc>
" nmap <C-i> :call LoadTemplate("main.py")<CR>
imap <expr><c-n> pumvisible()?"\<c-n>":"\<Tab>"
function! LoadTemplate(filename)
    "let s:test=input("Please input:")
    sil! exec "0r ".$VIM."/vimfiles/".a:filename
    sil! exec "%s/<FILE_NAME>/".expand("%:t")."/g"
    sil! exec "%s/<FUN_NAME>/".expand("%:t:r")."/g"
    sil! exec "%s/<DATE>/".strftime("%Y-%m-%d %H:%M")."/g"
    sil! exec "15"
    " call search("<CU","W")
    " sil! exec "normal \"adf>"
    " sil! exec "startinsert!"
    "call TemplateReplTags()
endfunction
if line("$")==1
    call LoadTemplate("py_main.template")
endif
if match( getline(1),"django" )!=-1||match(getline(3),"django")!=-1
    set ft=python.django " For SnipMate
    map <F9> :Dmanage runserver<cr>
endif
source $VIM/vim74/indent/python.vim


" if line("$")>200
    " set foldmethod=indent
" endif
set foldmethod=expr
